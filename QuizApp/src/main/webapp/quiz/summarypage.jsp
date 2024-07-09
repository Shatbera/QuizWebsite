<%@ page import="config.DatabaseManager" %>
<%@ page import="models.user.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.quizzes.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz Summary Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            box-sizing: border-box;
            text-align: center;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }

        h1, h2, h3 {
            color: #333;
        }

        h1 {
            margin-bottom: 20px;
        }

        h2 {
            margin-bottom: 15px;
        }

        h3 {
            margin-bottom: 10px;
        }

        .section {
            margin-bottom: 20px;
        }

        .button {
            display: block;
            width: 200px;
            padding: 10px 20px;
            margin: 20px auto;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }

        .button:hover {
            background-color: #0056b3;
        }

        .center-text {
            text-align: center;
        }

        .user-info {
            display: inline-block;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            margin: 10px 0;
        }

        .user-info .username {
            display: block;
            font-size: 18px;
            font-weight: bold;
            color: #007bff;
        }

        .user-info .email {
            display: block;
            font-size: 14px;
            color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .header-link {
            color: #ffffff; /* White color for the links */
            text-decoration: none; /* Remove underline */
        }

        .header-link:hover {
            text-decoration: underline; /* Underline on hover */
        }

        .table-responsive {
            overflow-x: auto;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .user-table th, .user-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .user-table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        .statistics {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .stat-item {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            width: 200px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .stat-item h3 {
            margin-bottom: 10px;
            color: #333;
        }

        .stat-item p {
            font-size: 18px;
            color: #007bff;
        }
    </style>
    <%
        DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
        int id = Integer.parseInt(request.getParameter("id"));
        Quiz quiz = db.getQuiz(id);
    %>
</head>
<body>
<div class="container">
    <h1>Quiz Summary</h1>

    <div class="section center-text">
        <h2><%= quiz.title %>
        </h2>
        <h3><%= quiz.description %>
        </h3>
    </div>

    <div class="section center-text">
        <h2>Quiz Creator</h2>
        <%
            User user = db.getQuizCreator(quiz.id);
            int currentUserId = (int) session.getAttribute("id");
            if (user != null && user.getId() != currentUserId) {
        %>
        <a href="../user/userProfile?username=<%= user.getUsername() %>" class="user-item">
            <%
                }
            %>
            <%
                if(user != null){
            %>
            <div class="user-info">
                <span class="username"><%= user.getId() == currentUserId ? user.getUsername().concat(" (You)") : user.getUsername() %></span>
                <span class="email"><%= user.getEmail() %></span>
            </div>
            <%
                }
            %>
        </a>
    </div>
    <%
        String sortField = request.getParameter("sortField") != null ? request.getParameter("sortField") : "original";
        String sortDirection = request.getParameter("sortDirection") != null ? request.getParameter("sortDirection") : "none";

        List<QuizAttempt> quizAttempts = db.fetchPastResults((int) session.getAttribute("id"), quiz.id, sortField, sortDirection);
    %>

    <div class="section center-text">
        <h2>Your Performance History</h2>
        <%
            if (quizAttempts != null && !quizAttempts.isEmpty()) {
        %>
        <table id="performanceHistory">
            <thead>
            <tr>
                <th>
                    <a href="?id=<%= id %>&sortField=score&sortDirection=<%= "asc".equals(sortDirection) && "score".equals(sortField) ? "desc" : "asc" %>"
                       class="header-link">Score <%= "score".equals(sortField) ? ("asc".equals(sortDirection) ? "▲" : "▼") : "" %>
                    </a></th>
                <th>
                    <a href="?id=<%= id %>&sortField=timeTaken&sortDirection=<%= "asc".equals(sortDirection) && "timeTaken".equals(sortField) ? "desc" : "asc" %>"
                       class="header-link">Time
                        Taken
                        (seconds) <%= "timeTaken".equals(sortField) ? ("asc".equals(sortDirection) ? "▲" : "▼") : "" %>
                    </a></th>
                <th>
                    <a href="?id=<%= id %>&sortField=attemptTime&sortDirection=<%= "asc".equals(sortDirection) && "attemptTime".equals(sortField) ? "desc" : "asc" %>"
                       class="header-link">Attempt
                        Time <%= "attemptTime".equals(sortField) ? ("asc".equals(sortDirection) ? "▲" : "▼") : "" %>
                    </a></th>
            </tr>
            </thead>
            <tbody>
            <%
                for (QuizAttempt attempt : quizAttempts) {
            %>
            <tr>
                <td><%= attempt.getScore() %>
                </td>
                <td><%= attempt.getTimeTaken() %>
                </td>
                <td><%= attempt.getAttemptTime() %>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p>No past performance data available.</p>
        <%
            }
        %>
    </div>

    <div class="section center-text">
        <h2>Top Performers</h2>
        <h3>All Time</h3>
        <%
            List<QuizPerformerResponse> quizPerformers = db.fetchQuizPerformers(quiz.id, true);
            if (quizPerformers != null && !quizPerformers.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="user-table">
                <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Score</th>
                    <th>Time Taken</th>
                </tr>
                </thead>
                <tbody>
                <% for (QuizPerformerResponse performer : quizPerformers) { %>
                <tr>
                    <td><%= performer.getUsername() %>
                    </td>
                    <td><%= performer.getEmail() %>
                    </td>
                    <td><%= performer.getScore() %>
                    </td>
                    <td><%= performer.getTimeTaken() %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p>No users found.</p>
        <% } %>
        <h3>Last Day</h3>
        <%
            List<QuizPerformerResponse> topQuizPerformersLastDay = db.fetchQuizPerformers(quiz.id, false);
            if (topQuizPerformersLastDay != null && !topQuizPerformersLastDay.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="user-table">
                <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Score</th>
                    <th>Time Taken</th>
                </tr>
                </thead>
                <tbody>
                <% for (QuizPerformerResponse performer : topQuizPerformersLastDay) { %>
                <tr>
                    <td><%= performer.getUsername() %>
                    </td>
                    <td><%= performer.getEmail() %>
                    </td>
                    <td><%= performer.getScore() %>
                    </td>
                    <td><%= performer.getTimeTaken() %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p>No users found.</p>
        <% } %>
    </div>

    <div class="section center-text">
        <h2>Recent Test Takers' Performance</h2>
        <%
            List<QuizPerformerResponse> recentTaskTakers = db.fetchRecentQuizPerformers(quiz.id);
            if (recentTaskTakers != null && !recentTaskTakers.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="user-table">
                <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Score</th>
                    <th>Time Taken</th>
                    <th>Attempt Time</th>
                </tr>
                </thead>
                <tbody>
                <% for (QuizPerformerResponse performer : recentTaskTakers) { %>
                <tr>
                    <td><%= performer.getUsername() %>
                    </td>
                    <td><%= performer.getEmail() %>
                    </td>
                    <td><%= performer.getScore() %>
                    </td>
                    <td><%= performer.getTimeTaken() %>
                    </td>
                    <td><%= performer.getAttemptTime() %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else { %>
        <p>No users found.</p>
        <% } %>
    </div>

    <div class="section center-text">
        <h2>Quiz Summary Statistics</h2>
        <%
            QuizStatistics quizStatistics = db.getQuizStatistics(quiz.id);
            if (quizStatistics != null) {
        %>
        <div class="statistics">
            <div class="stat-item">
                <h3>Total Attempts</h3>
                <p><%= quizStatistics.getTotalAttempts() %>
                </p>
            </div>
            <div class="stat-item">
                <h3>Average Score</h3>
                <p><%= String.format("%.2f", quizStatistics.getAverageScore()) %>
                </p>
            </div>
            <div class="stat-item">
                <h3>Max Score</h3>
                <p><%= quizStatistics.getMaxScore() %>
                </p>
            </div>
            <div class="stat-item">
                <h3>Average Time Taken (seconds)</h3>
                <p><%= String.format("%.2f", quizStatistics.getAverageTimeTaken()) %>
                </p>
            </div>
            <div class="stat-item">
                <h3>Percentage</h3>
                <p><%= String.format("%.2f", quizStatistics.getPercentage()) %> %</p>
            </div>
            <div class="stat-item">
                <h3>Average Rating</h3>
                <p><%= String.format("%.2f", quizStatistics.getAverageRating()) %>/5 (Stars)</p>
            </div>
        </div>
        <%
        } else {
        %>
        <p>No statistics available.</p>
        <%
            }
        %>
    </div>


    <div class="section center-text">
        <form action="StartQuizServlet" method="post">
            <input type="hidden" name="quizId" value="<%= quiz.id %>">
            <button type="submit" class="button">Start Quiz</button>
        </form>
    </div>

    <div>
        <%
            ArrayList<QuizReview> reviews = db.getQuizReviews(quiz.id);
            for(QuizReview quizReview : reviews) {
        %>
            <div id="quiz-review">
                <h5><%=quizReview.userName%></h5>
                <h5>Stars: <%=quizReview.stars%></h5>
                <p><%=quizReview.review%></p>
            </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
