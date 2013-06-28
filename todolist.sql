-- Creates a table in our todo database
-- Requires a database called todo
-- Run from the terminal with psql -d todo -f todolist.sql

CREATE TABLE todolist
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(140),
  notes VARCHAR(500),
  done BOOLEAN
);