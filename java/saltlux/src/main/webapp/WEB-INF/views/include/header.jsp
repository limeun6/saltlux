<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

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
	
	<!-- Styles -->
	<style>
	#chartdiv {
	  width: 100%;
	  height: 500px;
	}
	</style>
	
	<!-- Resources -->
	<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
	<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>

	
</head>

<body class="body-wrapper">
	<nav class="navbar main-nav fixed-top navbar-expand-lg large">
	    <div class="container">
	        <a class="navbar-brand" href="homepage.html">
	            <img src="images/logo.png" alt="logo"></a>
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