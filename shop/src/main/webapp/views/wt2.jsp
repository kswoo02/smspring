<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #map{
        width:auto;
        height:400px;
        border:2px solid red;
    }
    #weather-result {
        border: 2px solid green;
        margin-top: 10px;
        padding: 15px;
    }
</style>

<script>
    let wt2 = {
        map:null,
        locations: {
            '108': { name: '전국', lat: 36.800209, lng: 127.074968 },
            '109': { name: '서울', lat: 37.566826, lng: 126.9786567 },
            '131': { name: '충청', lat: 36.3504119, lng: 127.3845475 }
        },
        init:function(){
            this.makeMap();
            this.cityBtn();
        },
        makeMap:function(){
            let mapContainer = document.getElementById('map');
            let mapOption = {
                center: new kakao.maps.LatLng(36.800209, 127.074968),
                level: 5
            }
            this.map = new kakao.maps.Map(mapContainer, mapOption);
            let mapTypeControl = new kakao.maps.MapTypeControl();
            this.map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            let zoomControl = new kakao.maps.ZoomControl();
            this.map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

        },
        cityBtn:function (){
            $('#get_btn').click(()=>{
                let loc = $('#loc').val();
                this.moveMap(loc);
                this.getData(loc);
            })
        },
        getData:function(loc){
            $.ajax({
                url: '<c:url value ="/getwt1"/>',
                data: {'loc':loc},
                success: (data) =>{
                    console.log(data);
                    this.display(data);
                }
            })
        },
        // 지도 이동을 담당하는 새로운 함수
        moveMap: function(loc){
            // 1. loc 값으로 locations 객체에서 목적지 정보를 찾습니다.
            let targetLocation = this.locations[loc];

            // 2. 목적지의 위도, 경도로 좌표 객체를 만듭니다.
            let moveLatLon = new kakao.maps.LatLng(targetLocation.lat, targetLocation.lng);

            // 3. panTo 함수로 지도를 이동시킵니다.
            this.map.panTo(moveLatLon);
        },
        display:function(data){
            let txt = data.response.body.items.item[0].wfSv;
            $('#weather-result').html(txt);
        }
    }
    $(function(){
        wt2.init();
    });
</script>



<div class="col-sm-10">
    <h2>Weather 2 Page</h2>
    <select id="loc">
        <option value="108">전국</option>
        <option value="109">서울</option>
        <option value="131">충청</option>
    </select>
    <button id="get_btn">Get</button>
    <h5 id="status"></h5>
    <div id="map"></div>
    <div id ="weather-result"></div>
</div>