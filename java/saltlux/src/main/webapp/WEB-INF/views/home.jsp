<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>3조를 벌조</title>
  
  <!-- PLUGINS CSS STYLE -->
  <!-- Bootstrap -->
  <link href="plugins/bootstrap/bootstrap.min.css" rel="stylesheet">
  <!-- themify icon -->
  <link rel="stylesheet" href="plugins/themify-icons/themify-icons.css">
  <!-- Slick Carousel -->
  <link href="plugins/slick/slick.css" rel="stylesheet">
  <!-- Slick Carousel Theme -->
  <link href="plugins/slick/slick-theme.css" rel="stylesheet">
  
  <!-- CUSTOM CSS -->
  <link href="css/style.css" rel="stylesheet">

  <!-- FAVICON -->
  <link href="images/favicon.png" rel="shortcut icon">

</head>

<body class="body-wrapper">


<nav class="navbar main-nav fixed-top navbar-expand-lg large">
  <div class="container">
      <a class="navbar-brand" href="homepage.html"><img src="images/logo.png" alt="logo"></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="ti-menu text-white"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a class="nav-link scrollTo" href="#home">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link scrollTo" href="#about">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link scrollTo" href="#feature">Features</a>
        </li>
        <li class="nav-item">
          <a class="nav-link scrollTo" href="#pricing">Pricing</a>
        </li>
        <li class="nav-item">
          <a class="nav-link scrollTo" href="#team">Team</a>
        </li>
        <li class="nav-item">
          <a class="nav-link scrollTo" href="#contact">Contact</a>
        </li>
      </ul>
      </div>
  </div>
</nav>
<!--=====================================
=            Homepage Banner            =
======================================-->

<section class="banner bg-1" id="home">
	<div class="container">
		<div class="row">
			<div class="col-md-8 align-self-center">
				<!-- Contents -->
				<div class="content-block">
					<h1>3조</h1>
					<h5>솔트룩스 채용연계과정</h5>
				</div>
				<form action="http://127.0.0.1:5000/test1" method="post" enctype="multipart/form-data">
					데이터<input type="text" name="data"><p>
					파일<input type="file" name="file"><p>
					<input type="submit" value="요청">
					<input type="reset" value="취소">

				</form>
			</div>
			<div class="col-md-4">
				
			</div>
		</div>
	</div>
</section>

<!--====  End of Homepage Banner  ====-->

<!--===========================
=            About            =
============================-->

<section class="about section bg-2" id="about">
	<div class="container">
		<div class="row">
			<div class="col-lg-6 align-self-center text-center">
				<!-- Image Content -->
				<div class="image-block">
					<img class="phone-thumb-md" src="images/phones/iphone-feature.png" alt="iphone-feature" class="img-fluid">
				</div>
			</div>
			<div class="col-lg-6 col-md-10 m-md-auto align-self-center ml-auto">
				<div class="about-block">
					<!-- About 01 -->
					<div class="about-item">
						<div class="icon">
							<i class="ti-palette"></i>
						</div>
						<div class="content">
							<h5>Creative Design</h5>
							<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born
								and I will give you a complete accounta</p>
						</div>
					</div>
					<!-- About 02 -->
					<div class="about-item active">
						<div class="icon">
							<i class="ti-panel"></i>
						</div>
						<div class="content">
							<h5>Easy to Use</h5>
							<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born
								and I will give you a complete accounta</p>
						</div>
					</div>
					<!-- About 03 -->
					<div class="about-item">
						<div class="icon">
							<i class="ti-vector"></i>
						</div>
						<div class="content">
							<h5>Best User Experience</h5>
							<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born
								and I will give you a complete accounta</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--====  End of About  ====-->

<!--==============================
=            Features            =
===============================-->

