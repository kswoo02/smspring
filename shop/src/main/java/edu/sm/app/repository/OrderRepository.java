package edu.sm.app.repository;
import edu.sm.app.dto.Order;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface OrderRepository {

    List<Order> findMonthlySales();

}
