#  All of the data below will be cut and paste and the psql promte to create and populate table todo, within the to_dos database.


# Create the database
CREATE DATABASE to_dos;

# Create the table and columns
CREATE TABLE todo
(
  id SERIAL,
  activity VARCHAR(50),
  start_time VARCHAR(12),
  end_time VARCHAR(12),
  location VARCHAR(50),
  contact_name VARCHAR(50),
  contact_phone VARCHAR(12)
);


# Initial data for table todo:
INSERT INTO todo (activity, start_time, end_time, location,
  contact_name, contact_phone) VALUES ('workout', '8am', '9am', 'port crossfit',
  'ryan', '631-555-5678');

INSERT INTO todo (activity, start_time, end_time, location,
  contact_name, contact_phone) VALUES ('grocery shopping', '10am', '11:30am', 'Trader Joes',
  ' ', ' ');

INSERT INTO todo (activity, start_time, end_time, location,
  contact_name, contact_phone) VALUES ('clancy and libby dog park', '12:30pm', '2pm', 'dog park',
  'debbie', '631-567-6785');

INSERT INTO todo (activity, start_time, end_time, location,
  contact_name, contact_phone) VALUES ('movie', '3pm', '6pm', 'lowes',
  'calf', '631-545-5657');

INSERT INTO todo (activity, start_time, end_time, location,
  contact_name, contact_phone) VALUES ('dinner out', '8pm', '11pm', 'Pace Steak House',
  'the quacks', '631-652-2358');