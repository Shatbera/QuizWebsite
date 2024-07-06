<%@ page import="models.quizzes.Answer" %>
<h1><%= question.questionText %></h1>

<%
    ArrayList<Answer> answers = question.getAnswers();
    for (int i = 0; i < answers.size(); i++) {
        Answer answer = answers.get(i);
%>
<label for="answer_<%= question.id %>_<%= i %>">Answer <%= i + 1 %>:</label>
<input type="text" id="answer_<%= question.id %>_<%= i %>" name="answer_<%= question.id %>_<%= i %>" required>
<br><br>
<% } %>