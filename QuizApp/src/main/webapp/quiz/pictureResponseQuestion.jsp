<h1>Picture Response Question</h1>
<img src="<%= question.questionText %>" alt="Picture for response" class="question-image"/>
<br><br>
<label for="answer_<%= question.id %>">Your Answer:</label>
<input type="text" id="answer_<%= question.id %>" name="answer_<%= question.id %>" required>
<br><br>
