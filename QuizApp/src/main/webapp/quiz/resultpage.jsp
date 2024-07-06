<%@ page import="models.quizzes.Quiz" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Results</title>
    <%
        Quiz quiz = (Quiz)session.getAttribute("currentQuiz");
    %>
</head>
<body>

<h1>Quiz Results</h1>

<%
    int score = quiz.getScore();
    int maxScore = quiz.getMaxScore();
    int percentage = quiz.getScorePercentage();
    int timeTaken = quiz.getQuizTimeTaken();
%>

<div>
    <h2>Quiz: <%= quiz.title %>
    </h2>
    <p>Score: <%= score %>/<%= maxScore %> (<%=percentage%>%)</p>
    <p>Time Taken: <%= timeTaken %> seconds</p>
</div>

<div>
    <h2>Your Answers</h2>
</div>

<div>
    <h2>Comparison with Your Past Performance</h2>
</div>

<div>
    <h2>Comparison with Your Friends</h2>
</div>

<div>
    <h2>Top Performers on This Quiz</h2>
</div>

</body>
</html>
