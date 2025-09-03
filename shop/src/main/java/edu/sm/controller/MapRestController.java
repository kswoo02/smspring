package edu.sm.controller;

import edu.sm.app.dto.Marker;
import edu.sm.app.service.MarkerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
public class MapRestController {
    final MarkerService markerService;
    @RequestMapping("/getaddrshop")
    public Object getaddrshop(@RequestParam("addr") String addr, @RequestParam("type") int type) throws Exception {
        log.info(addr+" : "+type);
        // 해당 주소로 데이터 베이스에서 정보를 조회 한다.
        // List 담아서 리턴 한다.
        return "ok";
    }
    @RequestMapping("/getmarkers")
    public Object getMarkers(@RequestParam("target") int target) throws Exception {
        List<Marker> list = markerService.findByLoc(target);
        return list;
    }
}







