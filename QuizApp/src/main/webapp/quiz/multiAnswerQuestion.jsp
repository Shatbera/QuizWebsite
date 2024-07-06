<%@ page import="models.quizzes.Answer" %>
<h1><%= question.questionText %></h1>

<%
    ArrayList<String> answers = question.getCorrectAnswers();
    for (int i = 0; i < answers.size(); i++) {
        //Answer answer = answers.get(i);
%>
<div class="answer-container">
    <span class="answer-number"><%= i + 1 %></span>
    <input class="input-answer" type="text" id="answer_<%= question.id %>_<%= i %>" name="answer_<%= question.id %>_<%= i %>" required>
</div>
<br>
<% } %>
