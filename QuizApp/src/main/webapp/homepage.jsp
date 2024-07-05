<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="config.QuizzesDatabase, models.quizzes.Quiz" %>
<%@ page import="java.util.ArrayList" %>
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
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        //response.sendRedirect("login.jsp");
    }
%>
<h1>Welcome, <%= username %>!</h1>

<div class="section" id="all-quizzes">
    <h2>All Quizzes</h2>
    <%
        QuizzesDatabase db = (QuizzesDatabase) application.getAttribute("quizzesDatabase");
        if (db != null) {
            ArrayList<Quiz> allQuizzes = db.getAllQuizzes();
            if (allQuizzes != null && !allQuizzes.isEmpty()) {
                for (Quiz quiz : allQuizzes) {
    %>
    <div class="quiz-item">
        <%@ include file="/quiz/quizDisplay.jsp" %>
    </div>
    <%
        }
    } else {
    %>
    <p>No quizzes available.</p>
    <%
        }
    } else {
    %>
    <p>No quizzes available.</p>
    <%
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
