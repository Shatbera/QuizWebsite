<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }

        .registration-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .registration-form h2 {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        .form-group button {
            padding: 10px 15px;
            background-color: #007bff;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 3px;
        }

        .form-group button:hover {
            background-color: #0056b3;
        }

        .message {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
    <script>
        function validatePasswords() {
            const password = document.getElementById('password').value;
            const repeatPassword = document.getElementById('repeatPassword').value;
            if (password !== repeatPassword) {
                alert('Passwords do not match!');
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="registration-form">
    <h2>Register</h2>
    <% if (request.getAttribute("message") != null) { %>
    <div class="message"><%= request.getAttribute("message") %>
    </div>
    <% } %>
    <form action="registerServlet" method="post" onsubmit="return validatePasswords()">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="repeatPassword">Repeat Password:</label>
            <input type="password" id="repeatPassword" name="repeatPassword" required>
        </div>
        <div class="form-group">
            <button type="submit">Register</button>
        </div>
    </form>
</div>
</body>
</html>
