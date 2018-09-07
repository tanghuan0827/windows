//所有的td标签都赋予了name属性，这个属性为javaType的属性名，方便

//一定需要将函数放在前面，否则无法解析
var upCheckbox =function(){
    var flag = true;
    $(":checkbox[name='item']").each(function(){
        if(!$(this).prop('checked')){
            flag = false;
        }
    });
    $(":checkbox[name='itemF']").prop('checked', flag);
 };

//给每个checkbox添加一个点击事件，如果，有一个没有选择，最上面的按钮就为没有选择状态
//如果都选择了，最上面按钮就为选择状态
$(":checkbox[name='item']").bind('click', upCheckbox)


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
$(".allPap805").click( function(){
    var flag = this.checked;
    $(":checkbox[name='item']").prop('checked',flag);
});

//反选
$(".oppositePap805").click(function(){
    $(":checkbox[name='item']").each(function(){
        var flag =$(this).prop('checked');
        $(this).prop('checked', !flag);
    })
    upCheckbox();
});



//和删除功能有关的
//构造一个javascript对象
function Pap805(dateP, openP, highP, lowP, closeP, holdNumberP){
            this.dateP=dateP;
            this.openP=openP;
            this.highP=highP;
            this.lowP=lowP;
            this.closeP=closeP;
            this.holdNumberP=holdNumberP
}

//创建一个javascript对象
var pap805 = {};


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
            var length1=$(this).width()-10;

            //赋予宽度，给input的内容赋值value,给予name属性值,
            var t = $("<input type='text'></input>").width(length1).val($(this).html())
                .attr("name", $(this).attr("name"));

            //将input标签添加到td标签中
            $(this).html(t);

            //设置td标签的宽度 原来的宽度
            $(this).width(length1+10);
        }

/**
        if(index == tds.length -2){
            //添加select标签和第一个option便签, 应该是value赋予option name的值
            var selectTd =$("<select></select>")
                .attr("name", $(this).attr('name'))
                .attr("class", "select" )
                .append(
                    $("<option></option>")
                        .attr("name", $(this).attr("value"))
                        .html($(this).html())
                );
            var dId = $(this).attr("value");
            //发送ajax请求获取部门信息，不需要添加点击事件，直接在变为select的时候就
            //获取部门信息，通过函数来获取
            //ajax中不能使用$(this)函数，只能是上面的变量 selectTd
            $.ajax({
                url:"/department/listX",
                success:function(data){

                    var departmentList = data.extend.pageInfo.list;
                    for(var i=0;i<departmentList.length;i++){
                        if(departmentList[i].deptId != dId){
                            var optionTd = $("<option></option>").attr("name", departmentList[i].deptId)
                                                    .text(departmentList[i].deptName);
                            //只能是特定的标签，不能是class某一类标签
                            selectTd.append(optionTd);
                        }
                    }
                }
            });
            $(this).html(selectTd);
        }
*/
    });

}


//将input转换为pap805对象
function changeInputToValue(tds){
    //关于对象值传递和引用传递之间的关系
    pap805 ={};
    tds.each(function (index, item){
           if(0<index && index < tds.length - 1){
               //获取input 的jquery对象
               var input2 =$(this).find("input");

               //将input里面填写的内容赋值给pap805对象，注意val()和value的区别，val可以
               //取标签input随时填写的对象，具有及时性

               pap805[input2.attr("name")] = input2.val();
           }

/**
           //关于select标签
           if(index == tds.length-2){
               //选中的option标签,find只能是一个标签 ,不能是多个select标签

               var optionSelected = $(this).find(".select").find("option:selected");

               //将option的name的值赋予pap805
               pap805[$(tds[tds.length-2]).attr("name")] = optionSelected.attr("name");
           }
*/
       });
    return pap805;
}

//批量删除
$(".deleteBatchPap805").click(function(){
    //判断是否至少选择了一项
    var checkNum = $("input[name='item']:checked").length;
    if(checkNum == 0){
        alert("至少选择一项");
        return;
    }

    //将id放入到input type=checkbox里面，然后删除
    if(confirm("确定要删除所选项目")){
        var checkedList = new Array();
        $("input[name='item']:checked").each(function(){
            var dateP = $(this).attr("value");
            checkedList.push(dateP);
        });
        $.ajax({
              type: "POST",
              url: "/pap805/batchDelete/"+checkedList.toString(),
              success: function(result) {
                  $("[name ='item']:checkbox").attr("checked", false);
                  window.location.reload();
              }
          });
    }
});


//批量更新
$(".updateBatchPap805").click(function(){
    //判断是否至少选择了一项
    var checkNum = $("input[name='item']:checked").length;
    if(checkNum == 0){
        alert("至少选择一项");
        return;
    }
    //将id放入到input type=checkbox里面，然后删除

    //多此一举，关于循环
    // var checkedList = new Array();

    //将每个input标签放入到列表中
    $("input[name='item']:checked").each(function () {
    //    checkedList.push($(this) );
    // });
    // for(x in checkedList){
    //     //alert(checkedList[x] instanceof jQuery);
    //     //for循环里面 x为下标
    //     var inputT= checkedList[x];
        var tds = $(this).parent().parent().children("td");

        //将每个值变为能修改的input的值
        changeValueToInput(tds);

    });
});



//批量保存
$(".saveBatchPap805").click(function(){
    //判断是否至少选择了一项
    var checkNum = $("input[name='item']:checked").length;
    if(checkNum == 0){
        alert("至少选择一项");
        return;
    }
    var inputS = $("input[name='item']:checked");
    var array = new Array();

    //只有选中并且进入修改状态 input才能 转换为pap805
    inputS.each(function(index, item){
        var tds = $(inputS[index]).parent().parent().children("td");
        if(tds[1].innerHTML.indexOf("input")>-1){

            //pap805为全局函数，在函数里面进行了更新，
            // 还需要注意值传递和引用传递之间的关系
            changeInputToValue(tds);

            //将pap805存放到列表中
            array.push(pap805);
        }
    });

    //发送ajax请求
        $.ajax({
           url:"/pap805/batchUpdate",
           type:"POST",
           dataType:"json",
           contentType:"application/json; charset=utf-8",
           data:JSON.stringify(array),
           success:function(result){
                window.location.href="/pap805/list";
           }
        });
})


//导出当前页有多少条
$(".exportExcelOnlyPap805").click(function(){
    var pageSize = $(".pageSize").val();
    var pageNum = $(".pageNum").val();
    var size = $(".size").val();
    var startRow = pageSize*(pageNum-1);
    location.href="/pap805/exportExcelOnly?startRow="+startRow+"&limit="+size;

});

//导出excel文件，有弹出框 location.href
$(".exportExcelAllPap805").click(function(){
    location.href="/pap805/exportExcel";
});

// $(".importExcel").click(function(){
//     $.ajax({
//         url:"/pap805/importExcel",
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
$(".uploadPap805").click(function(){
    $.ajax({
        url:"/pap805/importExcel2",
        type:"post",
        cache:false,
        data:new FormData($('#uploadForm')[0]),
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
//函数中 $(obj)就代表这个标签 或者$(this)
// function hello(obj){
//     $(obj);
// }
//标签中用   .attr('onclick', '');


//第二种方式
//如果 一个东西等于某个函数 ,并绑定这个函数
//$(".").bind('click', tt);
//则在函数里面
//var tt = function(){
//  $(this);
//}
// $(this)就代表这个标签
// 第二种方式 用  unbind('click', tt函数名);

