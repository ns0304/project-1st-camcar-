<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 날짜 등의 출력 형식 변경을 위한 JSTL - format(fmt) 라이브러리 등록 --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- jquery 라이브러리 포함시키기 --%>
<script src="${pageContext.request.servletContext.contextPath}/resources/js/jquery-3.7.1.js"></script>
<%-- 카카오지도 설치 스크립트 --%>
<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
				

<style>

/* 지점 선택, 차종 선택 버튼 정렬 */
.brc_btn, #car_opt {
	display: flex;
}
.brc_btn input, #car_opt input {
	width: 50%;
	background-color: #f1f3f5;
}

/* 지점 상세 설명 팝업창 */
#res_detail1, #res_detail2 {
	display: none;
	position: absolute;
    right: 8px;
    top: 8px;
    right: 430px;
	background-color: #fff;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    z-index: 1000;
  	border-radius: 12px;
  	width: 400px;
  	padding: 20px;
  	box-sizing: border-box;
}

/* 팝업창 내 버튼, 예약하기 버튼 */
#res_apply1, #res_apply2, #res_assembly {
    width: 95%;
    color: white;
    cursor: pointer;
    background-color: #59b9a9;
}
.map {
	width: 100%;
	height: 250px;
}
.reset, .close {
    cursor: pointer;
    font-size: 16px;
    float: right;
}


/* 예약정보 선택 아이콘 크기 지정 */
#brc_sel img, #schedule_sel img, #car_sel img {
	width: 15px; height: 15px;
}

#car_sel input {
	display: none;
}
#car_sel input~ label {
    cursor: pointer;
	height: 40px;
	margin: 5px;
	border-radius: 5px;
	border: none;
	background-color: #f1f3f5;
	width: 25%;
	padding-top: 8px;
	font-size: 14px;
}

/* 버튼 css */
input[type=button], input[type=reset], #res_assembly {
    cursor: pointer;
	height: 40px;
	margin: 10px;
	border-radius: 5px;
	border: none;
}
input[type=button]:hover, input[type=reset]:hover, #res_assembly {
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
}

</style>


<script type="text/javascript">
let map; // 지도 객체를 전역 변수로 선언

