<img src="<%= question.questionText %>" alt="Picture for response" class="question-image"/>
<br><br>
<label class="label-answer" for="answer_<%= question.id %>">Your Answer:</label>
<input class="input-answer" type="text" id="answer_<%= question.id %>" name="answer_<%= question.id %>" required>
<br><br>
