<h1><%= question.questionText %></h1>
<% for (Answer answer : question.getAnswers()) { %>
    <input class="radio-answer" type="radio" id="<%= answer.id %>" name="selectedAnswer_<%= question.id %>" value="<%= answer.toString() %>">
    <label for="<%= answer.id %>"><%= answer.toString() %></label><br>
<% } %>
<br><br>