package servlets;

import config.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.quizzes.Quiz;

import java.io.IOException;

public class RateQuizServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ratingStr = req.getParameter("rating");
        if(ratingStr != null){
            int rating = Integer.parseInt(ratingStr);
            DatabaseManager db = (DatabaseManager) req.getServletContext().getAttribute(DatabaseManager.NAME);
            String review = req.getParameter("review");
            int userId = (int) req.getSession().getAttribute("id");
            Quiz quiz = (Quiz) req.getSession().getAttribute("currentQuiz");
            boolean success = db.saveRating(quiz.id, userId, rating, review);
            if(success) {
                resp.sendRedirect("../user/homepage.jsp");
            }
        }
    }
}
