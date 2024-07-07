<%
    String questionId = request.getParameter("questionId");
    for(int i = 0; i < 5; i++){
%>
<div class="form-group answers-group">
    <label class="answer-label " for="answer_<%=questionId%>">Answer <%=i+1%>:</label>
    <input class="answer-input" type="text" id="answer_<%=questionId%>" name="answer_<%=questionId%>" <% if(i == 0) %>required<% %>>
    <label for="isCorrect_<%=questionId%>"></label><select id="isCorrect_<%=questionId%>" name="isCorrect_<%=questionId%>" class="correctness-dropdown">
        <option value="false">Incorrect</option>
        <option value="true">Correct</option>
    </select>
</div>
<%
    }
%>