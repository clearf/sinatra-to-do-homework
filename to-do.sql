DROP TABLE tasks;

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(25),
  description VARCHAR(50),
  due_date DATE,
  urgency BOOLEAN
);

-- add three tasks
INSERT INTO tasks (task, description) VALUES ('clean room', 'your room is a pigsty');
INSERT INTO tasks (task, description) VALUES ('pump gas', 'get ready for your road trip to CT');
INSERT INTO tasks (task, description) VALUES ('pack lunch', 'Do you want to starve?');
