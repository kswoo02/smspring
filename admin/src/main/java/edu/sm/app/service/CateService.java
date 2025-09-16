package edu.sm.app.service;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.Cate;
import edu.sm.app.dto.Product;
import edu.sm.app.dto.ProductSearch;
import edu.sm.app.repository.CateRepository;
import edu.sm.app.repository.ProductRepository;
import edu.sm.common.frame.SmService;
import edu.sm.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CateService implements SmService<Cate, Integer> {

    final CateRepository cateRepository;


    @Override
    public void register(Cate cate) throws Exception {
        cateRepository.insert(cate);
    }

    @Override
    public void modify(Cate cate) throws Exception {
        cateRepository.update(cate);
    }

    @Override
    public void remove(Integer integer) throws Exception {
        cateRepository.delete(integer);
    }

    @Override
    public List<Cate> get() throws Exception {
        return cateRepository.selectAll();
    }

    @Override
    public Cate get(Integer integer) throws Exception {
        return cateRepository.select(integer);
    }
}