$(document).ready(function() {
	// 1. 각 지점 버튼 클릭 시 상세설명(레이어팝업) 열림/닫힘
    $("#busan").click(function() {
        // 상세 설명 창을 토글
        $("#res_detail1").toggle();
        
        // 지도 컨테이너가 이미 존재하는지 확인
        if (!$("#daumRoughmapContainer1720494911728").children().length) {
            // 지도 노드가 존재하지 않으면 지도 렌더링
            new daum.roughmap.Lander({
                "timestamp" : "1720494911728",
                "key" : "2jyf3",
                "mapWidth" : "360",
                "mapHeight" : "250"
            }).render();
        }
    });

	$("#seoul").click(function() {
        // 상세 설명 창을 토글
		$("#res_detail2").toggle();
        
        // 지도 컨테이너가 이미 존재하는지 확인
        if (!$("#daumRoughmapContainer1720495062115").children().length) {
            // 지도 노드가 존재하지 않으면 지도 렌더링
            new daum.roughmap.Lander({
                "timestamp" : "1720495062115",
                "key" : "2jyf4",
                "mapWidth" : "360",
                "mapHeight" : "250"
            }).render();
        }
	});
	// ------------------------------------------------------------------------
	
	// 2. 지점 선택 버튼 클릭 시 hidden에 value 값 저장되면서 상세설명 닫기
	$("#res_apply1").click(function() {
		let brcInfo = $("#res_apply1").val();
		let hidden = $("#brc_rent_name").val(brcInfo);	// hidden 필드에 값 저장
// 	    alert("선택된 지점 : " + hidden.val());	// 선택된 지점 : 캠핑갈카 부산본점
	    $("#res_detail1").hide();
	    $("#res_detail2").hide();
		$("#busan").css("border", "2px solid #ccc");
		$("#seoul").css("border", "none");
	});
	$("#res_apply2").click(function() {
		let brcInfo = $("#res_apply2").val();
		let hidden = $("#brc_rent_name").val(brcInfo);	// hidden 필드에 값 저장
// 	    alert("선택된 지점 : " + hidden.val());	// 선택된 지점 : 캠핑갈카 서울지점
	    $("#res_detail1").hide();
	    $("#res_detail2").hide();
		$("#seoul").css("border", "2px solid #ccc");
		$("#busan").css("border", "none");
	});
	// ------------------------------------------------------------------------
	
	// 3. 차종 선택 시 전체선택 해제(기본은 전체선택)
	$("#campingCar").click(function() {
		$("#checkAllCar").prop("checked", false);
		$("label[for='checkAllCar']").css("border", "none");
		if($("#campingCar").prop("checked")) {	// '캠핑카' 체크 시 border 표시
			$("label[for='campingCar']").css("border", "2px solid #ccc");
		} else {	// 선택 해제
			$("label[for='campingCar']").css("border", "none");
		}
	});
	$("#suv").click(function() {
		$("#checkAllCar").prop("checked", false);
		$("label[for='checkAllCar']").css("border", "none");
		if($("#suv").prop("checked")) {	// 'SUV' 체크 시 border 표시
			$("label[for='suv']").css("border", "2px solid #ccc");
		} else {	// 선택 해제
			$("label[for='suv']").css("border", "none");
		}
	});
	$("#smallCar").click(function() {
		$("#checkAllCar").prop("checked", false);
		$("label[for='checkAllCar']").css("border", "none");
		if($("#smallCar").prop("checked")) {	// '소형차' 체크 시 border 표시
			$("label[for='smallCar']").css("border", "2px solid #ccc");
		} else {	// 선택 해제
			$("label[for='smallCar']").css("border", "none");
		}
	});
	// '전체' 버튼 클릭 시 다시 리셋
	$("#checkAllCar").click(function() {
		$("#campingCar").prop("checked", false);
		$("label[for='campingCar']").css("border", "none");
		$("#suv").prop("checked", false);
		$("label[for='suv']").css("border", "none");
		$("#smallCar").prop("checked", false);
		$("label[for='smallCar']").css("border", "none");
		if($("#checkAllCar").prop("checked")) {	// '전체' 체크 시 border 표시
			$("label[for='checkAllCar']").css("border", "2px solid #ccc");
		} else {	// 선택 해제
			$("label[for='checkAllCar']").css("border", "none");
		}
		
	});
	
	
	// ------------------------------------------------------------------------
	// 4. 닫기(X) 클릭 시 팝업창 닫기
	$(".close").click(function() {
	    $("#res_detail1").hide();
	    $("#res_detail2").hide();
	});
	
	// ------------------------------------------------------------------------
	// 5. submit 클릭 시 이벤트 처리 지점, 일정 미선택 시 
	$("#carList").submit(function() {
		if($("#brc_rent_name").val() == "") {
			alert("지점을 선택해주세요!");
			return false; // submit 동작 취소
		} else if($("#res_rental_date").val() == "" || $("#start_time").val() == "" || $("#res_return_date").val() == "" || $("#end_time").val() == "") {
			alert("일정을 선택해주세요!");
			return false;
		} else if($("#start_date").val() == $("#end_date").val()) {
			alert("도착일을 다시 지정해주세요!");
			return false;
		}
		// 위의 모든 조건 통과 시 submit 동작 수행(return true 생략)
	});
	
	// ------------------------------------------------------------------------
	// 6. reset 모양 클릭 시 carList 폼 리셋
	$(".reset").click(function() {
	    $("#carList")[0].reset();
	 });
});
</script>

<%-- ============================================================================= --%>
<div class="resForm_wrap">
	<form action="CarList" name="carList" id="carList" method="post">
		<div id="res_sel" style="margin-bottom: 10px;">
			<b>예약정보를 선택해주세요</b>
