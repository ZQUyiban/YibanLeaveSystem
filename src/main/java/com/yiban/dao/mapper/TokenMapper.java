package com.yiban.dao.mapper;

import com.yiban.bean.Token;

public interface TokenMapper {
    String selectToken(String type);
    void addToken(Token token);
}