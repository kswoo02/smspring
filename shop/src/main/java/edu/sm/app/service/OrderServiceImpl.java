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
    public List<Order> getMonthlySales() {
        return orderRepository.findMonthlySales();
    }
}
