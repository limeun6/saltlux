<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page session="false"%>
<script src="https://code.iconify.design/2/2.1.2/iconify.min.js"></script>
<%@ include file="./include/header.jsp"%>
<!-- ======= Hero Section ======= -->
<section id="hero" class="d-flex align-items-center" style="padding: 10px 0 100px 0; height: 100%;">
	<div class="container">
		<div class="row">
			<div class="col-lg-6 d-lg-flex flex-lg-column justify-content-center align-items-stretch pt-5 pt-lg-0 order-2 order-lg-1" data-aos="fade-up">
				<div>
					<h1>Sentimental And Emotional Analysis Of Counselors.</h1>
					<h2>Providing detailed analysis services during counseling to
						protect the emotional consumption of counselors.</h2>
					<a href="chatting" class="download-btn" style="width: 200px"><span class="iconify" data-icon="bx:conversation" data-width="40" data-height="40"></span>&nbsp 대화하기 </a>
				</div>
			</div>
			<div class="col-lg-6 d-lg-flex flex-lg-column align-items-stretch order-1 order-lg-2 hero-img" data-aos="fade-up">
				<img src="assets/img/hero-img.png" class="img-fluid" alt="">
			</div>
		</div>
	</div>

</section>
<!-- End Hero -->

<style>
#footer{
	position: fixed;
	width: 100%;
	bottom: 0;
}
</style>
<%@ include file="./include/footer.jsp"%>