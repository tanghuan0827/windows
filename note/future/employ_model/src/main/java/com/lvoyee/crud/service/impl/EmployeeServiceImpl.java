package com.lvoyee.crud.service.impl;

import com.lvoyee.crud.bean.Employee;
import com.lvoyee.crud.dao.EmployeeMapper;
import com.lvoyee.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.getAll();
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteEmp(id);
    }

    public Employee getEmp(Integer id) {
        return employeeMapper.getEmp(id);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateEmp(employee);
    }

    public void save(Employee employee) {
        employeeMapper.save(employee);
    }

    public void deleteBatch(List<Integer> del_ids) {
        employeeMapper.deleteBatch(del_ids);
    }

    public void employeeBatchUpdate(List<Employee> list) {
        employeeMapper.employeeBatchUpdate(list);
    }

    public List<Employee> getPart(Integer startRow, Integer limit) {
        return employeeMapper.getPart(startRow, limit);
    }

    public void insertBatch(List<Employee> listE) {
        employeeMapper.insertBatch(listE);
    }
}
