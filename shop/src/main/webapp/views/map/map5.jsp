<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #map5{
        width: auto;
        height: 400px;
        border: 2px solid white;
    }
</style>

<script>
    let map5 = {
        init:function() {
            let mapContainer = document.getElementById('map5'), // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(36.818178, 127.102313), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };
            let map = new kakao.maps.Map(mapContainer, mapOption);

            let imageSrc = '/img/강쥐.jpg', // 마커이미지의 주소입니다
                imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
                imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

            // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
            let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
                markerPosition = new kakao.maps.LatLng(36.818178, 127.102313); // 마커가 표시될 위치입니다
            // 마커를 생성합니다
            let marker = new kakao.maps.Marker({
                position: markerPosition,
                image: markerImage
            });


            marker.setMap(map);
        }
    }


    $(function(){
        map5.init()
    })

</script>


<div class="col-sm-10">
    <h2>map5</h2>
    <div id = "map5"></div>
</div>