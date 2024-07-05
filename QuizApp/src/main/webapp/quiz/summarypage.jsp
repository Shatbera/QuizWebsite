<%@ page import="config.QuizzesDatabase" %>
<%@ page import="models.quizzes.Quiz" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Summary Page</title>
    <%
        QuizzesDatabase db = (QuizzesDatabase) application.getAttribute("quizzesDatabase");
        int id = Integer.parseInt(request.getParameter("id"));
        Quiz quiz = db.getQuiz(id);
    %>
</head>
<body>

<h1>Quiz Summary</h1>

<div>
    <h2><%= quiz.title %></h2>
</div>
<div>
    <h3><%= quiz.description %></h3>
</div>

<div>
    <h2>Quiz Creator</h2>
</div>

<div>
    <h2>Your Performance History</h2>
</div>

<div>
    <h2>Top Performers</h2>
    <h3>All Time</h3>

    <h3>Last Day</h3>
</div>

<div>
    <h2>Recent Test Takers' Performance</h2>
</div>

<div>
    <h2>Quiz Summary Statistics</h2>
</div>

<div>
    <h2>Quiz Actions</h2>
</div>

<div>
    <form action="StartQuizServlet" method="post">
        <input type="hidden" name="quizId" value="<%= quiz.id %>">
        <button type="submit" class="button">Start Quiz</button>
    </form>
</div>

</body>
</html>