<section class="section feature" id="feature">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-title">
					<h2>App Features</h2>
					<p>Demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee idea of
						denouncing pleasure and praising</p>
				</div>
			</div>
		</div>
		<div class="row bg-elipse">
			<div class="col-lg-4 align-self-center text-center text-lg-right">
				<!-- Feature Item -->
				<div class="feature-item">
					<!-- Icon -->
					<div class="icon">
						<i class="ti-brush-alt"></i>
					</div>
					<!-- Content -->
					<div class="content">
						<h5>Beautiful Interface Design</h5>
						<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
					</div>
				</div>
				<!-- Feature Item -->
				<div class="feature-item">
					<!-- Icon -->
					<div class="icon">
						<i class="ti-gift"></i>
					</div>
					<!-- Content -->
					<div class="content">
						<h5>Unlimited Features</h5>
						<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
					</div>
				</div>
			</div>
			<div class="col-lg-4 text-center">
				<!-- Feature Item -->
				<div class="feature-item mb-0">
					<!-- Icon -->
					<div class="icon">
						<i class="ti-comments"></i>
					</div>
					<!-- Content -->
					<div class="content">
						<h5>Full free chat</h5>
						<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
					</div>
				</div>
				<div class="app-screen">
					<img class="img-fluid" src="images/phones/i-phone-screen.png" alt="app-screen">
				</div>
				<!-- Feature Item -->
				<div class="feature-item">
					<!-- Icon -->
					<div class="icon">
						<i class="ti-support"></i>
					</div>
					<!-- Content -->
					<div class="content">
						<h5>24/7 support by real people</h5>
						<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
					</div>
				</div>
			</div>
			<div class="col-lg-4 text-center text-lg-left align-self-center">
				<!-- Feature Item -->
				<div class="feature-item">
					<!-- Icon -->
					<div class="icon">
						<i class="ti-image"></i>
					</div>
					<!-- Content -->
					<div class="content">
						<h5>Retina ready greaphics</h5>
						<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
					</div>
				</div>
				<!-- Feature Item -->
				<div class="feature-item">
					<!-- Icon -->
					<div class="icon">
						<i class="ti-pie-chart"></i>
					</div>
					<!-- Content -->
					<div class="content">
						<h5>IOS & android version </h5>
						<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--====  End of Features  ====-->

<!--=================================
=            Promo Video            =
==================================-->

<section class="section promo-video bg-3 overlay">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Promo Video -->
				<div class="video">
					<img class="img-fluid" src="images/backgrounds/promo-video-bg.jpg" alt="video-thumbnail">
					<div class="video-button video-box">
						<!-- Video Play Button -->
						<a href="javascript:void(0)">
							<span class="icon" data-video="https://www.youtube.com/embed/jrkvirglgaQ?autoplay=1">
								<i class="ti-control-play"></i>
							</span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--====  End of Promo Video  ====-->

<!--===================================
=            Pricing Table            =
====================================-->

<section class="pricing section bg-shape" id="pricing">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-title mb-4">
					<h2 class="mb-3">Choose Your Subscription Plan</h2>
					<p>Demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee idea of
						denouncing pleasure and praising</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-4 col-md-6">
				<!-- Pricing Table -->
<div class="pricing-table text-center">	
	<!-- Title -->
	<div class="title">	
		<h5>Free</h5>
	</div>
	<!-- Price Tag -->
	<div class="price">	
		<p>$0<span>/month</span></p>
	</div>
	<!-- Features -->
	<ul class="feature-list">
		<li>Android App</li>
		<li>One time payment</li>
		<li>Build & Publish</li>
		<li>Life time support</li>
	</ul>
	<!-- Take Action -->
	<div class="action-button">
		<a href="" class="btn btn-main-rounded">Start Now</a>
	</div>
</div>
			</div>
			<div class="col-lg-4 col-md-6">
				<!-- Pricing Table -->
<div class="pricing-table featured text-center">	
	<!-- Title -->
	<div class="title">	
		<h5>Basic</h5>
	</div>
	<!-- Price Tag -->
	<div class="price">	
		<p>$19<span>/month</span></p>
	</div>
	<!-- Features -->
	<ul class="feature-list">
		<li>Android App</li>
		<li>One time payment</li>
		<li>Build & Publish</li>
		<li>Life time support</li>
	</ul>
	<!-- Take Action -->
	<div class="action-button">
		<a href="" class="btn btn-main-rounded">Start Now</a>
	</div>
</div>
			</div>
			<div class="col-lg-4 col-md-6 m-md-auto">
				<!-- Pricing Table -->
<div class="pricing-table text-center">	
	<!-- Title -->
	<div class="title">	
		<h5>Advance</h5>
	</div>
	<!-- Price Tag -->
	<div class="price">	
		<p>$99<span>/month</span></p>
	</div>
	<!-- Features -->
	<ul class="feature-list">
		<li>Android App</li>
		<li>One time payment</li>
		<li>Build & Publish</li>
		<li>Life time support</li>
	</ul>
	<!-- Take Action -->
	<div class="action-button">
		<a href="" class="btn btn-main-rounded">Start Now</a>
	</div>
</div>
			</div>
		</div>
	</div>
</section>

<!--====  End of Pricing Table  ====-->

<!--=============================================
=            Call to Action Download            =
==============================================-->

<section class="cta-download bg-3 overlay">
	<div class="container">
		<div class="row">
			<div class="col-lg-5 text-center">
				<div class="image-block"><img class="phone-thumb img-fluid" src="images/phones/iphone-chat.png" alt=""></div>
			</div>
			<div class="col-lg-7">
				<div class="content-block">
					<!-- Title -->
					<h2>Free Download Now</h2>
					<!-- Desctcription -->
					<p>Demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee idea of
						denouncing pleasure and praising</p>
					<!-- App Badge -->
					<div class="app-badge">
						<ul class="list-inline">
							<li class="list-inline-item">
								<a href="#" class="btn btn-download"><i class="ti-android"></i>
									<div>Get it on the<span>GOOGLE PLAY</span></div>
								</a>
							</li>
							<li class="list-inline-item">
								<a href="#" class="btn btn-download"><i class="ti-apple"></i>
									<div>Available on the<span>Apple store</span></div>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--====  End of Call to Action Download  ====-->

