package com.lvoyee.crud.dao;

import com.lvoyee.crud.bean.Pap805;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface Pap805Mapper {


    List<Pap805> getAll(Pap805 pap805);



    void save(Pap805 pap805);


    void pap805BatchUpdate(List<Pap805> list);

    List<Pap805> getPart(@Param("startRow") Integer startRow,@Param("limit") Integer limit);

    void insertBatch(List<Pap805> list);

    void insertBatchHaveId(List<Pap805> list);

    List<Pap805> getClose();
}
