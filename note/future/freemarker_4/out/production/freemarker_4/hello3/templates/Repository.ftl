package ${package_name}.dao;

import ${package_name}.bean.${table_name};
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ${table_name}Mapper {


    List<${table_name}> getAll(${table_name} ${table_name?uncap_first});



    void save(${table_name} ${table_name?uncap_first});


    void ${table_name?uncap_first}BatchUpdate(List<${table_name}> list);

    List<${table_name}> getPart(@Param("startRow") Integer startRow,@Param("limit") Integer limit);

    void insertBatch(List<${table_name}> list);

    void insertBatchHaveId(List<${table_name}> list);

}
