<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h1><%= question.questionText %></h1>

<form class="submit-answer" action="SubmitAnswerServlet" method="post">
    <label for="answer">Answer:</label>
    <input type="text" id="answer" name="answer" required>
    <br><br>
    <input type="submit" value="Submit Answer">
    <input type="hidden" name="questionId" value="<%= question.id %>">
</form>
