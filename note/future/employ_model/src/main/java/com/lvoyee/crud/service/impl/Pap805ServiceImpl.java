package com.lvoyee.crud.service.impl;

import com.lvoyee.crud.bean.Pap805;
import com.lvoyee.crud.dao.Pap805Mapper;
import com.lvoyee.crud.service.Pap805Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


/**
* 描述： 服务实现层
* @author Ay
* @date 2017/05/03
*/
@Service
public class Pap805ServiceImpl implements Pap805Service {

    @Autowired
    private Pap805Mapper pap805Mapper;

    public List<Pap805> getAll(Pap805 pap805) {
        return pap805Mapper.getAll(pap805);
    }

    public void save(Pap805 pap805) {
        pap805Mapper.save(pap805);
    }

    public void pap805BatchUpdate(List<Pap805> list) {
        pap805Mapper.pap805BatchUpdate(list);
    }

    public List<Pap805> getPart(Integer startRow, Integer limit) {
        return pap805Mapper.getPart(startRow, limit);
    }

    public void insertBatch(List<Pap805> list) {
        //判断是否插入主键是否含有值，自增，所以用不同的方法
        if (list.size() > 0){
            pap805Mapper.insertBatchHaveId(list);
        }else{
            pap805Mapper.insertBatch(list);
        }
    }

    public List<Pap805> getClose() {
        return pap805Mapper.getClose();
    }

}
