package servlets;

import config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.PasswordHashUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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

        boolean userCreated = saveUser(username, email, hashedPassword);
        if (userCreated) {
            // Initialize session
            HttpSession session = request.getSession();
            session.setAttribute("user", email);
            session.setAttribute("username", username);
            request.setAttribute("message", "Registration successful!");
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Registration failed!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }


    private boolean saveUser(String username, String email, String hashedPassword) {
        String sql = "insert into users (username, email, password_hashed) values (?, ?, ?)";

        try {
            Connection connection = DatabaseConfig.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, hashedPassword);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
