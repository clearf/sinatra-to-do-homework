CREATE DATABASE errands;
CREATE TABLE to_do_list
(
  id serial primary key,
  name VARCHAR(255),
  description VARCHAR(25),
  time date,
);