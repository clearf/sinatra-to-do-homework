CREATE DATABASE todo;

CREATE TABLE tasks
(
  id serial primary key,
  task VARCHAR(255),
  info VARCHAR(25),
  done BOOLEAN
);

-- psql -d todo -f tasks.sql