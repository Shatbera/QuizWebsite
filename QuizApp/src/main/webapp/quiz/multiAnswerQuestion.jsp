<%@ page import="models.quizzes.Answer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h1>Multi Answer Question: <%= question.questionText %></h1>

<form class="submit-answer" action="SubmitAnswerServlet" method="post">
    <input type="hidden" name="questionId" value="<%= question.id %>">
    <%
        ArrayList<Answer> answers = question.getAnswers();
        for (int i = 0; i < answers.size(); i++) {
            Answer answer = answers.get(i);
    %>
    <label for="answer<%= i %>">Answer <%= i + 1 %>:</label>
    <input type="text" id="answer<%= i %>" name="answer<%= i %>" required>
    <br><br>
    <% } %>
    <input type="submit" value="Submit Answer">
</form>
