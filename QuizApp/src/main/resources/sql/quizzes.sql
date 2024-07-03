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
(0, 'Science Quiz', 'A quiz on various science topics.', 0, 'one_page', 1);


-- Insert questions for General Knowledge Quiz (id=1)
INSERT INTO questions (quiz_id, question_type, question_text) VALUES
(1, 'question_response', 'What is the capital of France?'),
(1, 'multi_choice_multi_answer', 'Which of the following are fruits?'),
(1, 'matching', 'Match the country with its capital.');

-- Insert questions for Math Quiz (id=2)
INSERT INTO questions (quiz_id, question_type, question_text) VALUES
(2, 'question_response', 'What is 2+2?'),
(2, 'multi_choice_multi_answer', 'Which of the following numbers are prime?'),
(2, 'matching', 'Match the number with its square.');

-- Insert questions for Science Quiz (id=3)
INSERT INTO questions (quiz_id, question_type, question_text) VALUES
(3, 'question_response', 'What planet is known as the Red Planet?'),
(3, 'multi_choice_multi_answer', 'Which of the following are chemical elements?'),
(3, 'matching', 'Match the animal with its classification.');


-- Insert answers for General Knowledge Quiz questions
INSERT INTO answers (question_id, answer, is_correct, answer_order) VALUES
-- For 'What is the capital of France?'
(1, 'Paris', TRUE, 1),
-- For 'Which of the following are fruits?'
(2, 'Apple', TRUE, 1),
(2, 'Carrot', FALSE, 2),
(2, 'Banana', TRUE, 3),
(2, 'Potato', FALSE, 4),
-- For 'Match the country with its capital.'
(3, 'France', TRUE, 1),
(3, 'Paris', TRUE, 2),
(3, 'Italy', TRUE, 3),
(3, 'Rome', TRUE, 4);

-- Insert answers for Math Quiz questions
INSERT INTO answers (question_id, answer, is_correct, answer_order) VALUES
-- For 'What is 2+2?'
(4, '4', TRUE, 1),
-- For 'Which of the following numbers are prime?'
(5, '2', TRUE, 1),
(5, '4', FALSE, 2),
(5, '5', TRUE, 3),
(5, '9', FALSE, 4),
-- For 'Match the number with its square.'
(6, '2', TRUE, 1),
(6, '4', TRUE, 2),
(6, '3', TRUE, 3),
(6, '9', TRUE, 4);

-- Insert answers for Science Quiz questions
INSERT INTO answers (question_id, answer, is_correct, answer_order) VALUES
-- For 'What planet is known as the Red Planet?'
(7, 'Mars', TRUE, 1),
-- For 'Which of the following are chemical elements?'
(8, 'Hydrogen', TRUE, 1),
(8, 'Water', FALSE, 2),
(8, 'Oxygen', TRUE, 3),
(8, 'Salt', FALSE, 4),
-- For 'Match the animal with its classification.'
(9, 'Lion', TRUE, 1),
(9, 'Mammal', TRUE, 2),
(9, 'Eagle', TRUE, 3),
(9, 'Bird', TRUE, 4);

-- Insert matches for General Knowledge Quiz
INSERT INTO matches (question_id, left_match, right_match) VALUES
(3, 'France', 'Paris'),
(3, 'Italy', 'Rome');

-- Insert matches for Math Quiz
INSERT INTO matches (question_id, left_match, right_match) VALUES
(6, '2', '4'),
(6, '3', '9');

-- Insert matches for Science Quiz
INSERT INTO matches (question_id, left_match, right_match) VALUES
(9, 'Lion', 'Mammal'),
(9, 'Eagle', 'Bird');