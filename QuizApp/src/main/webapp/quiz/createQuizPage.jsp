<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Quiz</title>
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
    </script>
</head>
<body>
<h1>Create new Quiz</h1>
<form action="createQuiz" method="post">
    <div>
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required>
    </div>

    <div>
        <label for="description">Description:</label>
        <input type="text" id="description" name="description" required>
    </div>

    <div>
        <label for="randomize">Randomize Questions:</label>
        <input type="checkbox" id="randomize" name="randomize" value="false">
    </div>

    <div>
        <label for="displayType">Display Type:</label>
        <select id="displayType" name="displayType" onchange="toggleImmediateCorrection()">
            <option value="Single-Page">Single-Page</option>
            <option value="Multiple-Page">Multiple-Page</option>
        </select>
    </div>

    <div id="immediateCorrectionDiv" style="display:none;">
        <label for="immediateCorrection">Immediate Correction:</label>
        <input type="checkbox" id="immediateCorrection" name="immediateCorrection" value="false">
    </div>

    <h2>Questions</h2>
    <div id="questionsDiv">
        <!-- Questions will be dynamically added here -->
    </div>

    <button type="button" id="addQuestionButton" onclick="addQuestion()">+</button>
    <button type="button" id="minusButton" onclick="removeQuestion(questionCount)" disabled>-</button>

    <div>
        <input type="submit" value="Create Quiz">
    </div>
</form>

<script>
    toggleImmediateCorrection();
    addQuestion();
</script>
</body>
</html>
