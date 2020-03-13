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

    <script src="http://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
    <link href="css/index.css" rel="stylesheet">
    <script src="semantic/dist/semantic.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/4.4.0-rc.1/echarts.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-color/2.1.2/jquery.color.min.js"></script>
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-animateNumber/0.0.14/jquery.animateNumber.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tooltipster/3.3.0/js/jquery.tooltipster.min.js"></script>
    <script src="Date.prototype.js"></script>
    <script src="layer.js"></script>
    <script src="echarts.min.js"></script>
    <script src="china.js"></script>
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
 <div id="realTimeData" style="height: 170px;">
        <div class="freshDiv">
            <span class="freshBtn">
                <svg viewBox="0 0 1024 1024" width="32" height="32">
                    <path
                        d="M512 96C283.2 96 96 283.2 96 512s187.2 416 416 416 416-187.2 416-416S740.8 96 512 96z m224 388h-196l89.6-89.6C600.2 363.6 558.2 344 512 344c-92.4 0-168 75.6-168 168s75.6 168 168 168c69.8 0 130.6-42.4 155.2-104h59.6c-27.8 92.6-112.6 160-214.8 160-124.6 0-224-100.8-224-224s100.8-224 224-224c61.6 0 117.6 25.2 158.2 65.8L736 288v196z"
                        fill="#3d9006">
                    </path>
                </svg>
            </span>
        </div>
        <div class="datatitle">全国疫情实时数据统计</div>
        <div class="datasubtitle">(截至2020-01-31 08:09)</div>
        <div class="process">
            <span class="processValue"></span>
            <span class="processDoc">
                <svg viewBox="0 0 1024 1024" width="16" height="16">
                    <path
                        d="M492.472287 611.957373H178.826494v219.547859h313.645793V611.957373zM285.516185 580.592077L254.350434 432.550666c-2.848879-13.678507 1.149171-27.189191 9.653851-36.983236l111.237255-137.066475c4.740968-5.845113 10.395747-11.080337 17.229372-12.730927l43.169109-10.434632c-2.656498 12.471008-3.51505 27.145189-1.344622 44.133061 2.340297 18.251653 8.190526 39.225295 19.136811 63.013024a37.993237 37.993237 0 0 0-10.181876 13.447239c-3.690035 8.127082-4.832042 18.063365-2.013863 29.168262l16.976616 66.934325c1.570772 6.290251 7.949027 10.122525 14.243371 8.547659a11.941959 11.941959 0 0 0 1.810225-0.609889l10.471471-3.97042c6.065124-2.281968 9.131966-9.052149 6.845905-15.115226-2.116193-5.632266-8.104569-8.676596-13.805396-7.258296l-13.748092-54.226934c-1.414206-5.584171-0.991582-10.245321 0.630356-13.821769a14.513523 14.513523 0 0 1 8.098429-7.610313 14.60562 14.60562 0 0 1 11.191877 0.319271c3.560075 1.593285 6.951305 4.79111 9.58222 9.891258l25.648096 49.770444c-5.202478 2.693337-7.675804 8.921166-5.565752 14.543199 2.289131 6.063077 9.055218 9.12992 15.122389 6.840788l10.996426-4.164848c6.0641-2.284015 9.12685-9.052149 6.841812-15.115226-0.180102-0.492209-0.394995-0.951673-0.631379-1.39988l-31.55563-61.226334c-5.257737-10.198249-12.705344-16.890658-20.882568-20.547947a37.849974 37.849974 0 0 0-18.315097-3.238758c-10.189039-21.888476-15.567526-40.852348-17.642787-57.107535-2.534724-19.805029-0.146332-35.515817 4.325506-47.533501l13.944566-3.364624a43.561034 43.561034 0 0 1 2.970652-0.296758l41.148083 59.526626v-29.654331l11.764928-11.760835 11.761858 11.760835 5.068426 27.885038 24.101882-58.113443 33.412928 12.899772-13.538314 64.685102c-19.468362 0.020466-35.246688 15.809026-35.246689 35.287621 0 19.485758 15.79777 35.284551 35.284551 35.28455 19.487804-0.002047 35.285574-15.796746 35.285574-35.28455 0-11.042475-5.073542-20.900987-13.014383-27.3652l13.404262-64.04656 24.132581 9.323324c7.604173 5.693664 12.856793 13.550594 15.414031 22.18421L727.292961 448.094656l125.496998 62.743894c21.215142 10.608594 29.810897 36.403022 19.208442 57.61407-10.609617 21.215142-36.403022 29.81499-57.618164 19.212536L675.069657 518.006795c-10.510357-4.640684-19.148067-13.460543-23.227981-25.173282l-30.15882-86.217468v163.555726c34.441348 69.050518 63.22587 127.723708 77.759859 206.560083h-0.026606c0.459464 2.520398 0.69687 5.111404 0.69687 7.753576l-0.061398 180.200791c0.11154 1.248431 0.168845 2.515282 0.168845 3.794412 0 23.813311-19.308726 43.12613-43.127153 43.12613l-15.387425-0.008186v-0.167822c-23.72633 0-42.957285-19.227885-42.957285-42.950122l0.061398-179.802726c-9.636455-49.513595-28.646376-92.259056-50.802958-137.671248h-24.174537v196.188896c0 8.65306-7.016797 15.682136-15.682136 15.682136l-17.951825-0.00307-7.538682 106.654899c-0.417508 23.470504-19.560459 42.349442-43.114874 42.349442l-15.980941-0.00307v-0.077771c-0.949626 0-1.899253-0.018419-2.860135-0.086981-23.72633-1.577935-41.676108-22.096207-40.098173-45.81742l6.991214-103.018075H163.144358c-8.664316 0-15.682136-7.021913-15.682136-15.679067v-250.924411c0-8.65613 7.01782-15.67395 15.682136-15.67395l122.371827-0.00614zM532.539761 12.123084c-51.966455 0-94.097933 42.132502-94.097933 94.094864 0 51.972595 42.131479 94.09384 94.097933 94.09384 51.965432-0.002047 94.088724-42.119199 94.088724-94.09384 0-51.964408-42.123292-94.092817-94.088724-94.092817v-0.002047zM369.945941 564.010457a42.941935 42.941935 0 0 1 0.192381 16.585714l36.268969-0.004094-0.019443-224.033001-63.613702 78.399424 27.171795 129.051957z"
                        fill="#82AC28"></path>
                    <path
                        d="M304.284606 643.317552h62.725475v47.054595h47.046409v62.725475h-47.046409v47.050501h-62.725475v-47.050501h-47.051524V690.372147h47.051524z"
                        fill="#82AC28"></path>
                </svg>
            </span>
        </div>

        <ul class="statistics">
            <li>
                <strong style="color: #f74c31;" dataContent="">0</strong>
                <span dataContent="">现有确诊</span>
            </li>
            <li>
                <strong style="color:#a25a4e;" dataContent="">0</strong>
                <span dataContent="">现有重症</span>
            </li>
            <li>
                <strong style="color: #f78207;" dataContent="">0</strong>
                <span dataContent="">现有疑似</span>
            </li>
            <li>
                <strong style="color: #ae212c;" dataContent="">0</strong>
                <span dataContent="">累计确诊</span>
            </li>

            <li>
                <strong style="color: #5d7092;" dataContent="">0</strong>
                <span dataContent="">累计死亡</span>
            </li>
            <li>
                <strong style="color: #28b7a3;" dataContent="">0</strong>
                <span dataContent="">累计治愈</span>
            </li>
        </ul>
    </div>

    <div style="text-align: center;">
        <form action="test1.jsp" method="post">
        <button class="ui button">选择日期</button>	
        <select name="date">
            <option value="2020-01-19">2020-01-19</option>
            <option value="2020-01-20">2020-01-20</option>
            <option value="2020-01-21">2020-01-21</option>
            <option value="2020-01-22">2020-01-22</option>
            <option value="2020-01-23">2020-01-23</option>
            <option value="2020-01-24">2020-01-24</option>
            <option value="2020-01-25">2020-01-25</option>
            <option value="2020-01-26">2020-01-26</option>
            <option value="2020-01-27">2020-01-27</option>
            <option value="2020-01-28">2020-01-28</option>
            <option value="2020-01-29">2020-01-29</option>
            <option value ="2020-01-30">2020-01-30</option>
            <option value ="2020-01-31">2020-01-31</option>
            <option value="2020-02-01">2020-02-01</option>
            <option value="2020-02-02">2020-02-02</option>
        </select>
        <input type="submit" class="ui button" value="确定" />
        </form>  
        
    </div>
        <% 
        String path = "D:/log/2020-02-02.txt";
        FileInputStream f = new FileInputStream(path);
        InputStreamReader reader = new InputStreamReader(f, "UTF-8");
        BufferedReader bf = new BufferedReader(reader);
        int i = 0;
        String str = null;
        int[] confirm = new int[34]; 
        while ((str = bf.readLine())!= null){
            String[] line = str.split(" ");  ///以空格间隔提取内容
            confirm[i] =Integer.parseInt(line[1]);
            i++;
        }
        bf.close();
        f.close();
    %>
    <div id="main" style="background-color:#F5F5F5">
        
    </div>
    <script type="text/javascript">
        /*默认显示最新疫情*/
         var dataList=[
            {name:"南海诸岛",value:0},
            {name: '安徽', value: "<%=confirm[0]%>" },
            {name: '澳门', value: "<%=confirm[1]%>"},
            {name: '北京', value: "<%=confirm[2]%>"},
            {name: '福建', value: "<%=confirm[3]%>"},
            {name: '甘肃', value: "<%=confirm[4]%>"},
            {name: '广东', value: "<%=confirm[5]%>"},
            {name: '广西', value: "<%=confirm[6]%>"},
            {name: '贵州', value: "<%=confirm[7]%>"},
            {name: '海南', value: "<%=confirm[8]%>"},
            {name: '河北', value: "<%=confirm[9]%>"},
            {name: '河南', value: "<%=confirm[10]%>"},
            {name: '黑龙江', value: "<%=confirm[11]%>"},
            {name: '湖北', value: "<%=confirm[12]%>"},
            {name: '湖南', value: "<%=confirm[13]%>"},
            {name: '吉林', value: "<%=confirm[14]%>"},
            {name: '江苏', value: "<%=confirm[15]%>"},
            {name: '江西', value: "<%=confirm[16]%>"},
            {name: '辽宁', value: "<%=confirm[17]%>"},
            {name: '内蒙古', value: "<%=confirm[18]%>"},
            {name: '宁夏', value: "<%=confirm[19]%>"},
            {name: '青海', value: "<%=confirm[20]%>"},
            {name: '山东', value: "<%=confirm[21]%>"},
            {name: '山西', value: "<%=confirm[22]%>"},
            {name: '陕西', value: "<%=confirm[23]%>"},
            {name: '上海', value: "<%=confirm[24]%>"},
            {name: '四川', value: "<%=confirm[25]%>"},
            {name: '台湾', value: "<%=confirm[26]%>"},
            {name: '天津', value: "<%=confirm[27]%>"},
            {name: '西藏', value: "<%=confirm[28]%>"},
            {name: '香港', value: "<%=confirm[29]%>"},
            {name: '新疆', value: "<%=confirm[30]%>"},
            {name: '云南', value: "<%=confirm[31]%>"},
            {name: '浙江', value: "<%=confirm[32]%>"},
            {name: '重庆', value: "<%=confirm[33]%>"}
        ]
        var myChart = echarts.init(document.getElementById('main'));
        function randomValue() {
            return Math.round(Math.random()*1000);
        }
        option = {
            tooltip: {
                    formatter:function(params,ticket, callback){
                        return params.seriesName+'<br />'+params.name+'：'+params.value
                    }//数据格式化
                },
            visualMap: {
                min: 0,
                max: 850,
                left: 'left',
                top: 'bottom',
                text: ['高','低'],//取值范围的文字
                inRange: {
                    color: ['#FFFAFA', '#B22222']//取值范围的颜色
                },
                show:true//图注
            },
            geo: {
                map: 'china',
                roam: false,//不开启缩放和平移
                zoom:1.23,//视角缩放比例

                label: {
                    normal: {
                        show: true,
                        fontSize:'10',
                        color: 'black'
                    }
                },
                itemStyle: {
                    normal:{
                        borderColor: 'rgba(0, 0, 0, 0.2)'
                    },
                    emphasis:{
                        areaColor: '#87CEEB',//鼠标选择区域颜色
                        shadowOffsetX: 0,
                        shadowOffsetY: 0,
                        shadowBlur: 20,
                        borderWidth: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            },
            series : [
                {
                    name: '确诊',
                    type: 'map',
                    geoIndex: 0,
                    data:dataList
                }
            ]
        };
        myChart.setOption(option);
        myChart.on('click', function (params) {
            var pname = params.name;
            window.location.href="detail.jsp?name="+pname;
        });
    </script>
<script type="text/javascript">
        var yesterday_confirmed = 0, yesterday_died = 0, yesterday_cured = 0,
        yesterday_current_unconfirmed = 0, yesterday_current_serious = 0, yesterday_current_confirmed = 0;

        var progress = 0;
        var processDocTipsbg = '#FFFFFF';

        //3218435e78f4d1873ab412313d6d77c5
        var dataApi = '';
        dataApi = 'https://yiqing.ahusmart.com/overall';
        dataApi = 'https://api.tianapi.com/txapi/ncov/index?key=9d2ed450b9692452c645db9bb9febd8b';
    update();

        $('.tooltip').tooltipster({
            theme: 'tooltipster-shadow'
        });

        $(".statistics>li>strong").each(function () {
            $(this).bind("click", function () {
                $(this).attr('dataContent', '');
                $(this).removeClass('popshow');
            })


        });

        window.setInterval(() => update(), 1000 * 60 * 10);
function update() {// + "?" + Date.parse(new Date())
            $.getJSON(dataApi, function (newpneumoniadata) {

                var summaryDataIn = newpneumoniadata.newslist[0].desc;

                $(".datasubtitle").text("(截至 "
                    + new Date(summaryDataIn.modifyTime).Format("yyyy-MM-dd hh:mm:ss") + ")");

                /*累计确诊*/
                let confirmedCount = summaryDataIn.confirmedCount;

                /*累计死亡*/
                let deadCount = summaryDataIn.deadCount;

                /*累计治愈*/
                let curedCount = summaryDataIn.curedCount;

                /*现有确诊*/
                let currentConfirmedCount = summaryDataIn.currentConfirmedCount;

                /*现有重症*/
                let seriousCount = summaryDataIn.seriousCount;

                /*现有疑似*/
                let suspectedCount = summaryDataIn.suspectedCount;



                freshDataNum($(".statistics>li>strong").eq(0), currentConfirmedCount || yesterday_current_confirmed);
                freshDataNum($(".statistics>li>strong").eq(1), seriousCount || yesterday_current_serious);
                freshDataNum($(".statistics>li>strong").eq(2), suspectedCount || yesterday_current_unconfirmed);

                freshDataNum($(".statistics>li>strong").eq(3), confirmedCount || yesterday_confirmed);
                freshDataNum($(".statistics>li>strong").eq(4), deadCount || yesterday_died);
                freshDataNum($(".statistics>li>strong").eq(5), curedCount || yesterday_cured);

                freshbackgroud(currentConfirmedCount || yesterday_current_confirmed, confirmedCount || yesterday_confirmed);

                updateIncrease($(".statistics>li>span").eq(0), currentConfirmedCount, yesterday_current_confirmed);
                updateIncrease($(".statistics>li>span").eq(1), seriousCount, yesterday_current_serious);
                updateIncrease($(".statistics>li>span").eq(2), suspectedCount, yesterday_current_unconfirmed);

                updateIncrease($(".statistics>li>span").eq(3), confirmedCount, yesterday_confirmed);
                updateIncrease($(".statistics>li>span").eq(4), deadCount, yesterday_died);
                updateIncrease($(".statistics>li>span").eq(5), curedCount, yesterday_cured);

                console.log(summaryDataIn);

            })
        }


        function freshDataNum(target, newNum) {

            var oldNum = ~~(target.text());
            var increaseNum = ~~(target.attr('dataContent'));
            /* 右上角 即时新增数据*/
            if (oldNum != 0 && (newNum - oldNum) != 0) {
                target.attr('dataContent',
                    ((increaseNum + (newNum - oldNum)) >= 0 ? '+' : '')
                    + (increaseNum + (newNum - oldNum))
                );
                target.addClass('popshow');
            }
            else {
                //target.attr('dataContent', '');
            }

            target
                .prop('number', oldNum)
                .animateNumber({ number: newNum }, 3000);
        }

        function updateIncrease(target, newNum, oldNum) {
            if (newNum > 0 && oldNum > 0) {
                target.attr('dataContent', (newNum >= oldNum ? '+' : '') + (newNum - oldNum)
                );
            }
        }
        /* 动态改变背景 及 进度 刷新按钮动画*/
        function freshbackgroud(currentConfirmedCount, confirmedCount) {
            progress = 1 - currentConfirmedCount / confirmedCount;

            /*实时数据背景*/
            /*$('#realTimeData').css({ 'background-color': 'rgba(130, 210, 10, ' + 0 + ')' });
            $('#realTimeData').animate({ backgroundColor: 'rgba(130, 210, 10, ' + progress + ')' }, 3000);*/

            /*进度条进度*/
            /*$('.processValue').css({ 'width': 0 * 100 + '%' });
            $('.processValue').animate({ width: progress * 100 + '%' }, 3000);*/

            /*医生卡通位置*/
            /*$('.processDoc').css({ 'left': 0 * 100 + '%' });
            $('.processDoc').animate({ left: progress * 100 + '%' }, 3000);*/

            /*卡通提示背景*/
            let bgR = 255 * (1 - progress);
            let bgG = 255 * progress;
            processDocTipsbg = 'rgba(' + bgR + ', ' + bgG + ', 0, 0.9)'

            /*刷新按钮动画*/
            $(".freshBtn>svg").addClass("animation-rotate");
            window.setTimeout(() => $(".freshBtn>svg").removeClass("animation-rotate"), 3000);

        }

        var tipContent = ""
            + "1、数据每10分钟自动刷新一次，如有更新会在数字右上角提示。<br>"
            + "2、数字右下角为当前相对昨天24时官方数据的增（减）量。<br>"
            + "3、(实时数据采集自网络，仅供参考！实际数据以官方为准！！)<br>";
        var tip_index = 0;
        $(".datasubtitle").bind("mouseenter",
            function () {
                var that = this;
                tip_index = layer.tips(tipContent,
                    that,
                    {
                        tips: [1, 'white'],
                        time: 0
                    });
            }).bind("mouseleave", () => layer.close(tip_index))

        $(".processDoc").bind("mouseenter",
            function () {
                var that = this;
                if (progress < 1) {
                    tip_index = layer.tips(docTipContent,
                        that,
                        {
                            tips: [1, processDocTipsbg],
                            time: 0
                        });
                }
            }).bind("mouseleave", () => layer.close(tip_index))
        $(".freshBtn").click(function () {
            update();
        });

    </script>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?cdcc4d7a702f0597c5bfc96ec9508cbf";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>    
</body>
</html>