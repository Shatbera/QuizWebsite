<%
    String questionId = request.getParameter("questionId");
    for (int i = 0; i < 5; i++) {
%>
<div class="form-group match-group">
    <label>Match <%=i+1%>:</label>
    <label for="leftMatch_<%=questionId%>"></label><input type="text" id="leftMatch_<%=questionId%>" name="leftMatch_<%=questionId%>" class="match-input" <% if(i == 0) { %>required<% } %>>
    <label for="rightMatch_<%=questionId%>"></label><input type="text" id="rightMatch_<%=questionId%>" name="rightMatch_<%=questionId%>" class="match-input" <% if(i == 0) { %>required<% } %>>
</div>
<%
    }
%>
