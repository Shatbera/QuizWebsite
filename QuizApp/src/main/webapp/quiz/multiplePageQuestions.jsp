<%@ page import="models.quizzes.Quiz" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.quizzes.Question" %>
<%@ page import="config.DatabaseManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body{
            align-content: center;
        }
        .container {
            max-width: 600px; /* Adjust max-width as needed */
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .quiz-form {
            padding-top: 20px;
        }
        .submit-button {
            display: block;
            width: 100%;
            max-width: 200px; /* Limit maximum width of the button */
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 20px auto 0; /* Center the button horizontally with top margin */
        }
        .submit-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <form id="quizForm" class="quiz-form" action="SubmitAnswerServlet" method="post">
        <%
            Quiz quiz = (Quiz) session.getAttribute("currentQuiz");
            Question question = quiz.getNextQuestion();
            if(question == null) {
                if(!quiz.isQuizEnded()){
                    quiz.endQuiz();
                    DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
                    db.saveQuizAttempt((int) session.getAttribute("id"), quiz);
                }
                response.sendRedirect("resultpage.jsp");
            }else{

        %>
        <div class="question-item">
            <%@ include file="question.jsp" %>
            <br><br>
        </div>
        <%
            }
        %>
        <input type="submit" class="submit-button" value="<%=quiz.immediateCorrection ? "Check Answer" : "Next"%>">
    </form>
</div>
</body>
</html>
