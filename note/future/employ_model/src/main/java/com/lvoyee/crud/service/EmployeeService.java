package com.lvoyee.crud.service;

import com.lvoyee.crud.bean.Employee;

import java.util.List;


public interface EmployeeService {

    /**
     * 查询所有的员工
     */
    public List<Employee> getAll();

    void deleteEmp(Integer id);

    Employee getEmp(Integer id);

    void updateEmp(Employee employee);

    void save(Employee employee);

    void deleteBatch(List<Integer> del_ids);

    void employeeBatchUpdate(List<Employee> list);

    List<Employee> getPart(Integer startRow, Integer limit);

    void insertBatch(List<Employee> listE);
}