<!--=============================
=            Counter            =
==============================-->

<section class="section counter bg-gray">
	<div class="container">
		<div class="row">
			<div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
				<div class="counter-item">
					<!-- Counter Number -->
					<h3><span class="count" data-count="29">0</span>k</h3>
					<!-- Counter Name -->
					<p>Download</p>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
				<div class="counter-item">
					<!-- Counter Number -->
					<h3><span class="count" data-count="200">0</span>k</h3>
					<!-- Counter Name -->
					<p>Active Account</p>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
				<div class="counter-item">
					<!-- Counter Number -->
					<h3><span class="count" data-count="60">0</span>k</h3>
					<!-- Counter Name -->
					<p>Happy User</p>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
				<div class="counter-item">
					<!-- Counter Number -->
					<h3><span class="count" data-count="300">0</span>k<sup>+</sup></h3>
					<!-- Counter Name -->
					<p>Download</p>
				</div>
			</div>
		</div>
	</div>
</section>

<!--====  End of Counter  ====-->

<!--==========================
=            Team            =
===========================-->

<section class="section team bg-shape-two" id="team">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-title mb-4">
					<h2 class="mb-3">Our Creative Team</h2>
					<p>Demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee idea of
						denouncing pleasure and praising</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-3 col-md-6">
				<!-- Team Member -->
<div class="team-member text-center mb-4 mb-lg-0">
	<div class="image">
		<img class="img-fluid" src="images/team/member-one.jpg" alt="team-member">
	</div>
	<div class="name">
		<h5>Johnny Depp</h5>
	</div>
	<div class="position">
		<p>Production Designer</p>
	</div>
	<div class="skill-bar">
		<div class="progress">
		  	<div class="progress-bar" style="width:85%;"></div>
		</div>
		<span>85%</span>
	</div>
	<ul class="social-icons list-inline">
		<li class="list-inline-item">
			<a href=""><i class="ti-facebook"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-twitter-alt"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-linkedin"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-instagram"></i></a>
		</li>
	</ul>
</div>
			</div>
			<div class="col-lg-3 col-md-6">
				<!-- Team Member -->
<div class="team-member text-center mb-4 mb-lg-0">
	<div class="image">
		<img class="img-fluid" src="images/team/member-two.jpg" alt="team-member">
	</div>
	<div class="name">
		<h5>cristin milioti</h5>
	</div>
	<div class="position">
		<p>UX Researcher</p>
	</div>
	<div class="skill-bar">
		<div class="progress">
		  	<div class="progress-bar" style="width:95%;"></div>
		</div>
		<span>95%</span>
	</div>
	<ul class="social-icons list-inline">
		<li class="list-inline-item">
			<a href=""><i class="ti-facebook"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-twitter-alt"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-linkedin"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-instagram"></i></a>
		</li>
	</ul>
</div>
			</div>
			<div class="col-lg-3 col-md-6">
				<!-- Team Member -->
<div class="team-member text-center mb-4 mb-lg-0">
	<div class="image">
		<img class="img-fluid" src="images/team/member-three.jpg" alt="team-member">
	</div>
	<div class="name">
		<h5>john doe</h5>
	</div>
	<div class="position">
		<p>Head of Ideas</p>
	</div>
	<div class="skill-bar">
		<div class="progress">
		  	<div class="progress-bar" style="width:80%;"></div>
		</div>
		<span>80%</span>
	</div>
	<ul class="social-icons list-inline">
		<li class="list-inline-item">
			<a href=""><i class="ti-facebook"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-twitter-alt"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-linkedin"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-instagram"></i></a>
		</li>
	</ul>
</div>
			</div>
			<div class="col-lg-3 col-md-6">
				<!-- Team Member -->
<div class="team-member text-center mb-4 mb-lg-0">
	<div class="image">
		<img class="img-fluid" src="images/team/member-four.jpg" alt="team-member">
	</div>
	<div class="name">
		<h5>mario gotze</h5>
	</div>
	<div class="position">
		<p>UX/UI designer</p>
	</div>
	<div class="skill-bar">
		<div class="progress">
		  	<div class="progress-bar" style="width:75%;"></div>
		</div>
		<span>75%</span>
	</div>
	<ul class="social-icons list-inline">
		<li class="list-inline-item">
			<a href=""><i class="ti-facebook"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-twitter-alt"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-linkedin"></i></a>
		</li>
		<li class="list-inline-item">
			<a href=""><i class="ti-instagram"></i></a>
		</li>
	</ul>
