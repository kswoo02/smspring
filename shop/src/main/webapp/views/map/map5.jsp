<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #map5{
        width:auto;
        height:400px;
        border:2px solid lightblue;
    }
</style>

<script>
    let map5 = {
        map:null,
        init: function(){
            this.makeMap();
            this.showMarkers();
        },
        showMarkers:function (){
            let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
            let imageSize = new kakao.maps.Size(24, 35);
            let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
            let positions = [
                {
                    content: '<div>선문대학교 성화학숙</div>',
                    latlng: new kakao.maps.LatLng(36.795919, 127.069644)
                },
                {
                    content: '<div>선문대학교 아산캠퍼스 원화관</div>',
                    latlng: new kakao.maps.LatLng(36.800022, 127.077196)
                },
                {
                    content: '<div>지중해마을</div>',
                    latlng: new kakao.maps.LatLng(
                        36.797473, 127.060479)
                },

            ];
            for (let i = 0; i < positions.length; i ++) {
                // 마커를 생성합니다
                let marker = new kakao.maps.Marker({

                    position: positions[i].latlng, // 마커를 표시할 위치
                    title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                    image : markerImage // 마커 이미지
                });
                marker.setMap(this.map)

            }
        },
        makeMap:function(){
            let mapContainer = document.getElementById('map5');
            let mapOption = {
                center: new kakao.maps.LatLng(36.800209, 127.074968),
                level: 7
            }
            this.map = new kakao.maps.Map(mapContainer, mapOption);
            let mapTypeControl = new kakao.maps.MapTypeControl();
            this.map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            let zoomControl = new kakao.maps.ZoomControl();
            this.map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

            // Marker 생성
            let markerPosition  = new kakao.maps.LatLng(36.800209, 127.074968);
            let marker = new kakao.maps.Marker({
                position: markerPosition,
                map: this.map
            });
        }
    }

    $(function(){
        map5.init()
    })
</script>

<div class="col-sm-10">
    <h2>Map5 커피숍 찾기</h2>
    <div id="map5"></div>
</div>