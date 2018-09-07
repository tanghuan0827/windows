package ${package_name}.service;

import ${package_name}.bean.${table_name};

import java.util.List;

/**
* 描述：${table_annotation} 服务实现层接口
* @author ${author}
* @date ${date}
*/

public interface ${table_name}Service {

    /**
     * 查询所有的员工
     */
    public List<${table_name}> getAll(${table_name} ${table_name?uncap_first});




    void save(${table_name} ${table_name?uncap_first});


    void ${table_name?uncap_first}BatchUpdate(List<${table_name}> list);

    List<${table_name}> getPart(Integer startRow, Integer limit);

    void insertBatch(List<${table_name}> list);


}
