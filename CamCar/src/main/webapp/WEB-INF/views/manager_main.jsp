<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일(css/default.css) 연결하기 --%>
<link
	href="${pageContext.request.servletContext.contextPath}/resources/css/manager_default.css"
	rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // 예제 데이터, 실제 데이터로 대체 필요
    // 일단은 그냥 chatgpt로 만들었는데 나중에 대대적인 수정 필요!!!
    let monthlySalesData = {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        datasets: [{
            label: '월 매출 통계',
            data: [12000, 15000, 8000, 18000, 20000, 22000, 24000, 26000, 20000, 21000, 22000, 13000],
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    };

    let popularModelsData = {
        labels: ['레이', '카니발(하이 리무진)', '카니발', '스타리아(아클란S)','팰리세이드'],
        datasets: [{
            label: '인기 차량 모델 순위',
            data: [30, 20, 40, 10, 10],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 100, 192, 0.2)',
                'rgba(75, 192, 192, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 100, 192, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1
        }]
    };

    let rentalCountsData = {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        datasets: [{
            label: '월별 렌트 횟수',
            data: [50, 60, 40, 70, 80, 90, 40, 50, 60, 70, 80, 40],
            backgroundColor: 'rgba(153, 102, 255, 0.2)',
            borderColor: 'rgba(153, 102, 255, 1)',
            borderWidth: 1
        }]
    };

    let ageGroupData = {
        labels: ['18-25', '26-35', '36-45', '46-55', '56+'],
        datasets: [{
            label: '연령대별 이용자',
            data: [15, 20, 25, 30, 10],
            backgroundColor: [
                'rgba(255, 159, 64, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
                'rgba(255, 159, 64, 1)',
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)'
            ],
            borderWidth: 1
        }]
    };

    // 차트 렌더링
    window.onload = function() {
        let ctx1 = document.getElementById('monthlySalesChart').getContext('2d');
        new Chart(ctx1, {
            type: 'bar',
            data: monthlySalesData,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        let ctx2 = document.getElementById('popularModelsChart').getContext('2d');
        new Chart(ctx2, {
            type: 'pie',
            data: popularModelsData
        });

        let ctx3 = document.getElementById('rentalCountsChart').getContext('2d');
        new Chart(ctx3, {
            type: 'line',
            data: rentalCountsData,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        let ctx4 = document.getElementById('ageGroupChart').getContext('2d');
        new Chart(ctx4, {
            type: 'doughnut',
            data: ageGroupData
        });
    };
</script>
<style type="text/css">
#articleForm {
	width: 500px;
	margin: auto;
}
</style>
</head>
<body>
	<header>
		<%-- 기본 메뉴 표시 영역(inc/top.jsp) 페이지 삽입 --%>
		<%-- 현재 위치는 컨텍스트 루트(/MVC_Board = webapp) 이므로 inc 디렉토리의 top.jsp 지정 --%>
		<jsp:include page="/WEB-INF/views/inc/manager_top.jsp"></jsp:include>
	</header>
	<main>
		<aside>
			<jsp:include page="/WEB-INF/views/inc/menu.jsp"></jsp:include>
		</aside>
		<section id="articleForm">
			<article>
				<%-- 본문 표시 영역 --%>
				<h1>총 월 매출 통계</h1>
				<canvas id="monthlySalesChart"></canvas>
				<h1>인기차량 모델 순위</h1>
				<canvas id="popularModelsChart"></canvas>
				<h1>월별 렌트 횟수 통계</h1>
				<canvas id="rentalCountsChart"></canvas>
				<h1>연령대별 이용자 통계</h1>
				<canvas id="ageGroupChart"></canvas>
			</article>
		</section>
	</main>
	<footer>
		<%-- 회사 소개 영역(inc/bottom.jsp) 페이지 삽입 --%>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>


