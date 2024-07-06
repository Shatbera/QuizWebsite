<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.quizzes.Quiz"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><%= quiz.title %></title>
	<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #f2f2f2;
			padding: 20px;
		}
		.quiz-box {
			background-color: #fff;
			border: 1px solid #ccc;
			padding: 20px;
			margin-bottom: 20px;
			border-radius: 5px;
			box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}
		.quiz-box h1 {
			font-size: 24px;
			color: #333;
		}
		.quiz-box p {
			font-size: 16px;
			color: #666;
			margin-top: 10px;
		}
		.details-btn {
			padding: 10px 20px;
			background-color: #007bff;
			color: #fff;
			text-decoration: none;
			border-radius: 5px;
			transition: background-color 0.3s ease;
		}
		.details-btn:hover {
			background-color: #0056b3;
			text-decoration: none;
		}
	</style>
</head>
<body>
<div class="quiz-box">
	<h1><%= quiz.title %></h1>
	<p><%= quiz.description %></p>
	<a href="../quiz/summarypage.jsp?id=<%= quiz.id %>" class="details-btn">Details</a>
</div>
</body>
</html>
