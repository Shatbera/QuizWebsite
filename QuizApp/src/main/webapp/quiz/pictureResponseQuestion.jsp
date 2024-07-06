<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Picture Response Question</title>
    <style>
        .question-image {
            max-width: 200px;
            max-height: 200px;
            width: auto;
            height: auto;
        }
    </style>
</head>
<body>
<h1>Picture Response Question</h1>

<img src="<%= question.questionText %>" alt="Picture for response" class="question-image"/>

<%--<form class="submit-answer" action="SubmitAnswerServlet" method="post">--%>
    <label for="answer_<%= question.id %>">Your Answer:</label>
    <input type="text" id="answer_<%= question.id %>" name="answer_<%= question.id %>" required>
    <br><br>
    <input type="submit" value="Submit Answer">
<%--</form>--%>
</body>
</html>
