package com.tlgc.mapper;

import com.tlgc.entity.Admin;
import com.tlgc.entity.User;
import org.apache.ibatis.annotations.*;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;

/**
 * Created by TONY on 2017/10/2.
 */
public interface UserMapper {
    public List<Admin> getAll();

    public Integer userUpdate(@Param("id") Integer id,@Param("username") String username,@Param("fullname") String fullname,@Param("password") String password,@Param("roleId") Integer roleId);

    @Insert("INSERT INTO TLG_User(username,fullname,password,roleId,createTime)" +
            "VALUES(#{username},#{fullname},#{password},#{roleId})")
    public Integer userAdd(@Param("username") String username,@Param("fullname") String fullname,@Param("password") String password,@Param("roleId") Integer roleId);

    @Update("update tlg_user set isdelete=1 where id=${id}")
    public Integer userDel(@Param("id") Integer id);

    @Transactional
    @Update("update tlg_user set city='${city}' where id=${userId}")
    public Integer updateCity(@Param("userId") Integer userId, @Param("city") String city);

    @Select("select id,username,password,fullname,roleId from tlg_user where username=#{username} and isDelete=0 ")
    @Results({
            @Result(id=true,property="id",column="id"),@Result(property="username",column="username"),
            @Result(property="password",column="password"),@Result(property="fullname",column="fullname"),
            @Result(property="roleId",column="roleId"),
            @Result(property="role",column="roleId",one=@One(select="com.tlgc.mapper.RoleMapper.getRoleById"))
    })
    public User getUserByUsername(String username);

    @Select("select id,username,password,fullname,roleId from tlg_user where isDelete=0 and id>2")
    @Results({
            @Result(id=true,property="id",column="id"),@Result(property="username",column="username"),
            @Result(property="password",column="password"),@Result(property="fullname",column="fullname"),
            @Result(property="role",column="roleId",one=@One(select="com.tlgc.mapper.RoleMapper.getRoleById"))
    })
    public List<HashMap>  getUserList();
}
