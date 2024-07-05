<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Question</title>
</head>
<body>
<h1><%= question.questionText %></h1>

<form class="submit-answer" action="SubmitAnswerServlet" method="post">
    <% for (Answer answer : question.getAnswers()) { %>
    <input type="checkbox" id="<%= answer.id %>" name="selectedAnswers" value="<%= answer.toString() %>">
    <label for="<%= answer.id %>"><%= answer.toString() %></label><br>
    <% } %>

    <br><br>
    <input type="submit" value="Submit Answer">
    <input type="hidden" name="questionId" value="<%= question.id %>">
</form>
</body>
</html>
