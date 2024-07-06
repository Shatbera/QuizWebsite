<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h1><%= question.questionText %></h1>

<%--<form class="submit-answer" action="SubmitAnswerServlet" method="post">--%>
    <label for="answer_<%= question.id %>">Answer:</label>
    <input type="text" id="answer_<%= question.id %>" name="answer_<%= question.id %>" required>
    <br><br>
    <input type="submit" value="Submit Answer">
<%--</form>--%>
