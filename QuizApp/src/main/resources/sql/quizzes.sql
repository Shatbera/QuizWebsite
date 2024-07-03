USE mydatabase;

DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS quizzes;

CREATE TABLE quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    randomize BOOL DEFAULT FALSE,
    display_type ENUM ('one_page', 'multiple_page'),
    immediate_correction BOOL DEFAULT FALSE
	-- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE questions(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_type ENUM ('question_response', 'fill_in_blank', 'multi_choice', 'picture_response', 'multi_answer', 'multi_choice_multi_answer', 'matching'),
    question_text VARCHAR(255),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

CREATE TABLE answers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer VARCHAR(255) NOT NULL,
    is_correct BOOL DEFAULT TRUE,
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


INSERT INTO quizzes (user_id, title, description, randomize, display_type, immediate_correction) VALUES
(0, 'General Knowledge Quiz', 'Test your general knowledge.', 0, 'one_page', 1),
(0, 'Math Quiz', 'Solve these math problems.', 1, 'multiple_page', 0),
(0, 'Science Quiz', 'A quiz on various science topics.', 0, 'one_page', 1),
(0, 'History Quiz', 'Test your history knowledge.', 1, 'multiple_page', 0),
(0, 'Literature Quiz', 'Answer questions about literature.', 0, 'one_page', 1),
(0, 'Geography Quiz', 'How well do you know geography?', 1, 'multiple_page', 0),
(0, 'Music Quiz', 'Identify songs and artists.', 0, 'one_page', 1),
(0, 'Art Quiz', 'Test your knowledge of art.', 1, 'multiple_page', 0),
(0, 'Sports Quiz', 'A quiz on various sports.', 0, 'one_page', 1),
(0, 'Technology Quiz', 'How well do you know technology?', 1, 'multiple_page', 0);