package ${package_name}.bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
import javax.persistence.Entity;
/**
* 描述：${table_annotation}模型
* @author ${author}
* @date ${date}
*/
public class ${table_name} {
    //private static final long serialVersionUID = 1L;

    <#list model_column as model>
    /**
    *   ${model.columnComment}
    */
    <#if (model.columnType='varchar'|| model.columnType='text'|| model.columnType='char')>
    private String ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType='int'|| model.columnType='tinyint')>
    private Integer ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType='decimal' || model.columnType='float')>
    private Double ${model.changeColumnName?uncap_first};

    </#if>
    <#if (model.columnType = 'timestamp' || model.columnType='datetime' )>
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    private Date ${model.changeColumnName?uncap_first};

    </#if>

    <#if ( model.columnType='date')>
        @DateTimeFormat(pattern = "yyyy-MM-dd")
        @JsonFormat(pattern = "yyyy-MM-dd", timezone="GMT+8")
        private Date ${model.changeColumnName?uncap_first};

    </#if>
    </#list>
 <#list model_column as model>
<#if (model.columnType = 'varchar' || model.columnType = 'text'|| model.columnType='char')>
    public String get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(String ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if (model.columnType = 'timestamp' || model.columnType='datetime')>
    public Date get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Date ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if (model.columnType='int'|| model.columnType='tinyint')>
    public Integer get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Integer ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
<#if model.columnType='decimal'  || model.columnType='float'>
    public Double get${model.changeColumnName}() {
        return this.${model.changeColumnName?uncap_first};
    }

    public void set${model.changeColumnName}(Double ${model.changeColumnName?uncap_first}) {
        this.${model.changeColumnName?uncap_first} = ${model.changeColumnName?uncap_first};
    }

</#if>
</#list>

    @Override
    public String toString() {
        return "${table_name}{" +
                <#list model_column as model>
                    <#if model_index =0>
                        <#if (model.columnType = 'varchar' || model.columnType = 'text'|| model.columnType='char')>
                    "${model.changeColumnName?uncap_first}='" + ${model.changeColumnName?uncap_first} + '\'' +
                        <#else>
                    "${model.changeColumnName?uncap_first}=" + ${model.changeColumnName?uncap_first} +
                        </#if>
                    </#if>
                    <#if (model_index >0)>
                        <#if (model.columnType = 'varchar' || model.columnType = 'text'|| model.columnType='char')>
                    ", ${model.changeColumnName?uncap_first}='" + ${model.changeColumnName?uncap_first} + '\'' +
                        <#else>
                    ", ${model.changeColumnName?uncap_first}=" + ${model.changeColumnName?uncap_first} +
                        </#if>
                    </#if>
                </#list>
                '}';
    }

    public ${table_name}() {
    }

    //构造函数
    public ${table_name}(<#list model_column as model><#if (model.columnType = 'varchar' || model.columnType = 'text'|| model.columnType='char')>String ${model.changeColumnName?uncap_first}<#if model_has_next>, </#if></#if><#if (model.columnType = 'timestamp' || model.columnType='datetime')>Date ${model.changeColumnName?uncap_first}<#if model_has_next>, </#if></#if><#if (model.columnType='int'|| model.columnType='tinyint')>Integer ${model.changeColumnName?uncap_first}<#if model_has_next>, </#if></#if><#if model.columnType='decimal' || model.columnType='float'>Double ${model.changeColumnName?uncap_first}<#if model_has_next>, </#if></#if></#list>) {
        <#list model_column as model>
            this.${model.changeColumnName?uncap_first}=${model.changeColumnName?uncap_first};
        </#list>
    }

}

