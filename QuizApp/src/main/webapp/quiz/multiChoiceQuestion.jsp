<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Question</title>
</head>
<body>
<h1><%= question.questionText %></h1>
 <% for (Answer answer : question.getAnswers()) { %>
    <input type="radio" id="<%= answer.id %>" name="selectedAnswer_<%= question.id %>" value="<%= answer.toString() %>">
    <label for="<%= answer.id %>"><%= answer.toString() %></label><br>
    <% } %>

    <br><br>
</body>
</html>
