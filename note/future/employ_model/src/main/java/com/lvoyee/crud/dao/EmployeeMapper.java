package com.lvoyee.crud.dao;

import com.lvoyee.crud.bean.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {


    List<Employee> getAll();

    void deleteEmp(Integer id);

    Employee getEmp(Integer id);

    void updateEmp(Employee employee);

    void save(Employee employee);

    void deleteBatch(List<Integer> del_ids);

    void employeeBatchUpdate(List<Employee> list);

    List<Employee> getPart(@Param("startRow") Integer startRow,@Param("limit") Integer limit);

    void insertBatch(List<Employee> listE);
}
