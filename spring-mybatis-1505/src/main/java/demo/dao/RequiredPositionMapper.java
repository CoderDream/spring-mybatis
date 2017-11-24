package demo.dao;

import demo.entity.RequiredPosition;

public interface RequiredPositionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RequiredPosition record);

    int insertSelective(RequiredPosition record);

    RequiredPosition selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RequiredPosition record);

    int updateByPrimaryKey(RequiredPosition record);
}