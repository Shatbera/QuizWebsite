<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.user.User" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .section h2 {
            border-bottom: 2px solid #ccc;
            padding-bottom: 10px;
        }

        .logout-button {
            float: right;
        }

        .section {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .user-item {
            display: block;
            background-color: #f5f5f5;
            padding: 12px 15px;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
            transition: background-color 0.2s;
        }

        .user-item:hover {
            background-color: #e0e0e0;
        }

        .user-cards {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .username {
            font-weight: bold;
            margin-right: 15px;
        }

        .email {
            color: #666;
        }    </style>
</head>
<body>
<%
    String currentUsername = (String) session.getAttribute("username");
    if (currentUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    ArrayList<User> users = (ArrayList<User>) request.getAttribute("users");
%>
<h1>Welcome, <%= currentUsername %>!</h1>

<form action="logout" method="get" class="logout-button">
    <input type="submit" value="Logout">
</form>

<div class="section" id="search-results">
    <h2>Search Results</h2>
    <%
        if (users != null && !users.isEmpty()) {
            for (User user : users) {
    %>
    <div class="user-cards">
        <a href="userProfile?username=<%= user.getUsername() %>" class="user-item">
            <div class="user-info">
                <span class="username"><%= user.getUsername() %></span>
                <span class="email"><%= user.getEmail() %></span>
            </div>
        </a>
    </div>
    <%
        }
    } else {
    %>
    <p>No users found.</p>
    <%
        }
    %>
</div>

</body>
</html>
