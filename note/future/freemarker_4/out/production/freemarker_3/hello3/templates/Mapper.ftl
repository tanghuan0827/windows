<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package_name}.dao.${table_name}Mapper">

    <resultMap type="${table_name?uncap_first}" id="${table_name?uncap_first}Map">
        <#list model_column as model>
            <#if model_index=0>
        <id column="${model.columnName}" property="${model.changeColumnName?uncap_first}"/>
            <#else>
        <result column="${model.columnName}" property="${model.changeColumnName?uncap_first}"/>
            </#if>
        </#list>
    </resultMap>

    <select id="getAll" resultMap="${table_name?uncap_first}Map">
        SELECT
        <#list model_column as model>
            ${model.columnName}<#if model_has_next>,</#if>
        </#list>
        FROM
        ${tb_table_name}
  </select>

    <update id="delete" parameterType="Integer">
        delete FROM
        ${tb_table_name}
        where <#list model_column as model><#if model_index =0>${model.columnName}</#if></#list> = <#noparse>#</#noparse>{<#list model_column as model><#if model_index =0>${model.changeColumnName?uncap_first}</#if></#list>}
    </update>

    <select id="get" parameterType="Integer" resultType="${package_name}.bean.${table_name}">
        select
        <#list model_column as model>
            ${model.columnName}<#if model_has_next>,</#if>
        </#list>
        from ${tb_table_name}
        where
            <#list model_column as model><#if model_index =0>${model.columnName}</#if></#list> = <#noparse>#</#noparse>{<#list model_column as model><#if model_index =0>${model.changeColumnName?uncap_first}</#if></#list>}
    </select>

    <update id="update" parameterType="${package_name}.bean.${table_name}">
        update ${tb_table_name}
        set
            <#list model_column as model><#if !(model_index =0)>${model.columnName}=<#noparse>#</#noparse>{${model.changeColumnName?uncap_first}}<#if model_has_next>, </#if></#if></#list>
        WHERE
            <#list model_column as model><#if model_index =0>${model.columnName}</#if></#list> = <#noparse>#</#noparse>{<#list model_column as model><#if model_index =0>${model.changeColumnName?uncap_first}</#if></#list>}
    </update>

    <update id="save" parameterType="${package_name}.bean.${table_name}">
        insert into ${tb_table_name} (
            <#list model_column as model><#if !(model_index =0)>${model.columnName}<#if model_has_next>, </#if></#if></#list>
        )
        values (
            <#list model_column as model><#if !(model_index=0)><#noparse>#</#noparse>{${model.changeColumnName?uncap_first}}<#if model_has_next>, </#if></#if></#list>
        );
    </update>

    <delete id="deleteBatch" parameterType="java.util.List">
        DELETE from ${tb_table_name}
        where <#list model_column as model><#if model_index =0>${model.columnName}</#if></#list>
        IN
        <foreach collection="list" index = "index" item="item" open="(" close=")" separator=",">
            <#noparse>#</#noparse>{item}
        </foreach>
    </delete>

    <update id="${table_name?uncap_first}BatchUpdate" parameterType="java.util.List">
         <foreach collection="list" item="item" index="index" open="" close="" separator=";">
               update ${tb_table_name} ${tb_simple_name}
               <set>
               <#list model_column as model>
               <#if !(model_index =0)>
               	${tb_simple_name}.${model.columnName} = <#noparse>#</#noparse>{item.${model.changeColumnName?uncap_first}}<#if model_has_next>,</#if>
               </#if>
               </#list>
               </set>
               where ${tb_simple_name}.<#list model_column as model><#if model_index =0>${model.columnName}</#if></#list> = <#noparse>#</#noparse>{item.<#list model_column as model><#if model_index =0>${model.changeColumnName?uncap_first}</#if></#list>}
        </foreach>
    </update>

    <select id="getPart" resultMap="${table_name?uncap_first}Map" >
        SELECT
            <#list model_column as model>
            ${tb_simple_name}.${model.columnName}<#if model_has_next>,</#if>
            </#list>
            FROM
            ${tb_table_name} ${tb_simple_name}
      limit <#noparse>#</#noparse>{startRow}, <#noparse>#</#noparse>{limit}
    </select>

    <update id="insertBatch" parameterType="java.util.List">
        insert into ${tb_table_name}(<#list model_column as model><#if !(model_index =0)>${model.columnName}<#if model_has_next>, </#if></#if></#list>)
        VALUES
        <foreach collection="list" item="item" index="index" separator=",">
            (<#list model_column as model><#if !(model_index=0)><#noparse>#</#noparse>{item.${model.changeColumnName?uncap_first}}<#if model_has_next>, </#if></#if></#list>)
        </foreach>
    </update>

    <update id="insertBatchHaveId" parameterType="java.util.List">
        insert into ${tb_table_name}(<#list model_column as model>${model.columnName}<#if model_has_next>, </#if></#list>)
        VALUES
        <foreach collection="list" item="item" index="index" separator=",">
            (<#list model_column as model><#noparse>#</#noparse>{item.${model.changeColumnName?uncap_first}}<#if model_has_next>, </#if></#list>)
        </foreach>
    </update>

    <!--
        <#list model_column as model>${model.columnName}<#if model_has_next>, </#if></#list>

        <#list model_column as model>${tb_simple_name}.${model.columnName}<#if model_has_next>, </#if></#list>

        <#list model_column as model>
            ${model.columnName}<#if model_has_next>,</#if>
        </#list>

        <#list model_column as model>
            <#if !(model_index=0)>
            ${tb_simple_name}.${model.columnName}<#if model_has_next>,</#if>
            </#if>
        </#list>
    -->

</mapper>