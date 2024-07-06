package servlets;

import config.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

public class CancelFriendRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int toUserId = Integer.parseInt(request.getParameter("userId"));
        int fromUserId = (int) request.getSession().getAttribute("id");

        DatabaseManager db = (DatabaseManager) getServletContext().getAttribute(DatabaseManager.NAME);
        boolean success = db.cancelFriendRequest(fromUserId, toUserId);

        sendJsonResponse(response, success);
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + "}");
        out.flush();
    }
}
