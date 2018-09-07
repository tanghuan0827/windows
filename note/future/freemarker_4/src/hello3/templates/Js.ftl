//所有的td标签都赋予了name属性，这个属性为javaType的属性名，方便

//一定需要将函数放在前面，否则无法解析
var upCheckbox =function(){
    var flag = true;
    <#noparse>$</#noparse>(":checkbox[name='item']").each(function(){
        if(!<#noparse>$</#noparse>(this).prop('checked')){
            flag = false;
        }
    });
    <#noparse>$</#noparse>(":checkbox[name='itemF']").prop('checked', flag);
 };

//给每个checkbox添加一个点击事件，如果，有一个没有选择，最上面的按钮就为没有选择状态
//如果都选择了，最上面按钮就为选择状态
<#noparse>$</#noparse>(":checkbox[name='item']").bind('click', upCheckbox)


function goTo(url){
    window.location.href=url;
}

//js获取项目根路径，如： http://localhost:8083/uimcardprj
function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    return curWwwPath;
}

//全选使用prop
<#noparse>$</#noparse>(".all${table_name}").click( function(){
    var flag = this.checked;
    <#noparse>$</#noparse>(":checkbox[name='item']").prop('checked',flag);
});

//反选
<#noparse>$</#noparse>(".opposite${table_name}").click(function(){
    <#noparse>$</#noparse>(":checkbox[name='item']").each(function(){
        var flag =<#noparse>$</#noparse>(this).prop('checked');
        <#noparse>$</#noparse>(this).prop('checked', !flag);
    })
    upCheckbox();
});



//和删除功能有关的
//构造一个javascript对象
function ${table_name}(<#list model_column as model>${model.changeColumnName?uncap_first}<#if model_has_next>, </#if></#list>){
        <#list model_column as model>
            this.${model.changeColumnName?uncap_first}=${model.changeColumnName?uncap_first}<#if model_has_next>;</#if>
        </#list>
}

//创建一个javascript对象
var ${table_name?uncap_first} = {};


//将tds 中的每个表格中的值变为input的值
function changeValueToInput(tds){
    //如果 标签间的内容包含 input字符串，就返回，不需要函数来赋予或者禁止点击事件了
    if(tds[2].innerHTML.indexOf("input") > -1){
        return ;
    }

    tds.each(function (index, item) {
        //第0个下标因为为input type:checkbox所以不需要修改
        if (0<index && index < tds.length - 1) {
            //td的长度的默认宽度-10px给input取宽度
            var length1=<#noparse>$</#noparse>(this).width()-10;

            //赋予宽度，给input的内容赋值value,给予name属性值,
            var t = <#noparse>$</#noparse>("<input type='text'></input>").width(length1).val(<#noparse>$</#noparse>(this).html())
                .attr("name", <#noparse>$</#noparse>(this).attr("name"));

            //将input标签添加到td标签中
            <#noparse>$</#noparse>(this).html(t);

            //设置td标签的宽度 原来的宽度
            <#noparse>$</#noparse>(this).width(length1+10);
        }

/**
        if(index == tds.length -2){
            //添加select标签和第一个option便签, 应该是value赋予option name的值
            var selectTd =<#noparse>$</#noparse>("<select></select>")
                .attr("name", <#noparse>$</#noparse>(this).attr('name'))
                .attr("class", "select" )
                .append(
                    <#noparse>$</#noparse>("<option></option>")
                        .attr("name", <#noparse>$</#noparse>(this).attr("value"))
                        .html(<#noparse>$</#noparse>(this).html())
                );
            var dId = <#noparse>$</#noparse>(this).attr("value");
            //发送ajax请求获取部门信息，不需要添加点击事件，直接在变为select的时候就
            //获取部门信息，通过函数来获取
            //ajax中不能使用<#noparse>$</#noparse>(this)函数，只能是上面的变量 selectTd
            <#noparse>$</#noparse>.ajax({
                url:"/department/listX",
                success:function(data){

                    var departmentList = data.extend.pageInfo.list;
                    for(var i=0;i<departmentList.length;i++){
                        if(departmentList[i].deptId != dId){
                            var optionTd = <#noparse>$</#noparse>("<option></option>").attr("name", departmentList[i].deptId)
                                                    .text(departmentList[i].deptName);
                            //只能是特定的标签，不能是class某一类标签
                            selectTd.append(optionTd);
                        }
                    }
                }
            });
            <#noparse>$</#noparse>(this).html(selectTd);
        }
*/
    });

}


//将input转换为${table_name?uncap_first}对象
function changeInputToValue(tds){
    //关于对象值传递和引用传递之间的关系
    ${table_name?uncap_first} ={};
    tds.each(function (index, item){
           if(0<index && index < tds.length - 1){
               //获取input 的jquery对象
               var input2 =<#noparse>$</#noparse>(this).find("input");

               //将input里面填写的内容赋值给${table_name?uncap_first}对象，注意val()和value的区别，val可以
               //取标签input随时填写的对象，具有及时性

               ${table_name?uncap_first}[input2.attr("name")] = input2.val();
           }

/**
           //关于select标签
           if(index == tds.length-2){
               //选中的option标签,find只能是一个标签 ,不能是多个select标签

               var optionSelected = <#noparse>$</#noparse>(this).find(".select").find("option:selected");

               //将option的name的值赋予${table_name?uncap_first}
               ${table_name?uncap_first}[<#noparse>$</#noparse>(tds[tds.length-2]).attr("name")] = optionSelected.attr("name");
           }
*/
       });
    return ${table_name?uncap_first};
}

//批量删除
<#noparse>$</#noparse>(".deleteBatch${table_name}").click(function(){
    //判断是否至少选择了一项
    var checkNum = <#noparse>$</#noparse>("input[name='item']:checked").length;
    if(checkNum == 0){
        alert("至少选择一项");
        return;
    }

    //将id放入到input type=checkbox里面，然后删除
    if(confirm("确定要删除所选项目")){
        var checkedList = new Array();
        <#noparse>$</#noparse>("input[name='item']:checked").each(function(){
            var <#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list> = <#noparse>$</#noparse>(this).attr("value");
            checkedList.push(<#list model_column as model><#if (model_index =0)>${model.changeColumnName?uncap_first}</#if></#list>);
        });
        <#noparse>$</#noparse>.ajax({
              type: "POST",
              url: "/${table_name?uncap_first}/batchDelete/"+checkedList.toString(),
              success: function(result) {
                  <#noparse>$</#noparse>("[name ='item']:checkbox").attr("checked", false);
                  window.location.reload();
              }
          });
    }
});


