DROP TABLE todolist;
CREATE TABLE todolist
(
  id SERIAL PRIMARY KEY,
  todo VARCHAR(50),
  note VARCHAR(50),
  status BOOLEAN
);

