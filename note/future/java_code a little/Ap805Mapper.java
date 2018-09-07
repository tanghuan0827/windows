package com.lvoyee.crud.dao;

import com.lvoyee.crud.bean.Ap805;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface Ap805Mapper {


    List<Ap805> getAll(Ap805 ap805);



    void save(Ap805 ap805);


    void ap805BatchUpdate(List<Ap805> list);

    List<Ap805> getPart(@Param("startRow") Integer startRow,@Param("limit") Integer limit);

    void insertBatch(List<Ap805> list);

    void insertBatchHaveId(List<Ap805> list);

    List<Ap805> getOne(String str);
}
