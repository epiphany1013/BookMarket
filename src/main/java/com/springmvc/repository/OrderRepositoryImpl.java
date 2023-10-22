package com.springmvc.repository;

import com.springmvc.domain.Order;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class OrderRepositoryImpl implements OrderRepository {
    private Map<Long, Order> listOfOrders;
    private long nextOrderId;

    public OrderRepositoryImpl() {
        listOfOrders = new HashMap<Long, Order>();
        nextOrderId = 2000;
    }

    public Long saveOrder(Order order) {
        order.setOrderId(getNextOrderId());
        return order.getOrderId();
    }

    private synchronized long getNextOrderId() {
        return nextOrderId++;
    }
}
