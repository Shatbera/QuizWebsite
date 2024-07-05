package servlets;

import config.DatabaseManager;
import models.user.User;
import config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordHashUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String hashedPassword = PasswordHashUtil.hashPassword(password);

        DatabaseManager db = (DatabaseManager) getServletContext().getAttribute(DatabaseManager.NAME);
        Optional<Integer> validUser = db.checkUserCredentials(username, hashedPassword);

        if (validUser.isPresent()) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("id", validUser.get());
            request.setAttribute("message", "Login successful!");
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
