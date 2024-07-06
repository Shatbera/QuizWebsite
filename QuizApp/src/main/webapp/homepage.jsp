<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="config.DatabaseManager, models.quizzes.Quiz" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.user.FriendRequest" %>
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
    <h2>All Quizzes</h2>
    <%
        DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
        if (db != null) {
            ArrayList<Quiz> allQuizzes = db.getAllQuizzes();
            if (allQuizzes != null && !allQuizzes.isEmpty()) {
                for (Quiz quiz : allQuizzes) {
    %>
    <div class="quiz-item">
        <%@ include file="/quiz/quizDisplay.jsp" %>
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
    <!-- there must be subsections -->
</div>

<div class="section" id="recent-quizzes">
    <h2>Recently Created Quizzes</h2>
    <!-- there must be subsections -->
</div>

<div class="section" id="recent-activities">
    <h2>Your Recent Activities</h2>
    <!-- there must be subsections -->
</div>

<div class="section" id="created-quizzes">
    <h2>Your Created Quizzes</h2>
    <!-- there must be subsections -->
</div>

<div class="section" id="friends-activities">
    <h2>Friends' Activities</h2>

    <div class="subsection" id="friend-requests">
        <h3>Friend Requests</h3>
        <%
            ArrayList<FriendRequest> friendRequests = db.getFriendRequests(id);
            if (friendRequests != null && !friendRequests.isEmpty()) {
        %>
        <ul class="friend-request-list">
            <%
                for (FriendRequest requester : friendRequests) {
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
                    const requestItem = document.querySelector(`.friend-request-item button[onclick*="${requesterId}"]`).closest('li');
                    requestItem.remove();

                    if (document.querySelectorAll('.friend-request-item').length === 0) {
                        document.getElementById('friend-requests').innerHTML = '<p>No pending friend requests.</p>';
                    }

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
        respondToFriendRequest('cancelFriendRequest', toUserId, 'decline');
    }
</script>
</body>
</html>
