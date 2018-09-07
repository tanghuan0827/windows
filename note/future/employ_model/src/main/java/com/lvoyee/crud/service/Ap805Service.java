package com.lvoyee.crud.service;

import com.lvoyee.crud.bean.Ap805;

import java.util.List;

/**
* 描述： 服务实现层接口
* @author Ay
* @date 2017/05/03
*/

public interface Ap805Service {

    /**
     * 查询所有的员工
     */
    public List<Ap805> getAll(Ap805 ap805);




    void save(Ap805 ap805);


    void ap805BatchUpdate(List<Ap805> list);

    List<Ap805> getPart(Integer startRow, Integer limit);

    void insertBatch(List<Ap805> list);


    List<Ap805> getOne();
}
