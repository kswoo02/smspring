package edu.sm.app.service;

import edu.sm.app.dto.Order;
import edu.sm.app.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {


    private final OrderRepository orderRepository;

    @Override
    public List<Order> getMonthlySales() { // [수정] 반환 타입을 List<Order>로 변경
        return orderRepository.findMonthlySales();
    }
}
