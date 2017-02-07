DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL

);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Fernanda','Mora'),
  ('Candra','Tran'),
  ('John','Doe');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Fixing sql', 'My computer is not working', (SELECT id FROM users WHERE fname = 'Candra')),
  ('Party', 'Where is the party??', (SELECT id FROM users WHERE fname = 'Fernanda'));

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  (1, null, 1, 'Try restarting.'),
  (2, null, 2, 'At my house!'),
  (1, 1, 2, 'I tried that already'),
  (1, 3, 3, 'I have the same problem');

INSERT INTO
  question_follows (question_id, follower_id)
VALUES
  (1,1),
  (1,3),
  (2,2);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (2,2),
  (2,1),
  (2,3),
  (1,3);
