-- DROP DATABASE address_book;
-- CREATE DATABASE address_book;
DROP DATABASE tasks;
CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(250),
  due_date date,
  priority BOOLEAN
);