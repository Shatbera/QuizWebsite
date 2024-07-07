<%
    String questionId = request.getParameter("questionId");
%>
<p>
    question item <%=  questionId%>
    <input type="hidden" name="questionId" value="<%= questionId %>">
</p>