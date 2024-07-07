<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="config.DatabaseManager, models.quizzes.Quiz" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.user.FriendResponse" %>
<%@ page import="models.user.FriendResponse" %>
<%@ page import="models.user.FriendMessage" %>
<%@ page import="models.user.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="models.quizzes.UserQuizRecentAttemptShort" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .section {
            margin-bottom: 20px;
        }

        .section h2 {
            border-bottom: 2px solid #ccc;
            padding-bottom: 10px;
        }

        .list-item {
            margin: 5px 0;
        }

        /* Styling for logout button */
        .logout-button {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        /* Styling for search form */
        .search-form {
            margin-top: 20px;
            text-align: right;
        }

        .search-form input[type="text"],
        .search-form input[type="submit"] {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .search-form input[type="submit"] {
            background-color: blue;
            color: white;
            border: none;
            cursor: pointer;
            margin-left: 10px;
        }

        .friend-request-list {
            list-style-type: none;
            padding: 0;
        }

        .friend-request-item {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            margin-bottom: 10px;
            padding: 15px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: box-shadow 0.3s ease;
        }

        .friend-request-item:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .friend-request-item a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        .friend-request-item a:hover {
            color: #0056b3;
        }

        .friend-request-buttons {
            display: flex;
            gap: 10px;
        }

        .friend-request-buttons button {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        .friend-request-buttons button:hover {
            transform: translateY(-2px);
        }

        .friend-request-buttons button:active {
            transform: translateY(0);
        }

        .accept-button {
            background-color: #28a745;
            color: white;
        }

        .accept-button:hover {
            background-color: #218838;
        }

        .decline-button {
            background-color: #dc3545;
            color: white;
        }

        .decline-button:hover {
            background-color: #c82333;
        }

        .button {
            /*display: inline-block;*/
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #45a049;
        }

        .friend-message-list {
            list-style-type: none;
            padding: 0;
        }

        .friend-message-item {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            margin-bottom: 20px;
            padding: 15px;
        }

        .friend-message-item h4 {
            margin-top: 0;
            color: #007bff;
        }

        .message-list {
            list-style-type: none;
            padding: 0;
        }

        .message {
            background-color: white;
            border: 1px solid #e9ecef;
            border-radius: 5px;
            margin-bottom: 10px;
            padding: 10px;
        }

        .message p {
            margin: 0 0 5px 0;
        }

        .timestamp {
            font-size: 0.8em;
            color: #6c757d;
        }
        #recent-activities {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #recent-activities h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .quiz-attempt {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .quiz-attempt h3 {
            color: #007bff;
            font-size: 20px;
            margin-top: 0;
        }

        .quiz-attempt p {
            color: #555;
            font-size: 16px;
            margin: 5px 0;
        }

        .quiz-attempt p strong {
            color: #333;
        }

    </style>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    Integer id = (Integer) session.getAttribute("id");
    if (id == null) {
        //response.sendRedirect("login.jsp");
    }
%>
<h1>Welcome, <%= username %>!</h1>
<form action="logoutServlet" method="get" class="logout-button">
    <input type="submit" value="Logout">
</form>

<div class="search-form">
    <form action="searchUsersServlet" method="post">
        <label>
            <input type="text" name="prompt" placeholder="Search users...">
        </label>
        <input type="submit" value="Search">
    </form>
</div>

<div class="section" id="all-quizzes">
    <form action="../quiz/createQuizPage.jsp">
        <input type="submit" value="Create Quiz">
    </form>
    <h2>All Quizzes</h2>
    <%
        DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
        if (db != null) {
            ArrayList<Quiz> allQuizzes = db.getAllQuizzes();
            if (allQuizzes != null && !allQuizzes.isEmpty()) {
                for (Quiz quiz : allQuizzes) {
    %>
    <div class="quiz-item">
        <%@ include file="../quiz/quizDisplay.jsp" %>
    </div>
    <%
        }
    } else {
    %>
    <p>No quizzes available.</p>
    <%
        }
    } else {
    %>
    <p>No quizzes available.</p>
    <%
        }
    %>
</div>

<div class="section" id="popular-quizzes">
    <h2>Popular Quizzes</h2>
    <%
        if (db != null) {
            List<Quiz> popularQuizzes = db.getTopThreePopularQuizzes();
            if (popularQuizzes != null && !popularQuizzes.isEmpty()) {
                for (Quiz quiz : popularQuizzes) {
    %>
    <div class="quiz-item">
        <%@ include file="/quiz/quizDisplay.jsp" %>
    </div>
    <%
        }
    } else {
    %>
    <p>No quizzes created.</p>
    <%
        }
    } else {
    %>
    <p>No quizzes created.</p>
    <%
        }
    %>
</div>

<div class="section" id="recent-quizzes">
    <h2>Recently Created Quizzes</h2>
    <%
        if (db != null) {
            List<Quiz> recentQuizzes = db.getThreeMostRecentQuizzes();
            if (recentQuizzes != null && !recentQuizzes.isEmpty()) {
                for (Quiz quiz : recentQuizzes) {
    %>
    <div class="quiz-item">
        <%@ include file="/quiz/quizDisplay.jsp" %>
    </div>
    <%
        }
    } else {
    %>
    <p>No recent quizzes.</p>
    <%
        }
    } else {
    %>
    <p>No quizzes created.</p>
    <%
        }
    %>
</div>

<div class="section" id="recent-activities">
    <h2>Your Recent Activities</h2>
    <%
        if (db != null) {
            List<UserQuizRecentAttemptShort> myRecentAttempts = db.getRecentAttempts((int) session.getAttribute("id"));
            if (myRecentAttempts != null && !myRecentAttempts.isEmpty()) {
                for (UserQuizRecentAttemptShort quiz : myRecentAttempts) {
    %>
    <div class="quiz-attempt">
        <h3><%= quiz.getTitle() %></h3>
        <p><strong>Description:</strong> <%= quiz.getDescription() %></p>
        <p><strong>Score:</strong> <%= quiz.getScore() %></p>
        <p><strong>Time Taken:</strong> <%= quiz.getTimeTaken() %> seconds</p>
        <p><strong>Attempt Time:</strong> <%= quiz.getAttemptTime() %></p>
    </div>
    <%
        }
    } else {
    %>
    <p>No recent activities found.</p>
    <%
            }
        }
    %>
</div>

<div class="section" id="created-quizzes">
    <h2>Your Created Quizzes</h2>
    <%
        if (db != null) {
            List<Quiz> myQuizzes = db.getCreatedQuizzes((int) session.getAttribute("id"));
            if (myQuizzes != null && !myQuizzes.isEmpty()) {
                for (Quiz quiz : myQuizzes) {
    %>
    <div class="quiz-item">
        <%@ include file="/quiz/quizDisplay.jsp" %>
    </div>
    <%
        }
    } else {
    %>
    <p>No quizzes created.</p>
    <%
        }
    } else {
    %>
    <p>No quizzes created.</p>
    <%
        }
    %>
</div>
<div class="section" id="friends-activities">
    <h2>Friends' Activities</h2>

    <div class="subsection" id="friend-requests">
        <h3>Friend Requests</h3>
        <%
            ArrayList<FriendResponse> friendResponses = db.getFriendRequests(id);
            if (friendResponses != null && !friendResponses.isEmpty()) {
        %>
        <ul class="friend-request-list">
            <%
                for (FriendResponse requester : friendResponses) {
            %>
            <li class="friend-request-item">
                <a href="userProfile?username=<%= requester.getUsername() %>"><%= requester.getUsername() %>
                </a>
                <div class="friend-request-buttons">
                    <button class="accept-button" onclick="acceptFriendRequest(<%= requester.getId() %>)">Accept
                    </button>
                    <button class="decline-button" onclick="declineFriendRequest(<%= requester.getId() %>)">Decline
                    </button>
                </div>
            </li>
            <%
                }
            %>
        </ul>
        <%
        } else {
        %>
        <p>No pending friend requests.</p>
        <%
            }
        %>
    </div>

    <div class="subsection" id="friend-messages">
        <h3>Friends' Messages</h3>
        <%
            List<FriendMessage> friendMessages = db.fetchFriendMessages(id);
            if (friendMessages != null && !friendMessages.isEmpty()) {
        %>
        <ul class="friend-message-list">
            <%
                for (FriendMessage friendMessage : friendMessages) {
            %>
            <li class="friend-message-item">
                <h4><%= friendMessage.getSenderUsername() %>
                </h4>
                <ul class="message-list">
                    <%
                        for (Message message : friendMessage.getMessages()) {
                    %>
                    <li class="message">
                        <p><%= message.getText() %>
                        </p>
                        <span class="timestamp"><%= message.getSendTime() %></span>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </li>
            <%
                }
            %>
        </ul>
        <%
        } else {
        %>
        <p>No messages from friends.</p>
        <%
            }
        %>
    </div>
    <div class="section" id="message-section">
        <a href="messages.jsp" class="button">Send Message to a Friend</a>
    </div>
</div>

<script>
    function respondToFriendRequest(servlet, requesterId, action) {
        fetch(servlet, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'userId=' + requesterId
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Remove item from UI
                    const requestItem = document.querySelector(`.friend-request-item button[onclick*="${requesterId}"]`).closest('li');
                    requestItem.remove();

                    // Optionally, redirect back to homepage after action
                    // window.location.href = 'userDashboard.jsp';

                    alert(action === 'accept' ? 'Friend request accepted!' : 'Friend request declined.');
                } else {
                    alert('Failed to ' + action + ' friend request. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred. Please try again.');
            });
    }

    function acceptFriendRequest(fromUserId) {
        respondToFriendRequest('acceptFriendRequest', fromUserId, 'accept');
    }

    function declineFriendRequest(toUserId) {
        respondToFriendRequest('declineFriendRequest', toUserId, 'decline');
    }
</script>
</body>
</html>
