package edu.sm.cate;

import edu.sm.app.dto.Cate;
import edu.sm.app.service.CateService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class SelectTest {

    @Autowired
    CateService cateService;

    @Test
    void contextLoads() throws Exception {
        Cate ncate = Cate.builder().cateId(40).cateName("가방").build();

        cateService.register(ncate);

        cateService.remove(40);

        Cate ucate = Cate.builder().cateId(10).cateName("하의").build();
        cateService.modify(ucate);

        List<Cate> list = null;
        list = cateService.get();
        list.forEach(System.out::println);

        Cate cate = null;
        cate = cateService.get(10);
        System.out.println(cate);
    }

}
