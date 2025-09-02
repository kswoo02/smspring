package eud.sm.app.service;

import eud.sm.app.dto.Marker;
import eud.sm.app.repository.MarkerRepository;
import eud.sm.common.frame.SmService;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
@Service
@RequiredArgsConstructor
public class MarkerService implements SmService<Marker, Integer> {

    final MarkerRepository markerRepository;

    @Override
    public void register(Marker marker) throws Exception {
        markerRepository.insert(marker);
    }

    @Override
    public void modify(Marker marker) throws Exception {
        markerRepository.update(marker);
    }

    @Override
    public void remove(Integer integer) throws Exception {
        markerRepository.delete(integer);
    }

    @Override
    public List<Marker> get() throws Exception {
        return markerRepository.selectAll();
    }

    @Override
    public Marker get(Integer integer) throws Exception {
        return markerRepository.select(integer);
    }
}












