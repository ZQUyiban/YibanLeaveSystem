package com.yiban.controller;

import cn.yiban.open.Authorize;
import com.yiban.dto.Result;
import com.yiban.entity.Student;
import com.yiban.exception.*;
import com.yiban.service.handle.GetInfo;
import com.yiban.service.handle.IdentityHandle;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
@Controller
@RequestMapping(value = "/leave")
public class BeginController {

    private static final String appKey = "6e5022b516e51935";
    private static final String appSecret = "7eafe47e5c585ef1ad6b3e3bd3aff408";
    private static final String callbackUrl = "http://localhost:8080/leave/index";

    @Autowired
    private IdentityHandle identityHandle;

    private Logger logger = LoggerFactory.getLogger(BeginController.class);

    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //授权验证
        Authorize authorize = new Authorize(appKey, appSecret);
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        logger.info("获取的code：{}", code);
        if (code == null || "".equals(code.trim())) {
            String url = authorize.forwardurl(callbackUrl, "test", Authorize.DISPLAY_TAG_T.WEB);
            return "redirect:" + url;
        } else {
            JSONObject object = JSONObject.fromObject(authorize.querytoken(code, callbackUrl));
            logger.info("授权后的toke：{}",object);
            if (object.has("access_token")) {
                String accessToken = object.getString("access_token");
                String userId = object.getString("userid");
                session.setAttribute("yiban_id", userId);
                session.setAttribute("accessToken", accessToken);
                //添加密匙
                session.setAttribute("yiban_id_key",identityHandle.key(userId));
                return "redirect:/leave/toLeave";
            } else {
                return "false";
            }
        }
    }

    /**
     * 用户同意授权后跳转到相应页面
     *
     * @param session 获取session中的易班id和accessToken
     * @return 判断用户身份再跳转到相应页面
     */
    @RequestMapping(value = "/toLeave", method = RequestMethod.GET)
    public ModelAndView studentIndex(HttpSession session) {
        Result result = null;
        ModelAndView modelAndView = new ModelAndView();
        /*
         * 获取用户id和accessToken
         */
        String yibanId = (String) session.getAttribute("yiban_id");
        String accessToken = (String) session.getAttribute("accessToken");
        session.removeAttribute("accessToken");

        try {
            /*
             * 根据id进行身份判断
             * 如果identityHandle.isTeacher方法返回true，说明用户是教师，跳转到教师页面
             * 返回false，进行下一步学生身份判断
             */
            if (identityHandle.isTeacher(yibanId)) {
                result = new Result(true, "教师");
                modelAndView.addObject("result", result);
                //TODO 添加跳转地址
                return modelAndView;
            }
            Student student = identityHandle.select(yibanId);
            /*
             * 判断是否为学生，如果获取的信息不为空，直接跳转
             */
            if (student != null) {
                modelAndView.addObject("result", new Result(true, student));
                modelAndView.setViewName("student/student");
                return modelAndView;
            } else {
                /*
                 * 数据库中没有该学生信息,发送请求,查找个人信息
                 */
                GetInfo info = new GetInfo();
                Map<String, String> myInfo = info.getMyInfo(accessToken);
                if ("success".equals(myInfo.get("status"))) {

                    if (myInfo.get("yb_studentid") != null && !"".equals(myInfo.get("yb_studentid").trim())) {
                        //学生id不为空，跳转到学生页面，传值
                        student = new Student();
                        student.setYibanId(yibanId);
                        student.setStudentId(myInfo.get("yb_studentid"));
                        student.setName(myInfo.get("yb_realname"));
                        student.setDepartment(myInfo.get("yb_collegename"));
                        student.setClassName(myInfo.get("yb_classname"));
                        logger.info("学生信息：{}",student.toString());
                        identityHandle.insert(student);
                        result = new Result(true, student);
                        modelAndView.setViewName("student/student");
                        modelAndView.addObject("result", result);
                        return modelAndView;

                    } else {
                        //没有学号，默认是教师
                        result = new Result(true, "教师");
                        /*
                         * TODO 数据库中没有班级与教师的易班id对应的信息，跳转后的信息一样是无法处理的
                         */
                        modelAndView.setViewName("teacher/teacher");
                        modelAndView.addObject("result", result);
                        return modelAndView;
                    }
                } else {
                    //提示完成校方认证
                    result = new Result(false, "未完成校方认证");
                    //TODO 添加跳转地址
                    modelAndView.addObject("result", result);
                    return modelAndView;
                }
            }
        } catch (SendException | RequestInfoException e1) {
            result = new Result(false, "获取信息发送错误，请稍后重试");
            modelAndView.addObject("result", result);
            //TODO 添加跳转地址
            return modelAndView;
        } catch (SystemRunTimeException e3) {
            result = new Result(false, "系统发生异常，请稍后重试");
            modelAndView.addObject("result", result);
            //TODO 添加跳转地址
            return modelAndView;
        }
    }
}
