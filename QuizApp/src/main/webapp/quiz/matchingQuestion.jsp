<%@ page import="models.quizzes.MatchingAnswer" %>
<%@ page import="java.util.ArrayList" %>

<h1><%= question.questionText %></h1>

<div class="matching-container">
    <%
        ArrayList<MatchingAnswer> matchingAnswers = question.getMatchingAnswers();
        ArrayList<String> leftMatches = new ArrayList<>();
        ArrayList<String> rightMatches = new ArrayList<>();

        for (MatchingAnswer matchingAnswer : matchingAnswers) {
            leftMatches.add(matchingAnswer.leftMatch);
            rightMatches.add(matchingAnswer.rightMatch);
        }

        for (int i = 0; i < leftMatches.size(); i++) {
            String leftMatch = leftMatches.get(i);
    %>
    <div class="match-pair">
        <span class="left-match"><%= leftMatch %>:</span>
        <select class="right-match" id="rightMatch_<%= question.id %>_<%= i %>" name="rightMatch_<%= question.id %>_<%= i %>">
            <% for (String rightMatch : rightMatches) { %>
            <option value="<%= rightMatch %>"><%= rightMatch %></option>
            <% } %>
        </select>
    </div>
    <% } %>
</div>
