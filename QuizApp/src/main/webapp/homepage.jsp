<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="config.QuizzesDatabase"%>
<%@ page import="models.quizzes.Quiz"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .section {
            margin-bottom: 20px;
        }

        .section h2 {
            border-bottom: 2px solid #ccc;
            padding-bottom: 10px;
        }

        .list-item {
            margin: 5px 0;
        }
    </style>
</head>
<body>
<h1>Welcome!</h1>

<div class="section" id="all-quizzes">
    <h2>All Quizzes</h2>
    <%
        QuizzesDatabase db = (QuizzesDatabase) application.getAttribute("quizzesDatabase");
        if (db != null) {
            for (Quiz quiz : db.getAllQuizzes()) {
    %>
    <div class="quiz-item">
        <%@ include file="quiz/quizCard.jsp" %>
    </div>
    <%
            }
        } else {
            out.println("<p>No quizzes available.</p>");
        }
    %>
</div>


<div class="section" id="popular-quizzes">
    <h2>Popular Quizzes</h2>
    <!-- there must be subsections -->
</div>

<div class="section" id="recent-quizzes">
    <h2>Recently Created Quizzes</h2>
    <!-- there must be subsections -->
</div>

<div class="section" id="recent-activities">
    <h2>Your Recent Activities</h2>
    <!-- there must be subsections -->
</div>

<div class="section" id="created-quizzes">
    <h2>Your Created Quizzes</h2>
    <!-- there must be subsections -->
</div>

<div class="section" id="friends-activities">
    <h2>Friends' Activities</h2>
    <!-- there must be subsections -->
</div>
</body>
</html>
