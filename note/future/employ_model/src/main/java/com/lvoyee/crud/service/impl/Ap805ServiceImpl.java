package com.lvoyee.crud.service.impl;

import com.lvoyee.crud.bean.Ap805;
import com.lvoyee.crud.dao.Ap805Mapper;
import com.lvoyee.crud.service.Ap805Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


/**
* 描述： 服务实现层
* @author Ay
* @date 2017/05/03
*/
@Service
public class Ap805ServiceImpl implements Ap805Service {

    @Autowired
    private Ap805Mapper ap805Mapper;

    public List<Ap805> getAll(Ap805 ap805) {
        return ap805Mapper.getAll(ap805);
    }

    public void save(Ap805 ap805) {
        ap805Mapper.save(ap805);
    }

    public void ap805BatchUpdate(List<Ap805> list) {
        ap805Mapper.ap805BatchUpdate(list);
    }

    public List<Ap805> getPart(Integer startRow, Integer limit) {
        return ap805Mapper.getPart(startRow, limit);
    }

    public void insertBatch(List<Ap805> list) {
        //判断是否插入主键是否含有值，自增，所以用不同的方法
        if (list.size() > 0){
            ap805Mapper.insertBatchHaveId(list);
        }else{
            ap805Mapper.insertBatch(list);
        }
    }

    public List<Ap805> getOne() {
        return ap805Mapper.getOne("海通期货");
    }

}
