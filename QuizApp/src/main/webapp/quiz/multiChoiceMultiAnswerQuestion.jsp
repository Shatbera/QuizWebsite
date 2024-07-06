<h1><%= question.questionText %></h1>

<% for (Answer answer : question.getAnswers()) { %>
    <input type="checkbox" id="<%= answer.id %>" name="selectedAnswers_<%= question.id %>" value="<%= answer.toString() %>">
    <label for="<%= answer.id %>"><%= answer.toString() %></label><br>
<% } %>

<br><br>