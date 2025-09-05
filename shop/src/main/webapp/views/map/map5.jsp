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
            this.displayFixedMarker();
        },
        displayFixedMarker: function() {
            let markerPosition  = new kakao.maps.LatLng(36.800209, 127.074968);
            let marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(this.map);
        },
        showMarkers:function (){
            let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
            let imageSize = new kakao.maps.Size(24, 35);
            let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
            let positions = [
                {
                    id: 101,
                    title: '선문대학교 성화학숙',
                    content: '<div>선문대학교 성화학숙</div>',
                    latlng: new kakao.maps.LatLng(36.795919, 127.069644)
                },
                {
                    id: 102,
                    title: '선문대학교 아산캠퍼스 원화관',
                    content: '<div>선문대학교 아산캠퍼스 원화관</div>',
                    latlng: new kakao.maps.LatLng(36.800022, 127.077196)
                },
                {
                    id: 103,
                    title: '지중해마을',
                    content: '<div>지중해마을</div>',
                    latlng: new kakao.maps.LatLng(36.797473, 127.060479)
                },
            ];

            for (let i = 0; i < positions.length; i ++) {
                let marker = new kakao.maps.Marker({
                    map: this.map,
                    position: positions[i].latlng,
                    title : positions[i].title,
                    image : markerImage
                });

                let infowindow = new kakao.maps.InfoWindow({
                    content: positions[i].content
                });

                kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(this.map, marker, infowindow));
                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

                kakao.maps.event.addListener(marker, 'click', function() {
                    location.href = '/map/detail?id=' + positions[i].id;
                });
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
        }
    };

    function makeOverListener(map, marker, infowindow) {
        return function() {
            infowindow.open(map, marker);
        };
    }

    function makeOutListener(infowindow) {
        return function() {
            infowindow.close();
        };
    }


    $(function(){
        map5.init()
    });
</script>

<div class="col-sm-10">
    <h2>Map5</h2>
    <div id="map5"></div>
</div>