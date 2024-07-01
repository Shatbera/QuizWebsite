<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Index Page</title>
    <style>
        /* Basic styling for the page */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        .buttons {
            margin-top: 20px;
        }
        .buttons a, .buttons form {
            margin: 5px;
        }
        .buttons button {
            padding: 10px 20px;
            background-color: #007bff;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 3px;
        }
        .buttons button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<h1>Welcome to the Index Page</h1>
<div class="buttons">
    <form action="pages/login.jsp" method="GET">
        <button type="submit">Login</button>
    </form>
    <form action="pages/register.jsp" method="GET">
        <button type="submit">Register</button>
    </form>
</div>
</body>
</html>
