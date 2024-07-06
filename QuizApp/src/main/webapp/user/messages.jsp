<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="config.DatabaseManager, models.user.UserProfile" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.user.FriendResponse" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Send Message</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        select, textarea, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Send Message to a Friend</h1>
    <%
        Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        DatabaseManager db = (DatabaseManager) application.getAttribute(DatabaseManager.NAME);
        ArrayList<FriendResponse> friends = db.getFriends(userId);
    %>
    <form id="messageForm">
        <select id="friendSelect" required>
            <option value="">Select a friend</option>
            <% for (FriendResponse friend : friends) { %>
            <option value="<%= friend.getId() %>"><%= friend.getUsername() %></option>
            <% } %>
        </select>
        <textarea id="messageText" rows="4" placeholder="Type your message here" required></textarea>
        <button type="submit">Send Message</button>
    </form>
</div>

<script>
    document.getElementById('messageForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const friendId = document.getElementById('friendSelect').value;
        const message = document.getElementById('messageText').value;

        fetch('sendMessage', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'recipientId=' + friendId + '&message=' + encodeURIComponent(message)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Message sent successfully!');
                    document.getElementById('messageText').value = '';
                } else {
                    alert('Failed to send message. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred. Please try again.');
            });
    });
</script>
</body>
</html>