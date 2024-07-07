<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
            margin: 20px;
        }

        h1, h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin: 15px 0;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .form-group input[type="checkbox"] {
            width: auto;
        }

        .question-header {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }

        .question-header h3 {
            margin: 0;
            font-size: 1.5em;
        }

        .question-content {
            padding: 15px;
            border: 2px solid #4CAF50;
            border-radius: 10px;
            background-color: #f9f9f9;
            margin-bottom: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }

        button:hover {
            background-color: #45a049;
        }

        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        button:hover:enabled {
            background-color: #45a049;
        }

        button:active:enabled {
            background-color: #3e8e41;
        }


        .submit-button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #1e90ff;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 16px;
            font-weight: bold;
            max-width: 200px;
            margin: 0 auto;
            display: block;
        }

        .submit-button:hover {
            background-color: #147acd;
        }

        h4 {
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 5px;
        }

        .form-group input[type="checkbox"] {
            display: none;
        }

        .form-group input[type="checkbox"] + label:before {
            content: '';
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-right: 10px;
            vertical-align: middle;
            background-color: #fff;
            border: 2px solid #4CAF50;
            border-radius: 3px;
            box-sizing: border-box;
        }

        .form-group input[type="checkbox"]:checked + label:before {
            background-color: #4CAF50;
            content: '✔';
            color: white;
            font-size: 14px;
            text-align: center;
            line-height: 18px;
        }
    </style>
    <script>
        let questionCount = 0;

        function toggleImmediateCorrection() {
            const displayType = document.getElementById("displayType").value;
            const immediateCorrectionDiv = document.getElementById("immediateCorrectionDiv");
            if (displayType === "Multiple-Page") {
                immediateCorrectionDiv.style.display = "block";
            } else {
                immediateCorrectionDiv.style.display = "none";
            }
        }

        function addQuestion() {
            questionCount++;
            const questionsDiv = document.getElementById("questionsDiv");

            const questionDiv = document.createElement("div");
            questionDiv.className = 'question-content';
            questionDiv.setAttribute("id", questionCount);

            fetch('createQuestionDisplay.jsp?questionId=' + questionCount)
                .then(response => response.text())
                .then(data => {
                    questionDiv.innerHTML = data.replace(/_0/g, "_" + questionCount);

                    questionsDiv.appendChild(questionDiv);

                    if (questionCount > 1) {
                        document.getElementById("minusButton").disabled = false;
                    }
                })
                .catch(error => console.error('Error loading createQuestionDisplay.jsp:', error));
        }

        function removeQuestion(questionId) {
            const questionDiv = document.getElementById(questionId);
            questionDiv.remove();

            questionCount--;

            if (questionCount === 1) {
                document.getElementById("minusButton").disabled = true;
            }
        }

        function toggleQuestionLabel(questionId) {
            const questionType = document.getElementById("questionType_" + questionId).value;
            const questionTextLabel = document.getElementById("questionTextLabel_" + questionId);

            if (questionType === "PICTURE_RESPONSE") {
                questionTextLabel.textContent = "Question URL:";
            } else {
                questionTextLabel.textContent = "Question:";
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Create new Quiz</h1>
    <form action="createQuiz" method="post">
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <input type="text" id="description" name="description" required>
        </div>

        <div class="form-group">
            <input type="checkbox" id="randomize" name="randomize" value="false">
            <label for="randomize">Randomize Questions</label>
        </div>

        <div class="form-group">
            <label for="displayType">Display Type:</label>
            <select id="displayType" name="displayType" onchange="toggleImmediateCorrection()">
                <option value="Single-Page">Single-Page</option>
                <option value="Multiple-Page">Multiple-Page</option>
            </select>
        </div>

        <div id="immediateCorrectionDiv" class="form-group" style="display:none;">
            <input type="checkbox" id="immediateCorrection" name="immediateCorrection" value="false">
            <label for="immediateCorrection">Immediate Correction</label>
        </div>

        <h2>Questions</h2>
        <div id="questionsDiv">
            <!-- Questions will be dynamically added here -->
        </div>

        <div class="button-container">
            <button class="add-remove-button" type="button" id="addQuestionButton" onclick="addQuestion()">+</button>
            <button class="add-remove-button" type="button" id="minusButton" onclick="removeQuestion(questionCount)" disabled>-</button>
        </div>

        <div class="form-group">
            <input class="submit-button" type="submit" value="Create Quiz">
        </div>
    </form>
</div>

<script>
    toggleImmediateCorrection();
    addQuestion();
</script>
</body>
</html>
