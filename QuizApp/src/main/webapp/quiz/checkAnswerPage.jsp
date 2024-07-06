<%@ page import="models.quizzes.Question" %>
<html>
<head>
    <title>Check Answer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            box-sizing: border-box;
            text-align: center;
        }
        .submit-button {
            display: block;
            width: 200px;
            padding: 10px 20px;
            margin: 20px auto;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .submit-button:hover {
            background-color: #0056b3;
        }
    </style>
    <%
        Question question = (Question) request.getAttribute("currentQuestion");
    %>
</head>
<body>
<form action="multiplePageQuestions.jsp" method="post">
    <%@ include file="answerResult.jsp" %>
    <input type="submit" class="submit-button" value="Next">
</form>
</body>
</html>
