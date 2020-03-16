<%@page import="java.io.BufferedReader"%>  
<%@page import="java.io.FileReader"%>  
<%@page import="java.io.File"%> 
<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.InputStreamReader" %> 
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>新冠肺炎疫情地图</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <script src="echarts.min.js"></script>
    <script src="china.js"></script>
    <script src="http://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
<script src="semantic/dist/semantic.min.js"></script>
    <script type="text/javascript">
function altRows(id){
    if(document.getElementsByTagName){ 
         
        var table = document.getElementById(id); 
        var rows = table.getElementsByTagName("tr");
          
        for(i = 0; i < rows.length; i++){         
            if(i % 2 == 0){
                rows[i].className = "evenrowcolor";
            }else{
                rows[i].className = "oddrowcolor";
            }     
        }
    }
}

window.onload=function(){
    altRows('alternatecolor');
}
</script>
    <style>
        *{margin:0;padding:0}
        html,body{
            width:100%;
            height:100%;
        }
        #main{
              width:600px;
              height:450px;
              margin: 1px auto;
              border:1px;
          }
        /*默认长宽比0.75*/
 table.altrowstable {
    font-family: verdana,arial,sans-serif;
    font-size:22px;
    color:#333333;
    border-width: 1px;
    border-color: #a9c6c9;
    border-collapse: collapse;
}
table.altrowstable th {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
table.altrowstable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
.oddrowcolor{
    background-color:#d4e3e5;
}
.evenrowcolor{
    background-color:#c3dde0;
}
    </style>
</head>
<body>
    <div style="float: left;width:460px;height:1500px;"></div>
    <div style="height:60px;background-color: #AFEEEE">
        <p style="font-size:35px">新冠肺炎疫情地图</p>
    </div>
    <%
        request.setCharacterEncoding("UTF-8");
        String basePath="D:/log/";
        String[] list=new File(basePath).list();
        String name = request.getParameter("name");
        out.println(name);    
        int i = 0;
        int num = 0;        
        String[] confirm = new String[15];
        String[] cure = new String[15];
        String[] dead = new String[15];
        String[] infected = new String[15];
        for (int j=0;j<15;j++) {
            confirm[j] = null;
            cure[j] = null;
            dead[j] = null;
            infected[j] = null;
        }
        String date = request.getParameter("date")+".txt";
        int res=list[list.length-1].compareTo(date);
        if(res<0) num = list.length;
        else {
            for(int j=list.length-1;j>0;j--){
                if(list[j].compareTo(date)<=0){
                    num = j+1;
                    j=0;
                }
            }
        }
        for (int j=0;j<num;j++) {
        String path = "D:/log/"+list[j];
        FileInputStream f = new FileInputStream(path);
        InputStreamReader reader = new InputStreamReader(f, "UTF-8");
        BufferedReader bf = new BufferedReader(reader);
        String str = null;
        while ((str = bf.readLine())!= null){
            String[] line = str.split(" ");  ///以空格间隔提取内容
            if(line[0].equals(name)){
                confirm[i] = line[1];
                cure[i] = line[3];
                dead[i] = line[4];
                infected[i] = line[2];
                i++;
            }

        }
        bf.close();
        f.close();
        }
    %>
    <div style="width:;height: 200px">
         <p style="color:#708090">数据更新至2月02日</p>
           <table class="altrowstable" id="alternatecolor" style="width:600px;text-align: center;">
            <tr>
                <td>现存确诊<br/><p style="color:#F08080"><%=confirm[i-1]%></p></td>
                <td>累计确诊<br><p style="color:#A52A2A"><%=(confirm[i-1]+cure[i-1])%></p></td>
                <td>累计治愈<br><p style="color:#32CD32"><%=cure[i-1]%></p></td>
                <td>累计死亡<br><p style="color:#696969"><%=dead[i-1]%></p></td>
            </tr>

</table>
    </div>
    
     <div style="text-align:;"> 
        <p style="color:#2F4F4F;font-size:25px;"><%=name %>&nbsp;&nbsp;&nbsp;新增确诊趋势</p>    
          
    </div>
 
    <div id="main" style="background-color:#F5F5F5">
        
    </div>
    <script type="text/javascript">
        
        var myChart = echarts.init(document.getElementById('main'));
        function randomValue() {
            return Math.round(Math.random()*1000);
        }
option = {
    title: {
        text: ''
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data: ['新增确诊', '新增疑似', '累计治愈', '累计死亡']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['1.19', '1.20','1.21','1.22','1.23','1.24','1.25','1.26','1.27','1.28','1.29','1.30','1.31','2.1','2.2']
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name: '新增确诊',
            type: 'line',
            stack: '总量',
            data: ["<%=confirm[0]%>", "<%=confirm[1]%>", "<%=confirm[2]%>", "<%=confirm[3]%>", "<%=confirm[4]%>", "<%=confirm[5]%>", "<%=confirm[6]%>","<%=confirm[7]%>","<%=confirm[8]%>","<%=confirm[9]%>","<%=confirm[10]%>","<%=confirm[11]%>","<%=confirm[12]%>","<%=confirm[13]%>","<%=confirm[14]%>"]
        },
        {
            name: '新增疑似',
            type: 'line',
            stack: '总量',
            data: ["<%=infected[0]%>", "<%=infected[1]%>", "<%=infected[2]%>", "<%=infected[3]%>", "<%=infected[4]%>", "<%=infected[5]%>", "<%=infected[6]%>","<%=infected[7]%>","<%=infected[8]%>","<%=infected[9]%>","<%=infected[10]%>","<%=infected[11]%>","<%=infected[12]%>","<%=infected[13]%>","<%=infected[14]%>"]
        },
        {
            name: '累计治愈',
            type: 'line',
            stack: '总量',
            data: ["<%=cure[0]%>", "<%=cure[1]%>", "<%=cure[2]%>", "<%=cure[3]%>", "<%=cure[4]%>", "<%=cure[5]%>", "<%=cure[6]%>","<%=cure[7]%>","<%=cure[8]%>","<%=cure[9]%>","<%=cure[10]%>","<%=cure[11]%>","<%=cure[12]%>","<%=cure[13]%>","<%=cure[14]%>"]
        },
        {
            name: '累计死亡',
            type: 'line',
            stack: '总量',
            data: ["<%=dead[0]%>", "<%=dead[1]%>", "<%=dead[2]%>", "<%=dead[3]%>", "<%=dead[4]%>", "<%=dead[5]%>", "<%=dead[6]%>","<%=dead[7]%>","<%=dead[8]%>","<%=dead[9]%>","<%=dead[10]%>","<%=dead[11]%>","<%=dead[12]%>","<%=dead[13]%>","<%=dead[14]%>"]
        }
    ]
};
        myChart.setOption(option);
    </script>
</body>
</html>