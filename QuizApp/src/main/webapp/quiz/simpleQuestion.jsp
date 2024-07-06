<h1><%= question.questionText %></h1>

<label class="label-answer" for="answer_<%= question.id %>">Answer:</label>
<input class="input-answer" type="text" id="answer_<%= question.id %>" name="answer_<%= question.id %>" required>
<br><br>