//批量更新
<#noparse>$</#noparse>(".updateBatch${table_name}").click(function(){
    //判断是否至少选择了一项
    var checkNum = <#noparse>$</#noparse>("input[name='item']:checked").length;
    if(checkNum == 0){
        alert("至少选择一项");
        return;
    }
    //将id放入到input type=checkbox里面，然后删除

    //多此一举，关于循环
    // var checkedList = new Array();

    //将每个input标签放入到列表中
    <#noparse>$</#noparse>("input[name='item']:checked").each(function () {
    //    checkedList.push(<#noparse>$</#noparse>(this) );
    // });
    // for(x in checkedList){
    //     //alert(checkedList[x] instanceof jQuery);
    //     //for循环里面 x为下标
    //     var inputT= checkedList[x];
        var tds = <#noparse>$</#noparse>(this).parent().parent().children("td");

        //将每个值变为能修改的input的值
        changeValueToInput(tds);

    });
});



//批量保存
<#noparse>$</#noparse>(".saveBatch${table_name}").click(function(){
    //判断是否至少选择了一项
    var checkNum = <#noparse>$</#noparse>("input[name='item']:checked").length;
    if(checkNum == 0){
        alert("至少选择一项");
        return;
    }
    var inputS = <#noparse>$</#noparse>("input[name='item']:checked");
    var array = new Array();

    //只有选中并且进入修改状态 input才能 转换为${table_name?uncap_first}
    inputS.each(function(index, item){
        var tds = <#noparse>$</#noparse>(inputS[index]).parent().parent().children("td");
        if(tds[1].innerHTML.indexOf("input")>-1){

            //${table_name?uncap_first}为全局函数，在函数里面进行了更新，
            // 还需要注意值传递和引用传递之间的关系
            changeInputToValue(tds);

            //将${table_name?uncap_first}存放到列表中
            array.push(${table_name?uncap_first});
        }
    });

    //发送ajax请求
        <#noparse>$</#noparse>.ajax({
           url:"/${table_name?uncap_first}/batchUpdate",
           type:"POST",
           dataType:"json",
           contentType:"application/json; charset=utf-8",
           data:JSON.stringify(array),
           success:function(result){
                window.location.href="/${table_name?uncap_first}/list";
           }
        });
})


//导出当前页有多少条
<#noparse>$</#noparse>(".exportExcelOnly${table_name}").click(function(){
    var pageSize = <#noparse>$</#noparse>(".pageSize").val();
    var pageNum = <#noparse>$</#noparse>(".pageNum").val();
    var size = <#noparse>$</#noparse>(".size").val();
    var startRow = pageSize*(pageNum-1);
    location.href="/${table_name?uncap_first}/exportExcelOnly?startRow="+startRow+"&limit="+size;

});

//导出excel文件，有弹出框 location.href
<#noparse>$</#noparse>(".exportExcelAll${table_name}").click(function(){
    location.href="/${table_name?uncap_first}/exportExcel";
});

// <#noparse>$</#noparse>(".importExcel").click(function(){
//     <#noparse>$</#noparse>.ajax({
//         url:"/${table_name?uncap_first}/importExcel",
//         success:function(result){
//             if(result.msg == '处理成功！'){
//                 window.location.reload();
//             }else{
//                 alert(result.extend.error1);
//             }
//         }
//     });
// });

//上传excel文件
<#noparse>$</#noparse>(".upload${table_name}").click(function(){
    <#noparse>$</#noparse>.ajax({
        url:"/${table_name?uncap_first}/importExcel2",
        type:"post",
        cache:false,
        data:new FormData(<#noparse>$</#noparse>('<#noparse>#</#noparse>uploadForm')[0]),
        processData:false,
        contentType:false,
        success:function(result){
            if(result.msg == '处理成功！'){
                window.location.reload();
            }else{
                alert(result.extend.error1);
            }
        }
    });
});




//第一种方式
//关于this函数的使用
//在标签中 onclick="hello(this);"
//函数中 <#noparse>$</#noparse>(obj)就代表这个标签 或者<#noparse>$</#noparse>(this)
// function hello(obj){
//     <#noparse>$</#noparse>(obj);
// }
//标签中用   .attr('onclick', '');


//第二种方式
//如果 一个东西等于某个函数 ,并绑定这个函数
//<#noparse>$</#noparse>(".").bind('click', tt);
//则在函数里面
//var tt = function(){
//  <#noparse>$</#noparse>(this);
//}
// <#noparse>$</#noparse>(this)就代表这个标签
// 第二种方式 用  unbind('click', tt函数名);

