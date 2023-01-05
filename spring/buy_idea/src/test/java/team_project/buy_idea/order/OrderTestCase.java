package team_project.buy_idea.order;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import team_project.buy_idea.controller.order.request.AddressRequest;
import team_project.buy_idea.controller.order.request.OrderInfoRequest;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.repository.order.OrderInfoRepository;
import team_project.buy_idea.service.order.OrderInfoService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class OrderTestCase {

    @Autowired
    private OrderInfoService orderInfoService;

    @Autowired
    private OrderInfoRepository orderInfoRepository;

    @Test
    public void orderRegister() {

        List<OrderInfoRequest> orderInfoRequestList = new ArrayList<>();

        orderInfoRequestList.add(new OrderInfoRequest("쏘쏘", 19L,2,"입금완료"));
        orderInfoRequestList.add(new OrderInfoRequest("쏘쏘",20L,1,"입금완료"));
        orderInfoRequestList.add(new OrderInfoRequest("쏘쏘",17L,4,"배송중"));
        orderInfoRequestList.add(new OrderInfoRequest("쏘쏘",15L,2,"배송완료"));


        AddressRequest addressRequest = new AddressRequest(
                 "쏘", "01012345678", "NewYork", "소호로", "303동", "07070");


        System.out.println("orderRegister orderInfo :  " + orderInfoRequestList);
        System.out.println("orderRegister request :  " + addressRequest);

        orderInfoService.register(addressRequest, orderInfoRequestList);
    }

    @Test
    public void genterateOrderNoTest() {
        System.out.println(orderInfoRepository.findTopByOrderByIdDesc());


        String currentDate = DateTimeFormatter.ofPattern("yyyyMMdd").format(LocalDateTime.now());

        //ex)YYYYMMDD000000001
        OrderInfo maybeOrderInfo = orderInfoRepository.findTopByOrderByIdDesc();
        String lastOrderNo = maybeOrderInfo.getOrderNo();
        String lastOrder = lastOrderNo.substring(lastOrderNo.length()-9);
        String lastDate = lastOrderNo.substring(0,8);

        String setOrderNo = null;

        if ( lastDate.equals(currentDate) ) {
            int setLastOrder = Integer.parseInt(lastOrder) + 1;
            String tmp = String.format("%09d",setLastOrder);
            setOrderNo = lastDate + tmp;
        }

        System.out.println(setOrderNo);
    }
}
