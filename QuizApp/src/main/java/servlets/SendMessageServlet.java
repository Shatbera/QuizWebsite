package servlets;

import config.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

public class SendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int senderId = (int) request.getSession().getAttribute("id");
        int recipientId = Integer.parseInt(request.getParameter("recipientId"));
        String message = request.getParameter("message");

        DatabaseManager db = (DatabaseManager) getServletContext().getAttribute(DatabaseManager.NAME);
        boolean success = db.sendMessage(senderId, recipientId, message);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + "}");
        out.flush();
    }
}
