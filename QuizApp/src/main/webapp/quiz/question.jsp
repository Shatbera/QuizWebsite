<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Question</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            box-sizing: border-box;
        }
        .question-container {
            background-color: #ffffff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            margin-top: 0;
            margin-bottom: 15px;
        }
        .question-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 15px;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .label-answer {
            margin-bottom: 5px;
        }
        .answer-container {
            margin-bottom: 10px;
        }

        .answer-number {
            display: inline-block;
            width: 30px; /* Adjust width as needed */
            font-weight: bold;
        }
        .input-answer {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: calc(100% - 40px); /* Adjust width to leave space for answer number */
            box-sizing: border-box;
        }
        .matching-container {
            margin-bottom: 20px;
        }

        .match-pair {
            margin-bottom: 10px;
        }

        .left-match {
            display: inline-block;
            width: 100px; /* Adjust width as needed */
            font-weight: bold;
        }

        .right-match {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: calc(100% - 120px); /* Adjust width to leave space for left match */
            box-sizing: border-box;
        }
        .checkbox-answer, .radio-answer {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<div class="question-container">
    <% if (question.questionType == Question.QuestionType.QUESTION_RESPONSE || question.questionType == Question.QuestionType.FILL_IN_BLANK) { %>
    <%@ include file="simpleQuestion.jsp" %>
    <% } else if (question.questionType == Question.QuestionType.PICTURE_RESPONSE) { %>
    <%@ include file="pictureResponseQuestion.jsp" %>
    <% } else if (question.questionType == Question.QuestionType.MULTI_CHOICE) { %>
    <%@ include file="multiChoiceQuestion.jsp" %>
    <% } else if (question.questionType == Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER) { %>
    <%@ include file="multiChoiceMultiAnswerQuestion.jsp" %>
    <% } else if (question.questionType == Question.QuestionType.MULTI_ANSWER) { %>
    <%@ include file="multiAnswerQuestion.jsp" %>
    <% } else if (question.questionType == Question.QuestionType.MATCHING) { %>
    <%@ include file="matchingQuestion.jsp" %>
    <% } %>

    <input type="hidden" name="questionId" value="<%= question.id %>">
</div>

</body>
</html>
