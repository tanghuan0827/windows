package com.lvoyee.crud.service.impl;

import com.lvoyee.crud.bean.Department;
import com.lvoyee.crud.dao.DepartmentMapper;
import com.lvoyee.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;


    public List<Department> getDepts() {
        return departmentMapper.getDepts();
    }
}
