package com.yiban.entity;

import java.io.Serializable;

/**
 * 班级表实体对象
 */
public class ClassTable implements Serializable {

    private static final long serialVersionUID = -2890008160294451071L;
    //班级ID
    private String classId;
    //班级对应的班主任或者辅导员的易班ID
    private String teacherYibanId;

    @Override
    public String toString() {
        return "ClassTable{" +
                "classId='" + classId + '\'' +
                ", teacherYibanId='" + teacherYibanId + '\'' +
                '}';
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getTeacherYibanId() {
        return teacherYibanId;
    }

    public void setTeacherYibanId(String teacherYibanId) {
        this.teacherYibanId = teacherYibanId;
    }
}
