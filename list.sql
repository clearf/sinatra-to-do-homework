CREATE TABLE to_do_list
(
  id SERIAL PRIMARY KEY,
  person VARCHAR(25),
  task VARCHAR(25),
  priority INT,
  completed BOOLEAN
);