</div>
			</div>
		</div>
	</div>
</section>

<!--====  End of Team  ====-->

<!--=================================
=            Testimonial            =
==================================-->

<section class="section testimonial bg-primary-shape" id="testimonial">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-title">
					<h2 class="text-white">Our Happy Customers</h2>
					<p class="text-white">Demoralized by the charms of pleasure of the moment, so blinded by desire, that they
						cannot foresee idea of denouncing pleasure and praising</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-10 mx-auto">
				<!-- Testimonial Carosel -->
<div class="testimonial-slider">
	<!-- testimonial item -->
	<div class="testimonial-item">
		<div class="row">
			<div class="col-md-5 client-img" style="background-image: url(images/testimonial/client-1.jpg);">
			</div>
			<div class="col-md-7">
				<div class="p-4 bg-white">
					<strong class="mb-3 d-block">They are great agency</strong>
					<p class="lead font-italic mb-4">I recently hired Genox to develop a new version of my most popular website
						and I’m extremely happy with their work.</p>
					<h6>Mike Andrew</h6>
					<p>CEO - Philandropia</p>
				</div>
			</div>
		</div>
	</div>
	<!-- testimonial item -->
	<div class="testimonial-item">
		<div class="row">
			<div class="col-md-5 client-img" style="background-image: url(images/testimonial/client-2.jpg);">
			</div>
			<div class="col-md-7">
				<div class="p-4 bg-white">
					<strong class="mb-3 d-block">They are great agency</strong>
					<p class="lead font-italic mb-4">I recently hired Genox to develop a new version of my most popular website
						and I’m extremely happy with their work.</p>
					<h6>Selena Catt</h6>
					<p>CEO - Philandropia</p>
				</div>
			</div>
		</div>
	</div>
</div>
			</div>
		</div>
	</div>
</section>


<!--====  End of Testimonial  ====-->

<section class="section cta-subscribe" id="contact">
	<div class="container">
		<div class="row bg-elipse-red">
			<div class="col-lg-4">
				<div class="image"><img class="phone-thumb" src="images/phones/iphone-banner.png" alt="iphone-app"></div>
			</div>
			<div class="col-lg-8 align-self-center">
				<div class="content">
					<div class="mb-4">
						<h2>Subscribe Our Newsletter</h2>
					</div>
					<div class="description">
						<p>Demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee idea
							of denouncing pleasure and praising</p>
					</div>
					<form action="#">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Enter your email address">
							<div class="input-group-append">
								<span class="input-group-text ti-arrow-right"></span>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>

<!--============================
=            Footer            =
=============================-->

<footer class="footer-main">
  <div class="container">
    <div class="row">
      <div class="col-lg-6 mr-auto">
        <div class="footer-logo">
          <img src="images/logo.png" alt="footer-logo">
        </div>
        <div class="copyright">
          <p>@2019 Themefisher All Rights Reserved | Design and Developed By : <a href="https://themefisher.com/"
              target="_blank">Themefisher</a>
            <br> Check Our Store for more <a href="https://themefisher.com/free-bootstrap-templates/" target="_blank">Bootstrap Template</a>
          </p>
        </div>
      </div>
      <div class="col-lg-6 text-lg-right">
        <!-- Social Icons -->
        <ul class="social-icons list-inline">
          <li class="list-inline-item">
            <a target="_blank" href="https://facebook.com/themefisher"><i class="text-primary ti-facebook"></i></a>
          </li>
          <li class="list-inline-item">
            <a target="_blank" href="https://twitter.com/themefisher"><i class="text-primary ti-twitter-alt"></i></a>
          </li>
          <li class="list-inline-item">
            <a target="_blank" href="https://github.com/themefisher"><i class="text-primary ti-linkedin"></i></a>
          </li>
          <li class="list-inline-item">
            <a target="_blank" href="https://instagram.com/themefisher"><i class="text-primary ti-instagram"></i></a>
          </li>
        </ul>
        <!-- Footer Links -->
        <ul class="footer-links list-inline">
          <li class="list-inline-item">
            <a class="scrollTo" href="#about">ABOUT</a>
          </li>
          <li class="list-inline-item">
            <a class="scrollTo" href="#team">TEAM</a>
          </li>
          <li class="list-inline-item">
            <a class="scrollTo" href="#contact">CONTACT</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</footer>


  <!-- JAVASCRIPTS -->
  
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBI14J_PNWVd-m0gnUBkjmhoQyNyd7nllA" async defer></script>

  <script src="plugins/jquery/jquery.js"></script>
  <script src="plugins/bootstrap/bootstrap.min.js"></script>
  <script src="plugins/slick/slick.min.js"></script>
  <script src="js/custom.js"></script>
  
</body>

</html>