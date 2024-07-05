package servlets;

import config.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.user.User;

import java.io.IOException;
import java.util.ArrayList;

public class SearchUsersServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String prompt = request.getParameter("prompt");
        String currentUser = (String) request.getSession().getAttribute("username");
        DatabaseManager db = (DatabaseManager) getServletContext().getAttribute(DatabaseManager.NAME);
        ArrayList<User> users = db.searchUsers(prompt, currentUser);

        request.setAttribute("users", users);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }
}
