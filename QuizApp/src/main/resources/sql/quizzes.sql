USE mydatabase;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS quiz_attempts;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS quizzes;

-- Create quizzes table
CREATE TABLE quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    randomize BOOL DEFAULT FALSE,
    display_type ENUM ('one_page', 'multiple_page'),
    immediate_correction BOOL DEFAULT FALSE,
    date_created timestamp default current_timestamp
);

-- Create questions table
CREATE TABLE questions(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT NOT NULL,
    question_type ENUM ('question_response', 'fill_in_blank', 'multi_choice', 'picture_response', 'multi_answer', 'multi_choice_multi_answer', 'matching'),
    question_text VARCHAR(255),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE
);

-- Create answers table
CREATE TABLE answers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer VARCHAR(255) NOT NULL,
    is_correct BOOL DEFAULT TRUE,
    answer_order SMALLINT DEFAULT 0,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

-- Create matches table
CREATE TABLE matches(
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    left_match VARCHAR(255) NOT NULL,
    right_match VARCHAR(255) NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

create table quiz_attempts(
    id int auto_increment primary key,
    quiz_id int not null,
    user_id int not null,
    score int not null,
    time_taken bigint not null,
    attempt_time timestamp default current_timestamp,
    foreign key (quiz_id) references quizzes(id),
    foreign key (user_id) references users(id),
    unique (quiz_id, user_id, attempt_time)
);

-- Insert quizzes
INSERT INTO quizzes (user_id, title, description, randomize, display_type, immediate_correction) VALUES
(0, 'General Knowledge Quiz', 'Test your general knowledge.', 0, 'one_page', 0),
(0, 'Math Quiz', 'Solve these math problems.', 1, 'multiple_page', 1),
(0, 'Science Quiz', 'A quiz on various science topics.', 0, 'one_page', 0);

-- Insert questions for General Knowledge Quiz (id=1)
INSERT INTO questions (quiz_id, question_type, question_text) VALUES
(1, 'question_response', 'What is the capital of France?'),
(1, 'multi_choice_multi_answer', 'Which of the following are fruits?'),
(1, 'matching', 'Match the country with its capital.'),
(1, 'picture_response', 'https://media.cntraveler.com/photos/58de89946c3567139f9b6cca/1:1/w_3633,h_3633,c_limit/GettyImages-468366251.jpg'),
(1, 'multi_answer', 'Select all countries in Europe.');

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
(3, 'Rome', TRUE, 4),
-- For 'Identify this famous landmark.'
(4, 'Eiffel Tower', TRUE, 0),
(4, 'Eiffel', TRUE, 0),
-- For 'Select all countries in Europe.'
(5, 'France', TRUE, 0),
(5, 'Germany', TRUE, 0),
(5, 'Italy', TRUE, 0),
(5, 'Spain', TRUE, 0);

-- Insert questions for Math Quiz (id=2)
INSERT INTO questions (quiz_id, question_type, question_text) VALUES
(2, 'question_response', 'What is 2+2?'),
(2, 'multi_choice_multi_answer', 'Which of the following numbers are prime?'),
(2, 'matching', 'Match the number with its square.'),
(2, 'fill_in_blank', 'The perimeter of a square with side length ___ is equal to four times its side length.'),
(2, 'multi_answer', 'Select all even numbers.');

-- Insert answers for Math Quiz questions
INSERT INTO answers (question_id, answer, is_correct, answer_order) VALUES
-- For 'What is 2+2?'
(6, '4', TRUE, 1),
-- For 'Which of the following numbers are prime?'
(7, '2', TRUE, 1),
(7, '4', FALSE, 2),
(7, '5', TRUE, 3),
(7, '9', FALSE, 4),
-- For 'Match the number with its square.'
(8, '2', TRUE, 1),
(8, '4', TRUE, 2),
(8, '3', TRUE, 3),
(8, '9', TRUE, 4),
-- For 'The perimeter of a square with side length ___ is equal to four times its side length.'
(9, 's * 4', TRUE, 1),
(9, 's + 4', FALSE, 2),
(9, '4 * s', FALSE, 3),
(9, '4 * 4', FALSE, 4),
-- For 'Select all even numbers.'
(10, '2', TRUE, 1),
(10, '4', TRUE, 2),
(10, '3', FALSE, 3),
(10, '5', FALSE, 4);

-- Insert questions for Science Quiz (id=3)
INSERT INTO questions (quiz_id, question_type, question_text) VALUES
(3, 'question_response', 'What planet is known as the Red Planet?'),
(3, 'multi_choice_multi_answer', 'Which of the following are chemical elements?'),
(3, 'matching', 'Match the animal with its classification.'),
(3, 'picture_response', 'Identify this chemical structure.'),
(3, 'multi_answer', 'Select all vertebrate animals.');

-- Insert answers for Science Quiz questions
INSERT INTO answers (question_id, answer, is_correct, answer_order) VALUES
-- For 'What planet is known as the Red Planet?'
(11, 'Mars', TRUE, 1),
-- For 'Which of the following are chemical elements?'
(12, 'Hydrogen', TRUE, 1),
(12, 'Water', FALSE, 2),
(12, 'Oxygen', TRUE, 3),
(12, 'Salt', FALSE, 4),
-- For 'Match the animal with its classification.'
(13, 'Lion', TRUE, 1),
(13, 'Mammal', TRUE, 2),
(13, 'Eagle', TRUE, 3),
(13, 'Bird', TRUE, 4),
-- For 'Identify this chemical structure.'
(14, 'Water', TRUE, 1),
(14, 'Carbon Dioxide', FALSE, 2),
(14, 'Sodium Chloride', FALSE, 3),
(14, 'Nitric Acid', FALSE, 4),
-- For 'Select all vertebrate animals.'
(15, 'Lion', TRUE, 1),
(15, 'Fish', TRUE, 2),
(15, 'Insect', FALSE, 3),
(15, 'Snake', FALSE, 4);

-- Insert question 'Which of the following rivers is the longest?' for General Knowledge Quiz (id=1)
INSERT INTO questions (quiz_id, question_type, question_text) VALUES
(1, 'multi_choice', 'Which of the following rivers is the longest?');

-- Insert answers for 'Which of the following rivers is the longest?' question
INSERT INTO answers (question_id, answer, is_correct, answer_order) VALUES
(16, 'Amazon', FALSE, 1),
(16, 'Nile', TRUE, 2),
(16, 'Yangtze', FALSE, 3),
(16, 'Mississippi', FALSE, 4);

-- Insert matches for General Knowledge Quiz
INSERT INTO matches (question_id, left_match, right_match) VALUES
(3, 'France', 'Paris'),
(3, 'Germany', 'Berlin');

-- Insert matches for Math Quiz
INSERT INTO matches (question_id, left_match, right_match) VALUES
(10, '2', '4'),
(10, '3', '9');

-- Insert matches for Science Quiz
INSERT INTO matches (question_id, left_match, right_match) VALUES
(15, 'Lion', 'Mammal'),
(15, 'Fish', 'Vertebrate');

alter table quizzes add column time_created timestamp default current_timestamp;