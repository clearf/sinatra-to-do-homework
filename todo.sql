DROP TABLE todo;
CREATE TABLE todo
(
  id SERIAL PRIMARY KEY,
  description VARCHAR(160),
  due VARCHAR(4),
  completed BOOLEAN
);


