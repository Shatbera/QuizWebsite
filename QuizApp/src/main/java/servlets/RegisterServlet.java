package servlets;

import config.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordHashUtil;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeatPassword = request.getParameter("repeatPassword");

        if (!password.equals(repeatPassword)) {
            request.setAttribute("message", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = PasswordHashUtil.hashPassword(password);
        DatabaseManager db = (DatabaseManager) getServletContext().getAttribute(DatabaseManager.NAME);
        boolean userCreated = db.saveUser(username, email, hashedPassword);
        Integer userId = db.getUserId(username);
        if (userCreated) {
            // Initialize session
            HttpSession session = request.getSession();
            session.setAttribute("user", email);
            session.setAttribute("username", username);
            session.setAttribute("id", userId);
            request.setAttribute("message", "Registration successful!");
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Registration failed!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }


}
