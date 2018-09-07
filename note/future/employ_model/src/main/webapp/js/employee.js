//js获取项目根路径，如： http://localhost:8083/uimcardprj

function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    return curWwwPath;
}

//构造一个javascript对象
function Employee(empId,empName,gender,email,dId){
    this.empId = empId;
    this.empName = empName;
    this.gender = gender;
    this.email = email;
    this.dId = dId;
}

//创建一个javascript对象
var employee = {};

//删除功能
$(document).on("click", ".deleteA", function(){
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).parents("tr").find("td:eq(1)").text();
        var urlBefore = getRootPath();
        if(confirm("确认删除【"+empName+"】吗？")){
            $.ajax({
                url:"/employee/employeeBatchDelete/"+empId,
                success:function(result){
                    window.location.href=(urlBefore);
                }
            });
        }
});

//全选使用prop
$(".all").click( function(){
    var flag = this.checked;
    $(":checkbox[name='item']").prop('checked',flag);
});

//反选使用
$(".opposite").click(function(){
    $(":checkbox[name='item']").each(function(){
        this.checked =!this.checked;
    });
});

//批量删除
$(".deleteBatch").click(function(){
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
            checkedList.push($(this).val());
        });
        $.ajax({
              type: "POST",
              url: "/employee/employeeBatchDelete/"+checkedList.toString(),
              success: function(result) {
                  $("[name ='item']:checkbox").attr("checked", false);
                  window.location.reload();
              }
          });
    }
});

//批量更新
$(".updateBatch").click(function(){
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
        changeTdToValue(tds);

    });
});

//批量保存
$(".saveBatch").click(function(){
    //判断是否至少选择了一项
    var checkNum = $("input[name='item']:checked").length;
    if(checkNum == 0){
        alert("至少选择一项");
        return;
    }
    var inputS = $("input[name='item']:checked");
    var array = new Array();

    //只有选中并且进入修改状态 input才能 转换为employee
    inputS.each(function(index, item){
        var tds = $(inputS[index]).parent().parent().children("td");
        if(tds[1].innerHTML.indexOf("input")>-1){

            //employee为全局函数，在函数里面进行了更新，
            // 还需要注意值传递和引用传递之间的关系
            changeInputToEmployee(tds);

            //将employee存放到列表中
            array.push(employee);
        }
    });

    //发送ajax请求
        $.ajax({
           url:"/employee/employeeBatchUpdate",
           type:"POST",
           dataType:"json",
           contentType:"application/json; charset=utf-8",
           data:JSON.stringify(array),
           success:function(result){
               //多个input type=checkbox
               inputS.each(function(index, item) {

                   //每行的tds
                   var tds = $(inputS[index]).parent().parent().children("td");
                   tds.each(function (index, item) {
                       if (0 < index && index < tds.length - 1) {
                           var tdWidth = $(this).width()+1;
                           var tdValue = $(this).children("input").val();
                           $(this).html(tdValue);
                           $(this).width(tdWidth);
                       }
                   });
               });
           }
        });
})

//将tds 中的每个表格中的值变为input的值
function changeTdToValue(tds){
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
    });

}

//跳转到修改状态
var updateGoAction = function updateGo() {
    var tds = $(this).parent().parent().children("td");

    changeTdToValue(tds);

    //点击修改之后，不能再次点击修改事件
    //$(this).unbind('click', updateGoAction);
    //tds.last().children(".updateSaveA").bind('click', updateSaveAction);


}

//将input转换为employee对象
function changeInputToEmployee(tds){
    //关于对象值传递和引用传递之间的关系
    employee ={};
    tds.each(function (index, item){
           if(0<index && index < tds.length - 1){
               //获取input 的jquery对象
               var input2 =$(this).find("input");

               //将input里面填写的内容赋值给employee对象，注意val()和value的区别，val可以
               //取标签input随时填写的对象，具有及时性

               employee[input2.attr("name")] = input2.val();
           }
       });
    return employee;
}


//修改并保存
var updateSaveAction =function updateSave(){
    //获取td的标签，此时td里面已经有input标签了
    var tds = $(this).parent().parent().children("td");

    //如果 标签间的内容包含 input字符串，就返回，不需要函数来赋予或者禁止点击事件了
    if(!(tds[2].innerHTML.indexOf("input") > -1)){
        return ;
    }

    //获取0元素为dom对象，需要在外面加$
    // alert($(tds[0]).html());

    employee =changeInputToEmployee(tds);

    //注意input构造器，如果涉及多表查询，以及select checkbox等，需要修改页面元素
    //构造器不对会报 400的错误 employee的值传递不进去
    //415  不是json对象的形式
    //405  PUT POST GET DELETE等请求方式不对
    //406

    //将对象转换为json的字符串形式
    //alert(JSON.stringify(employee));

    //发送ajax请求
    $.ajax({
       url:"/employee/employeeUpdate",
       type:"POST",
       dataType:"json",
       contentType:"application/json; charset=utf-8",
       data:JSON.stringify(employee),
       success:function(result){
           //alert("hello");
            tds.each(function (index, item) {
                if(0<index && index< tds.length -1){
                    var tdWidth = $(this).width();
                    var tdValue = $(this).children("input").val();
                    $(this).html(tdValue);
                    $(this).width(tdWidth);
                    //alert($(this).child() instanceof jQuery);
                    //$(this).child().html();
                }
            });
       }
    });

    //保存之后，给修改点击事件添加  ,不能绑定一个事件两次，
    // 否则会出现input嵌套input的情况
    //tds.last().children(".updateSaveA").unbind('click', updateSaveAction);
    //tds.last().children(".updateGoA").bind('click', updateGoAction);
    //window.open("/employee/employeeList");
}

window.onload = function(){
    $(".updateGoA").bind("click", updateGoAction);
    $(".updateSaveA").bind('click', updateSaveAction);
}

//导出当前页有多少条
$(".exportExcelOnly").click(function(){
    var pageSize = $(".pageSize").val();
    var pageNum = $(".pageNum").val();
    var size = $(".size").val();
    var startRow = pageSize*(pageNum-1);
    location.href="/employee/exportExcelOnly?startRow="+startRow+"&limit="+size;

});

//导出excel文件，有弹出框 location.href
$(".exportExcelAll").click(function(){
    location.href="/employee/exportExcel";
});

// $(".importExcel").click(function(){
//     $.ajax({
//         url:"/employee/importExcel",
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
$(".upload").click(function(){
    $.ajax({
        url:"/employee/importExcel2",
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

