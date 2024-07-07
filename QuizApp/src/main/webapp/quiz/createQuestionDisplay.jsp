<%
    String questionId = request.getParameter("questionId");
%>
<style>

</style>

<div class="question-container">
    <div class="question-header">
        <h3>Question <%= questionId %></h3>
    </div>
    <div class="form-group">
        <input type="hidden" name="questionId" value="<%= questionId %>">
        <label for="questionType_<%= questionId %>">Question Type:</label>
        <select id="questionType_<%= questionId %>" name="questionType_<%= questionId %>" onchange="toggleQuestionLabel(<%= questionId %>);">
            <option value="QUESTION_RESPONSE">Question-Response</option>
            <option value="FILL_IN_BLANK">Fill in the Blank</option>
            <option value="MULTI_CHOICE">Multiple Choice</option>
            <option value="PICTURE_RESPONSE">Picture-Response</option>
            <option value="MULTI_ANSWER">Multi-Answer</option>
            <option value="MULTI_CHOICE_MULTI_ANSWER">Multiple Choice (Multiple Answers)</option>
            <option value="MATCHING">Matching</option>
        </select>
    </div>
    <div class="form-group">
        <label id="questionTextLabel_<%= questionId %>" for="questionText_<%= questionId %>">Question:</label>
        <input type="text" id="questionText_<%= questionId %>" name="questionText_<%= questionId %>" required>
    </div>
    <h4>Answers</h4>
    <div class="form-group">
        <!-- Answers inputs go here -->
    </div>
</div>
