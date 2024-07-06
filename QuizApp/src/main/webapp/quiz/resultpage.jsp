<%@ page import="models.quizzes.Quiz" %>
<%@ page import="models.quizzes.Question" %>
<%@ page import="config.DatabaseManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1, h2 {
            text-align: center;
            color: #333;
        }
        .quiz-info {
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
    <%
        Quiz quiz = (Quiz)session.getAttribute("currentQuiz");
        int score = quiz.getScore();
        int maxScore = quiz.getMaxScore();
        int percentage = quiz.getScorePercentage();
        int timeTaken = quiz.getQuizTimeTaken();
    %>
</head>
<body>

<div class="container">
    <h1>Quiz Results</h1>

    <div class="quiz-info">
        <h2>Quiz: <%= quiz.title %></h2>
        <p>Score: <%= score %>/<%= maxScore %> (<%= percentage %>%)</p>
        <p>Time Taken: <%= timeTaken %> seconds</p>
    </div>

    <div>
        <h2>Your Answers</h2>
    </div>

    <div>
        <% ArrayList<Question> questions = quiz.getQuestions();
            for(Question question : questions) {
        %>
        <div class="question-item">
            <br><br>
            <%@ include file="answerResult.jsp" %>
        </div>
        <% } %>
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

</div>
<%
    // Save quiz attempt to the database
    DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
    db.saveQuizAttempt((int) session.getAttribute("id"), quiz);
%>

</body>
</html>
