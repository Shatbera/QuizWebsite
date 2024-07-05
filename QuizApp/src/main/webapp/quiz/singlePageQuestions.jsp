<%@ page import="models.quizzes.Quiz" %>
<%@ page import="config.DatabaseManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.quizzes.Question" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        Quiz quiz = (Quiz) session.getAttribute("currentQuiz");
        ArrayList<Question> questions = quiz.getQuestions();
    %>
</head>
<body>
    <%
        for(Question question : questions) {

    %>
    <div class="question-item">
        <%@ include file="question.jsp" %>
    </div>
    <%
        }
    %>
</body>
</html>
