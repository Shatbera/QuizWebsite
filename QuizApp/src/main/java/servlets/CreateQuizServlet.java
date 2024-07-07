package servlets;

import config.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.quizzes.Answer;
import models.quizzes.MatchingAnswer;
import models.quizzes.Question;
import models.quizzes.Quiz;

import java.io.IOException;
import java.util.ArrayList;

public class CreateQuizServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("id");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        boolean randomize = Boolean.parseBoolean(req.getParameter("randomize"));
        String displayTypeString = req.getParameter("displayType");
        Quiz.DisplayType displayType = displayTypeString.equals("Single-Page") ? Quiz.DisplayType.OnePage : Quiz.DisplayType.MultiplePage;
        boolean immediateCorrection = displayType == Quiz.DisplayType.MultiplePage && Boolean.parseBoolean(req.getParameter("immediateCorrection"));
        Quiz quiz = new Quiz(-1, userId, title, description, randomize, displayType, immediateCorrection);

        String[] questionIds = req.getParameterValues("questionId");
        for(int i = 0; i < questionIds.length; i++){
            System.out.println(questionIds[i]);
        }
        /*ArrayList<Question> questions = new ArrayList<>();
        for(int i = 0; i < questionIds.length; i++){
            Question question = getQuestion(req, resp, questionIds[i]);
            questions.add(question);
        }

        quiz.setQuestions(questions);

        DatabaseManager db = (DatabaseManager) req.getServletContext().getAttribute(DatabaseManager.NAME);
        db.saveQuiz(quiz);*/
    }

    private Question getQuestion(HttpServletRequest req, HttpServletResponse resp, String questionId) throws ServletException, IOException{
        String questionTypeString = req.getParameter("questionType_" + questionId);
        String questionText = req.getParameter("questionText_" + questionId);
        Question.QuestionType questionType = stringToQuestionType(questionTypeString);
        Question question = new Question(-1, stringToQuestionType(questionTypeString), questionText);
        String orderMattersString = req.getParameter("orderMatters_" + questionId);
        boolean orderMatters = orderMattersString == null || Boolean.parseBoolean(orderMattersString);
        if(questionType == Question.QuestionType.MATCHING){
            handleMatchingAnswers(req, resp, question, questionId);
        }else{
            handleAnswers(req, resp, question, questionId, orderMatters);
        }
        return question;
    }

    private void handleMatchingAnswers(HttpServletRequest req, HttpServletResponse resp, Question question, String questionId) throws ServletException, IOException {
        String[] leftMatches = req.getParameterValues("leftMatch_"+questionId);
        String[] rightMatches = req.getParameterValues("rightMatch_"+questionId);
        ArrayList<MatchingAnswer> matchingAnswers = new ArrayList<>();
        for(int i = 0; i < leftMatches.length; i++){
            MatchingAnswer matchingAnswer = new MatchingAnswer(-1, leftMatches[i], rightMatches[i]);
            matchingAnswers.add(matchingAnswer);
        }
        question.setMatchingAnswers(matchingAnswers);
    }

    private void handleAnswers(HttpServletRequest req, HttpServletResponse resp, Question question, String questionId, boolean orderMatters) throws ServletException, IOException {
        String[] answers = req.getParameterValues("answer_"+questionId);
        String[] isCorrectAnswers = req.getParameterValues("isCorrect_"+questionId);
        ArrayList<Answer> answersList = new ArrayList<>();
        for(int i = 0; i < answers.length; i++){
            boolean isCorrect = isCorrectAnswers == null || Boolean.parseBoolean(isCorrectAnswers[i]);
            Answer answer = new Answer(-1, answers[i], isCorrect, orderMatters ? i + 1 : 0);
            answersList.add(answer);
        }
        question.setAnswers(answersList);
    }

    private Question.QuestionType stringToQuestionType(String type) {
        switch (type) {
            case "Question-Response":
                return Question.QuestionType.QUESTION_RESPONSE;
            case "Fill in the Blank":
                return Question.QuestionType.FILL_IN_BLANK;
            case "Multiple Choice":
                return Question.QuestionType.MULTI_CHOICE;
            case "Picture-Response":
                return Question.QuestionType.PICTURE_RESPONSE;
            case "Multi-Answer":
                return Question.QuestionType.MULTI_ANSWER;
            case "Multiple Choice (Multiple Answers)":
                return Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER;
            case "Matching":
                return Question.QuestionType.MATCHING;
        }
        return Question.QuestionType.QUESTION_RESPONSE;
    }
}
