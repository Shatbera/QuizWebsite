<%@ page import="models.quizzes.MatchingAnswer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Matching Question</title>
</head>
<body>
<h1><%= question.questionText %></h1>

<%--<form class="submit-answer" action="SubmitAnswerServlet" method="post">--%>
    <%
        ArrayList<MatchingAnswer> matchingAnswers = question.getMatchingAnswers();
        ArrayList<String> leftMatches = new ArrayList<>();
        ArrayList<String> rightMatches = new ArrayList<>();

        for (MatchingAnswer matchingAnswer : matchingAnswers) {
            leftMatches.add(matchingAnswer.leftMatch);
            rightMatches.add(matchingAnswer.rightMatch);
        }
    %>
    <% for (int i = 0; i < leftMatches.size(); i++) { %>
    <label for="rightMatch_<%= question.id %>_<%= i %>"><%= leftMatches.get(i) %>:</label>
    <select id="rightMatch_<%= question.id %>_<%= i %>" name="rightMatch_<%= question.id %>_<%= i %>">
        <% for (String rightMatch : rightMatches) { %>
        <option value="<%= rightMatch %>"><%= rightMatch %></option>
        <% } %>
    </select>
    <br><br>
    <% } %>

    <input type="submit" value="Submit Answer">
<%--</form>--%>
</body>
</html>
