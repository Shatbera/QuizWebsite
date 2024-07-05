package servlets;

import config.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.user.UserProfile;

import java.io.IOException;

public class UserProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        Integer currentUserId = (Integer) request.getSession().getAttribute("id");

        if (currentUserId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        DatabaseManager db = (DatabaseManager) getServletContext().getAttribute(DatabaseManager.NAME);
        UserProfile userProfile = db.getUserProfile(username, currentUserId);

        if (userProfile == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        request.setAttribute("userProfile", userProfile);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }
}
