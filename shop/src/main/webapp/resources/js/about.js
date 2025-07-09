// 윈도우 시작 시 지도 로드
window.onload = function () {
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(37.4809094, 126.9520957), // 서울시청 좌표
        level: 3
    };

    var map = new kakao.maps.Map(container, options);
    
 	// 마커가 표시될 위치입니다 
    var markerPosition  = new kakao.maps.LatLng(37.4809094, 126.9520957); 

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);
};