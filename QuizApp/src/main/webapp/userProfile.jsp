<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.user.UserProfile" %>
<%@ page import="models.enums.FriendRequestType" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
        }
        .profile-info {
            margin-bottom: 20px;
        }
        .profile-info p {
            margin: 10px 0;
        }
        .friend-status {
            font-weight: bold;
            color: #007bff;
        }
        .button {
            display: inline-block;
            background: #007bff;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
            border: none;
            cursor: pointer;
        }
        .button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<%
    UserProfile userProfile = (UserProfile) request.getAttribute("userProfile");
    if (userProfile == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="container">
    <h1>User Profile</h1>
    <div class="profile-info">
        <p><strong>Username:</strong> <%= userProfile.getUsername() %></p>
        <p><strong>Email:</strong> <%= userProfile.getEmail() %></p>

        <p><strong>Friend Status:</strong>
            <span id="friendStatus">
            <% if (userProfile.isFriend()) { %>
                <span class="friend-status">Friends</span>
            <% } else if (userProfile.getFriendRequestType() == null) { %>
                <button id="addFriendBtn" class="button" onclick="sendFriendRequest(<%= userProfile.getId() %>)">Add Friend</button>
            <% } else if (userProfile.getFriendRequestType() == FriendRequestType.PENDING) { %>
                <span class="friend-status">Friend Request Pending</span>
            <% } %>
            </span>
        </p>
    </div>

    <a href="search.jsp" class="button">Back to Search</a>
</div>

<script>
    function sendFriendRequest(toUserId) {
        document.getElementById('addFriendBtn').disabled = true;

        fetch('sendFriendRequest', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'toUserId=' + toUserId
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update the UI to show pending status
                    document.getElementById('friendStatus').innerHTML = '<span class="friend-status">Friend Request Pending</span>';
                } else {
                    // If there's an error, re-enable the button and show an error message
                    document.getElementById('addFriendBtn').disabled = false;
                    alert('Failed to send friend request. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('addFriendBtn').disabled = false;
                alert('An error occurred. Please try again.');
            });
    }
</script>
</body>
</html>