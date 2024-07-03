CREATE TABLE quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    randomize TINYINT(1) DEFAULT 0,
    display_type ENUM ('one_page', 'multiple_page'),
    immediate_correction TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE questions(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_type ENUM ('question_response', 'fill_in_blank', 'multi_choice', 'picture_response, multi_answer, multi_choice_multi_answer, matching'),
    question_text VARCHAR(255),
    order_matters TINYINT(1) DEFAULT 0,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

CREATE TABLE answers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer VARCHAR(255) NOT NULL,
    is_correct TINYINT(1) DEFAULT 1,
    answer_order SMALLINT DEFAULT 0,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

CREATE TABLE matches(
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    left_match VARCHAR(255) NOT NULL,
    right_match VARCHAR(255) NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);