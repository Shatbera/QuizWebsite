<%@ page import="models.quizzes.Question" %>
<%@ page import="models.quizzes.MatchingAnswer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.quizzes.Answer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Question Results</title>
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
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        h1 {
            margin-top: 0;
            color: #333;
        }
        .answers-section {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .answers-section h3 {
            flex: 1;
            text-align: center;
        }
        .answers-list {
            list-style-type: none;
            padding: 0;
        }
        .answers-list li {
            padding: 8px 12px;
            margin: 5px;
            border-radius: 4px;
            text-align: center;
        }
        .correct {
            background-color: #c8e6c9;
        }
        .incorrect {
            background-color: #ffcdd2;
        }
        .score {
            font-weight: bold;
            font-size: 1.2em;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<%
    if (question.questionType == Question.QuestionType.MULTI_ANSWER || question.questionType == Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER) {
%>
<div class="question-container">
    <h1><%= question.questionText %></h1>
    <div class="answers-section">
        <div class="submitted-answers">
            <h3>Your answers:</h3>
            <ul class="answers-list">
                <%
                    ArrayList<Answer> submittedAnswers = question.getSubmittedAnswers();
                    for (Answer answer : submittedAnswers) {
                %>
                <li class="<%= answer.isCorrect ? "correct" : "incorrect" %>"><%= answer.toString() %></li>
                <%
                    }
                %>
            </ul>
        </div>
        <div class="correct-answers">
            <h3>Correct answers:</h3>
            <ul class="answers-list">
                <%
                    ArrayList<Answer> correctAnswers = question.getAnswers();
                    for (Answer correctAnswer : correctAnswers) {
                %>
                <li class="correct"><%= correctAnswer.toString() %></li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>

    <h3 class="score">Score: <%= question.getScore() %> / <%= question.getMaxScore() %></h3>
</div>
<%
} else if (question.questionType == Question.QuestionType.MATCHING) {
    ArrayList<MatchingAnswer> matchingAnswers = question.getMatchingAnswers();
    ArrayList<String> leftMatches = new ArrayList<>();
    ArrayList<Answer> rightMatches = question.getSubmittedAnswers();

    for (MatchingAnswer matchingAnswer : matchingAnswers) {
        leftMatches.add(matchingAnswer.leftMatch);
    }
%>
<div class="question-container">
    <h1><%= question.questionText %></h1>

    <div class="answers-section">
        <div class="submitted-matches">
            <h3>Your matches:</h3>
            <ul class="answers-list">
                <%
                    for (int i = 0; i < leftMatches.size(); i++) {
                        String leftMatch = leftMatches.get(i);
                        Answer submittedRightMatch = rightMatches.get(i);
                %>
                <li class="<%= submittedRightMatch.isCorrect ? "correct" : "incorrect" %>"><%= leftMatch %> - <%= submittedRightMatch.toString() %></li>
                <%
                    }
                %>
            </ul>
        </div>
        <div class="correct-matches">
            <h3>Correct matches:</h3>
            <ul class="answers-list">
                <%
                    for (MatchingAnswer matchingAnswer : matchingAnswers) {
                %>
                <li class="correct"><%= matchingAnswer.leftMatch %> - <%= matchingAnswer.rightMatch.toString() %></li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>

    <h3 class="score">Score: <%= question.getScore() %> / <%= question.getMaxScore() %></h3>
</div>
<%
} else{
%>
<div class="question-container">
    <%
        if(question.questionType == Question.QuestionType.PICTURE_RESPONSE){
    %>
    <img src="<%= question.questionText %>" alt="Question Image" style="max-width: 100%; height: auto; margin-bottom: 10px;">
    <%
    }else{
    %>
    <h1><%= question.questionText %></h1>
    <%
        }
    %>
    <div class="answers-section">
        <div class="submitted-answer">
            <h3>Your answer:</h3>
            <ul class="answers-list">
                <li class="<%= question.getSubmittedAnswer().isCorrect ? "correct" : "incorrect" %>"><%= question.getSubmittedAnswer().toString() %></li>
            </ul>
        </div>
        <div class="correct-answer">
            <h3>Correct answer:</h3>
            <ul class="answers-list">
                <li class="correct"><%= question.getCorrectAnswer() %></li>
            </ul>
        </div>
    </div>

    <h3 class="score">Score: <%= question.getScore() %> / <%= question.getMaxScore() %></h3>
</div>
<%
    }
%>

</body>
</html>
