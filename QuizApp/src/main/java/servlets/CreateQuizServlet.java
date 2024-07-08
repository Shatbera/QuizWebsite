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
        System.out.println("randomize: " + randomize);
        String displayTypeString = req.getParameter("displayType");
        Quiz.DisplayType displayType = displayTypeString.equals("Single-Page") ? Quiz.DisplayType.OnePage : Quiz.DisplayType.MultiplePage;
        boolean immediateCorrection = displayType == Quiz.DisplayType.MultiplePage && Boolean.parseBoolean(req.getParameter("immediateCorrection"));
        System.out.println("immediateCorrection: " + immediateCorrection);
        Quiz quiz = new Quiz(-1, userId, title, description, randomize, displayType, immediateCorrection);

        String[] questionIds = req.getParameterValues("questionId");

        ArrayList<Question> questions = new ArrayList<>();
        for(int i = 0; i < questionIds.length; i++){
            Question question = getQuestion(req, resp, questionIds[i]);
            questions.add(question);
        }

        quiz.setQuestions(questions);

        DatabaseManager db = (DatabaseManager) req.getServletContext().getAttribute(DatabaseManager.NAME);
        db.saveQuiz(quiz);
        req.getRequestDispatcher("../user/homepage.jsp").forward(req, resp);
    }

    private Question getQuestion(HttpServletRequest req, HttpServletResponse resp, String questionId) throws ServletException, IOException{
        String questionTypeString = req.getParameter("questionType_" + questionId);
        Question.QuestionType questionType = stringToQuestionType(questionTypeString);
        String questionText = req.getParameter("questionText_" + questionId);
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
            if(leftMatches[i].isBlank() || rightMatches[i].isBlank()){
                continue;
            }
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
            if(answers[i].isBlank()){
                continue;
            }
            boolean isCorrect = isCorrectAnswers == null || Boolean.parseBoolean(isCorrectAnswers[i]);
            Answer answer = new Answer(-1, answers[i], isCorrect, orderMatters ? i + 1 : 0);
            answersList.add(answer);
        }
        question.setAnswers(answersList);
    }

    private Question.QuestionType stringToQuestionType(String type) {
        switch (type) {
            case "QUESTION_RESPONSE":
                return Question.QuestionType.QUESTION_RESPONSE;
            case "FILL_IN_BLANK":
                return Question.QuestionType.FILL_IN_BLANK;
            case "MULTI_CHOICE":
                return Question.QuestionType.MULTI_CHOICE;
            case "PICTURE_RESPONSE":
                return Question.QuestionType.PICTURE_RESPONSE;
            case "MULTI_ANSWER":
                return Question.QuestionType.MULTI_ANSWER;
            case "MULTI_CHOICE_MULTI_ANSWER":
                return Question.QuestionType.MULTI_CHOICE_MULTI_ANSWER;
            case "MATCHING":
                return Question.QuestionType.MATCHING;
        }
        return Question.QuestionType.QUESTION_RESPONSE;
    }
}
