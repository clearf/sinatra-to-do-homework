CREATE TABLE tasks
(
	id SERIAL PRIMARY KEY,
	task VARCHAR(50),
	description VARCHAR(100),
	due VARCHAR(12),
	urgent BOOLEAN,
	complete BOOLEAN
)
