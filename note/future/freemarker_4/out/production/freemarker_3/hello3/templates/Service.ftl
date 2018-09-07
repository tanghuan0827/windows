package ${package_name}.service.impl;

import ${package_name}.bean.${table_name};
import ${package_name}.dao.${table_name}Mapper;
import ${package_name}.service.${table_name}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


/**
* 描述：${table_annotation} 服务实现层
* @author ${author}
* @date ${date}
*/
@Service
public class ${table_name}ServiceImpl implements ${table_name}Service {

    @Autowired
    private ${table_name}Mapper ${table_name?uncap_first}Mapper;

    public List<${table_name}> getAll() {
        return ${table_name?uncap_first}Mapper.getAll();
    }

    public void delete(Integer id) {
        ${table_name?uncap_first}Mapper.delete(id);
    }

    public ${table_name} get(Integer id) {
        return ${table_name?uncap_first}Mapper.get(id);
    }

    public void update(${table_name} ${table_name?uncap_first}) {
        ${table_name?uncap_first}Mapper.update(${table_name?uncap_first});
    }

    public void save(${table_name} ${table_name?uncap_first}) {
        ${table_name?uncap_first}Mapper.save(${table_name?uncap_first});
    }

    public void deleteBatch(List<Integer> ids) {
        ${table_name?uncap_first}Mapper.deleteBatch(ids);
    }

    public void ${table_name?uncap_first}BatchUpdate(List<${table_name}> list) {
        ${table_name?uncap_first}Mapper.${table_name?uncap_first}BatchUpdate(list);
    }

    public List<${table_name}> getPart(Integer startRow, Integer limit) {
        return ${table_name?uncap_first}Mapper.getPart(startRow, limit);
    }

    public void insertBatch(List<${table_name}> list) {
        //判断是否插入主键是否含有值，自增，所以用不同的方法
        if (list.size() > 0 &&   (list.get(0).get<#list model_column as model><#if model_index =0>${model.changeColumnName}</#if></#list>() != null && list.get(0).get<#list model_column as model><#if model_index =0>${model.changeColumnName}</#if></#list>().toString().length() > 0)){
            ${table_name?uncap_first}Mapper.insertBatchHaveId(list);
        }else{
            ${table_name?uncap_first}Mapper.insertBatch(list);
        }
    }
}
