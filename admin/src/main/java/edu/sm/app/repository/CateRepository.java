package edu.sm.app.repository;


import com.github.pagehelper.Page;
import edu.sm.app.dto.Cate;
import edu.sm.app.dto.Product;
import edu.sm.app.dto.ProductSearch;
import edu.sm.common.frame.SmRepository;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CateRepository extends SmRepository<Cate, Integer> {
    @Select("SELECT * FROM cate")
    List<Cate> selectAll() throws Exception;
    @Insert("INSERT INTO cate VALUES (#{cateId}, #{cateName})")
    void insert(Cate cate) throws Exception;
    @Update("UPDATE cate SET cate_name=#{cateName} where cate_id = #{cateId}")
    void update(Cate cate) throws Exception;
    @Delete("DELETE FROM cate WHERE cate_id=#{id}")
    void delete(Integer id) throws Exception;
    @Select("SELECT * FROM cate WHERE cate_id = #{id}")
    Cate select(Integer id) throws Exception;;

}