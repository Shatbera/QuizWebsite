<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(question.questionType == Question.QuestionType.QUESTION_RESPONSE || question.questionType == Question.QuestionType.FILL_IN_BLANK){
        %><%@ include file="simpleQuestion.jsp" %><%
    }else if(question.questionType == Question.QuestionType.PICTURE_RESPONSE){
        %><%@ include file="pictureResponseQuestion.jsp" %><%
    }
    else if(question.questionType == Question.QuestionType.MULTI_CHOICE || question.questionType == Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER ){
        %><%@ include file="multiChoiceQuestion.jsp" %><%
    }else if(question.questionType == Question.QuestionType.MULTI_ANSWER){
        %><%@ include file="multiAnswerQuestion.jsp" %><%
    }else if(question.questionType == Question.QuestionType.MATCHING){
        %><%@ include file="matchingQuestion.jsp" %><%
    }
%>