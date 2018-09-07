<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-08-20
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="${APP_PATH}/js/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="${APP_PATH}/js/flotr2.min.js" type="text/javascript"></script>
    <script src="${APP_PATH}/js/excanvas.min.js" type="text/javascript"></script>
</head>
<body>
    <div id="chart" style="width:1000px;height:400px;"></div>


    <script>

        window.onload = function () {
            var arrF = new Array();
            var arrP=new Array();
            var zero = []


            $.ajax({
                type: "POST",
                url: "/ap805/getPicture",
                success: function (result) {

                    var m1=result.ap805;
                    var m2=result.pap805;

                    $.each(m2, function (ff, ee) {
                        //alert(value.dateF);

                        arrP.push([ff, ee.closeP ]);
                    });



                    $.each(m1, function (index, value) {
                        //alert(value.dateF);
                        if(index % 5 ==0) {
                            zero.push([index, value.dateF.substr(5,8)]);
                        }

                        arrF.push([index, value.longF]);
                    });
                    var co2 = arrF;

                    Flotr.draw(
                        document.getElementById("chart")
                        , [
                            { data: zero, label: "20<sup>th</sup> Century Baseline Temperature", lines: {show:true, lineWidth: 1}, shadowSize: 0, color: "#545454" },
                            {data: co2, label: "CO<sub>2</sub> Concentration (ppm)", lines: {show: true}},
                            { data: arrP, label: "CO<sub>2</sub> Concentration (ppm)", lines: {show:true}, yaxis: 2 }
                        ]
                        , {
                            fontSize: 3,
                            title: "Global Temperature and CO<sub>2</sub> Concentration (NOAA Data)",
                            grid: {horizontalLines: false, verticalLines: false},

                            yaxis: {
                                min: 0, max: 2100
                            },
                            xaxis:{

                                ticks:zero,
                                labelsAngle:15,
                            },
                            y2axis: {min: 5000, max: 9000},
                        }
                    );
                }


            });


        }
    </script>
</body>
</html>
