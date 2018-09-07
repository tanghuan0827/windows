package com.lvoyee.crud.service;

import com.lvoyee.crud.bean.Pap805;

import java.util.List;

/**
* 描述： 服务实现层接口
* @author Ay
* @date 2017/05/03
*/

public interface Pap805Service {

    /**
     * 查询所有的员工
     */
    public List<Pap805> getAll(Pap805 pap805);




    void save(Pap805 pap805);


    void pap805BatchUpdate(List<Pap805> list);

    List<Pap805> getPart(Integer startRow, Integer limit);

    void insertBatch(List<Pap805> list);


    List<Pap805> getClose();
}
