<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .question-image {
        max-width: 200px;
        max-height: 200px;
        width: auto;
        height: auto;
    }
</style>
<%
    if(question.questionType == Question.QuestionType.QUESTION_RESPONSE || question.questionType == Question.QuestionType.FILL_IN_BLANK){
        %><%@ include file="simpleQuestion.jsp" %><%
    }else if(question.questionType == Question.QuestionType.PICTURE_RESPONSE){
        %><%@ include file="pictureResponseQuestion.jsp" %><%
    }
    else if(question.questionType == Question.QuestionType.MULTI_CHOICE){
        %><%@ include file="multiChoiceQuestion.jsp" %><%
    }else if(question.questionType == Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER){
        %><%@ include file="multiChoiceMultiAnswerQuestion.jsp" %><%
    }
    else if(question.questionType == Question.QuestionType.MULTI_ANSWER){
        %><%@ include file="multiAnswerQuestion.jsp" %><%
    }else if(question.questionType == Question.QuestionType.MATCHING){
        %><%@ include file="matchingQuestion.jsp" %><%
    }
%>
<input type="hidden" name="questionId" value="<%= question.id %>">
