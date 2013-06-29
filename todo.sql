CREATE DATABASE lists;
CREATE TABLE to_do
(
id SERIAL PRIMARY KEY,
task VARCHAR(50),
location VARCHAR(50),
description VARCHAR (140),
is_this_done BOOLEAN
);