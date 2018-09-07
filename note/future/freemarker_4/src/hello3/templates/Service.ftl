package ${package_name}.service.impl;

import ${package_name}.bean.${table_name};
import ${package_name}.dao.${table_name}Mapper;
import ${package_name}.service.${table_name}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;


/**
* 描述：${table_annotation} 服务实现层
* @author ${author}
* @date ${date}
*/
@Service
public class ${table_name}ServiceImpl implements ${table_name}Service {

    @Autowired
    private ${table_name}Mapper ${table_name?uncap_first}Mapper;

    public List<${table_name}> getAll(${table_name} ${table_name?uncap_first}) {
        return ${table_name?uncap_first}Mapper.getAll(${table_name?uncap_first});
    }

    public void save(${table_name} ${table_name?uncap_first}) {
        <#list model_column as model>
            <#if (model_index = 0)>
                <#if (model.columnType='char' || model.columnType='varchar')>
        String id =UUID.randomUUID().toString().replace("-","").substring(0,10);
        ${table_name?uncap_first}.set${model.changeColumnName}(id);
                </#if>
            </#if>
        </#list>
        ${table_name?uncap_first}Mapper.save(${table_name?uncap_first});
    }

    public void ${table_name?uncap_first}BatchUpdate(List<${table_name}> list) {
        ${table_name?uncap_first}Mapper.${table_name?uncap_first}BatchUpdate(list);
    }

    public List<${table_name}> getPart(Integer startRow, Integer limit) {
        return ${table_name?uncap_first}Mapper.getPart(startRow, limit);
    }

    public void insertBatch(List<${table_name}> list) {
        //判断是否插入主键是否含有值，自增，所以用不同的方法
        if (list.size() > 0){
            ${table_name?uncap_first}Mapper.insertBatchHaveId(list);
        }else{
            <#list model_column as model>
                <#if (model_index = 0)>
                    <#if (model.columnType='char' || model.columnType='varchar')>
            for(${table_name} ${table_name?uncap_first}:list){
                String id =UUID.randomUUID().toString().replace("-","").substring(0,10);
                ${table_name?uncap_first}.set${model.changeColumnName}(id);
            }
                    </#if>
                </#if>
            </#list>
            ${table_name?uncap_first}Mapper.insertBatch(list);
        }
    }

}
