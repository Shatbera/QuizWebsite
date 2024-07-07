<%@ page import="config.DatabaseManager" %>
<%@ page import="models.quizzes.Quiz" %>
<%@ page import="models.user.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Summary Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            box-sizing: border-box;
            text-align: center;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }

        h1, h2, h3 {
            color: #333;
        }

        h1 {
            margin-bottom: 20px;
        }

        h2 {
            margin-bottom: 15px;
        }

        h3 {
            margin-bottom: 10px;
        }

        .section {
            margin-bottom: 20px;
        }

        .button {
            display: block;
            width: 200px;
            padding: 10px 20px;
            margin: 20px auto;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }

        .button:hover {
            background-color: #0056b3;
        }

        .center-text {
            text-align: center;
        }

        .user-info {
            display: inline-block;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            margin: 10px 0;
        }

        .user-info .username {
            display: block;
            font-size: 18px;
            font-weight: bold;
            color: #007bff;
        }

        .user-info .email {
            display: block;
            font-size: 14px;
            color: #555;
        }
    </style>
    <%
        DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
        int id = Integer.parseInt(request.getParameter("id"));
        Quiz quiz = db.getQuiz(id);
    %>
</head>
<body>
<div class="container">
    <h1>Quiz Summary</h1>

    <div class="section center-text">
        <h2><%= quiz.title %>
        </h2>
        <h3><%= quiz.description %>
        </h3>
    </div>

    <div class="section center-text">
        <h2>Quiz Creator</h2>
        <%
            User user = db.getQuizCreator(quiz.id);
            int currentUserId = (int) session.getAttribute("id");
            if (user.getId() != currentUserId) {
        %>
        <a href="../user/userProfile?username=<%= user.getUsername() %>" class="user-item">
            <%
                }
            %>
            <div class="user-info">
                <span class="username"><%= user.getId() == currentUserId ? user.getUsername().concat(" (You)") : user.getUsername() %></span>
                <span class="email"><%= user.getEmail() %></span>
            </div>
        </a>
    </div>
    <div class="section center-text">
        <h2>Your Performance History</h2>
        <!-- Add user's performance history here -->
    </div>

    <div class="section center-text">
        <h2>Top Performers</h2>
        <h3>All Time</h3>
        <!-- Add details about all-time top performers here -->
        <h3>Last Day</h3>
        <!-- Add details about last day's top performers here -->
    </div>

    <div class="section center-text">
        <h2>Recent Test Takers' Performance</h2>
        <!-- Add details about recent test takers' performance here -->
    </div>

    <div class="section center-text">
        <h2>Quiz Summary Statistics</h2>
        <!-- Add summary statistics here -->
    </div>

    <div class="section center-text">
        <h2>Quiz Actions</h2>
        <!-- Add any quiz-related actions here -->
    </div>

    <div class="section center-text">
        <form action="StartQuizServlet" method="post">
            <input type="hidden" name="quizId" value="<%= quiz.id %>">
            <button type="submit" class="button">Start Quiz</button>
        </form>
    </div>
</div>
</body>
</html>
