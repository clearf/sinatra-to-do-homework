CREATE TABLE task_list
(
  id SERIAL PRIMARY KEY,
  person VARCHAR(30),
  task VARCHAR(140),
  priority INT,
  completed BOOLEAN
);