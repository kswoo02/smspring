<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  #container1{
    width: 300px;
    border: 1px solid black;
  }
  #container2{
    width: 300px;
    border: 1px solid yellow;
  }
  #container3{
    width: 300px;
    border: 1px solid blue;
  }
  #container4{
    width: 300px;
    border: 1px solid blue;
  }
</style>

<script>
  chart2={
    init:function(){
      this.getdata1();
      this.getdata2();
      this.getdata3();
      this.getdata4();
    },
    getdata1:function(){
      $.ajax({
        url:'/chart2_1',
        success:(data)=>{
          this.chart1(data);
        }
      });
    },
    getdata2:function(){
      $.ajax({
        url:'/chart2_2',
        success:(data)=>{
          this.chart2(data);
        }
      });
    },
    getdata3:function(){
      $.ajax({
        url:'/chart2_3',
        success:(data)=>{
          this.chart3(data);

        }
      });
    },
    getdata4:function(){
      $.ajax({
        url:'/chart2_4',
        success:(data)=>{
          alert(data);
        }
      })
    },
    chart1:function(data){
      Highcharts.chart('container1', {
        chart: {
          type: 'pie',
          options3d: {
            enabled: true,
            alpha: 45
          }
        },
        title: {
          text: 'Beijing 2022 gold medals by country'
        },
        subtitle: {
          text: '3D donut in Highcharts'
        },
        plotOptions: {
          pie: {
            innerSize: 100,
            depth: 45
          }
        },
        series: [{
          name: 'Medals',
          data: data
        }]
      });

    },
    chart2:function(data){
      Highcharts.chart('container2', {
        chart: {
          type: 'cylinder',
          options3d: {
            enabled: true,
            alpha: 15,
            beta: 15,
            depth: 50,
            viewDistance: 25
          }
        },
        title: {
          text: 'Number of confirmed COVID-19'
        },
        subtitle: {
          text: 'Source: ' +
                  '<a href="https://www.fhi.no/en/id/infectious-diseases/coronavirus/daily-reports/daily-reports-COVID19/"' +
                  'target="_blank">FHI</a>'
        },
        xAxis: {
          categories: data.cate,
          title: {
            text: 'Age groups'
          },
          labels: {
            skew3d: true
          }
        },
        yAxis: {
          title: {
            margin: 20,
            text: 'Reported cases'
          },
          labels: {
            skew3d: true
          }
        },
        tooltip: {
          headerFormat: '<b>Age: {category}</b><br>'
        },
        plotOptions: {
          series: {
            depth: 25,
            colorByPoint: true
          }
        },
        series: [{
          data: data.data,
          name: 'Cases',
          showInLegend: true
        }]
      });
    },
    chart3:function (data){ // 파라미터로 데이터를 받습니다.

      // JavaScript 내에서 텍스트를 처리하던 로직은 모두 삭제합니다.

      Highcharts.chart('container3', {
        // ... (차트 옵션)
        series: [{
          type: 'wordcloud',
          data: data, // 서버에서 받은 데이터를 그대로 사용합니다.
          name: 'Occurrences'
        }],
        // ... (차트 옵션)
      });
    },
    chart4:function(){

    }
  }
  $(()=>{
    chart2.init();
  });
</script>
<div class="col-sm-10">
  <h2>Chart2</h2>
  <div class="row">
    <div class="col-sm-6" id="container1"></div>
    <div class="col-sm-6" id="container2"></div>
    <div class="col-sm-6" id="container3"></div>
    <div class="col-sm-6" id="container4"></div>
  </div>
</div>