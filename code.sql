CREATE DATABASE to_do;
CREATE TABLE todos
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(15),
  due VARCHAR(15),
  priority INT,
  completed BOOLEAN
);