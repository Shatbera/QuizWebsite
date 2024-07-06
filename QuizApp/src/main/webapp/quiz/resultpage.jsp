<%@ page import="config.DatabaseManager" %>
<%@ page import="models.quizzes.*" %>
<%@ page import="java.util.List" %>
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
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            text-align: center;
            color: #333;
        }

        .quiz-info, .past-performance, .your-answers {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #45a049;
        }

    </style>
    <%
        Quiz quiz = (Quiz) session.getAttribute("currentQuiz");
        int score = quiz.getScore();
        int maxScore = quiz.getMaxScore();
        int percentage = quiz.getScorePercentage();
        int timeTaken = quiz.getQuizTimeTaken();
        session.removeAttribute("currentQuiz");
    %>
</head>
<body>
<%
    // Save quiz attempt to the database
    DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
    db.saveQuizAttempt((int) session.getAttribute("id"), quiz);
%>
<div class="container">
    <h1>Quiz Results</h1>

    <div class="quiz-info">
        <h2>Quiz: <%= quiz.title %>
        </h2>
        <p>Score: <%= score %>/<%= maxScore %> (<%= percentage %>%)</p>
        <p>Time Taken: <%= timeTaken %> seconds</p>
    </div>

    <div>
        <h2>Your Answers</h2>
    </div>

    <div>
        <% ArrayList<Question> questions = quiz.getQuestions();
            for (Question question : questions) {
        %>
        <div class="question-item">
            <br><br>
            <%@ include file="answerResult.jsp" %>
        </div>
        <% } %>
    </div>

    <div>
        <h2>Comparison with Your Past Performance</h2>
        <%
            List<QuizAttempt> quizAttempts = db.fetchPastResults((int) session.getAttribute("id"), quiz.id);
            if (quizAttempts != null && !quizAttempts.isEmpty()) {
        %>
        <table>
            <thead>
            <tr>
                <th>Score</th>
                <th>Time Taken (seconds)</th>
                <th>Attempt Time</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (QuizAttempt attempt : quizAttempts) {
            %>
            <tr>
                <td><%= attempt.getScore() %>
                </td>
                <td><%= attempt.getTimeTaken() %>
                </td>
                <td><%= attempt.getAttemptTime() %>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p>No past performance data available.</p>
        <%
            }
        %>
    </div>

    <div>
        <h2>Comparison with Your Friends</h2>
    </div>

    <div>
        <h2>Top Performers on This Quiz</h2>
    </div>

    <a href="../user/homepage.jsp" class="button">Back to Home Page</a>

</div>

</body>
</html>