<!-- 			<input type="reset" id="res_reset"><label for="res_reset" style="margin-right: 20px;">&#10226;</label> -->
			<span class="reset" style="margin-right: 20px;">&#10226;</span>
		</div>
		<!-- ------- 지점 선택 영역 ---------------------------------------------- -->
		<div id="brc_sel">
			<a><img alt="pin.png" src="${pageContext.request.servletContext.contextPath}/resources/img/icon/pin.png"> 지점 선택</a>
			<div class="brc_btn" align="center">
				<input type="button" id="busan" value="부산">
				<input type="button" id="seoul" value="서울">
				<input type="hidden" id="brc_rent_name" name="brc_rent_name" value=""> <!-- 숨겨진 입력 필드 -->
			</div>
		</div>
		<hr>
		
		<!-- ------- 일정 선택 영역 ---------------------------------------------- -->
		<div id="schedule_sel">
<!-- 			<a href="#">&#128467; 일정 선택</a><br> -->
			<a><img alt="calendar.png" src="${pageContext.request.servletContext.contextPath}/resources/img/icon/calendar.png"> 일정 선택</a><br>
			<jsp:include page="/WEB-INF/views/reservation/cal.jsp"></jsp:include>
		</div>
		<hr>
		
		<!-- ------- 차종 선택 영역 ---------------------------------------------- -->
		<div id="car_sel">
			<a><img alt="campingcar.png" src="${pageContext.request.servletContext.contextPath}/resources/img/icon/campingcar.png"> 차종 선택</a>
			<div class="car_btn" align="center">
				<div id="car_opt">
					<input type="checkbox" id="checkAllCar" checked><label for="checkAllCar" style="border: 2px solid #ccc;">전체</label>
					<input type="checkbox" name="car_opt" id="campingCar" value="캠핑카"><label for="campingCar">캠핑카</label>
					<input type="checkbox" name="car_opt" id="suv" value="SUV"><label for="suv">SUV</label>
					<input type="checkbox" name="car_opt" id="smallCar" value="소형차"><label for="smallCar">소형차</label>
				</div>
			</div>
		</div>
		
		
		<!-- ------- 차량 조회 및 예약 버튼 -------------------------------------- -->
		<div>
<!-- 			<input type="hidden" id="fuel_opt" name="fuel_opt" value=""> -->
			<input type="submit" id="res_assembly" value="차량 조회하고 예약하기">
		</div>
	</form>
	
	<!-- ------- 지점 상세 정보(레이어팝업) -------------------------------------- -->
	<div id="res_detail1">
		<span class="close">&times;</span><br>
		<div>
			<div class="map">
				<!-- 지도 노드 -->
				<div id="daumRoughmapContainer1720494911728" class="root_daum_roughmap root_daum_roughmap_landing"></div>
			</div>
		</div>
		<br><br>
		<b style="font-size: 18px;">캠핑갈카 부산본점</b>
		<p style="font-size: 14px;">주소<br> 부산 부산진구 동천로 109 삼한골든게이트 1층<br><br>
									전화<br>051-1234-5678<br><br>
									이용 가능한 시간<br>대여 07:00 ~ 22:30<br>반납 06:00 ~ 21:30</p>
		<input type="button" name="apply" id="res_apply1" value="캠핑갈카 부산본점">
	</div>
	<div id="res_detail2">
		<span class="close">&times;</span><br>
		<div>
			<div class="map">
				<!-- 지도 노드 -->
				<div id="daumRoughmapContainer1720495062115" class="root_daum_roughmap root_daum_roughmap_landing"></div>
			</div>
		</div>
		<br><br>
		<b style="font-size: 18px;">캠핑갈카 서울지점</b>
		<p style="font-size: 14px;">주소<br> 서울 용산구 한강대로 350 갑을빌딩 1층<br><br>
									전화<br>02-1234-5678<br><br>
									이용 가능한 시간<br>대여 07:00 ~ 22:30<br>반납 06:00 ~ 21:30</p>
		<input type="button" name="apply" id="res_apply2" value="캠핑갈카 서울지점">
	</div>

	<!-- 캘린더 -->
	<div>
<%-- 		<jsp:include page="/WEB-INF/views/reservation/calendar.jsp"></jsp:include> --%>
	</div>
</div>
