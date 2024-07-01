<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Results</title>
</head>
<body>

<h1>Quiz Results</h1>

<%
    String quizTitle = "Sample Quiz";
    int score = 80;
    int timeTaken = 120;
%>

<div>
    <h2>Quiz: <%= quizTitle %>
    </h2>
    <p>Score: <%= score %>%</p>
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
