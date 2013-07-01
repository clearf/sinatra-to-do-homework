CREATE TABLE to_dos
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(140),
  due_date VARCHAR(8),
  accomplished BOOLEAN
);