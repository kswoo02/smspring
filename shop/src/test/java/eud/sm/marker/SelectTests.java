package eud.sm.marker;

import eud.sm.app.dto.Marker;
import eud.sm.app.service.MarkerService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class SelectTests {
    @Autowired
    MarkerService markerService;

    @Test
    void contextLoads() {
        try {
            List<Marker> list = markerService.get();
            list.forEach(System.out::println);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
