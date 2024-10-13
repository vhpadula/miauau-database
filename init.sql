-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    login VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create person table
CREATE TABLE IF NOT EXISTS person (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    date_of_birth TIMESTAMP NOT NULL,
    rg VARCHAR(20) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    landline VARCHAR(15),
    email VARCHAR(100) NOT NULL,
    profession VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create address table
CREATE TABLE IF NOT EXISTS address (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    street VARCHAR(150) NOT NULL,
    zip_code VARCHAR(10) NOT NULL,
    number VARCHAR(10) NOT NULL,  -- Added number column
    complement VARCHAR(50),
    neighborhood VARCHAR(50),
    person_id UUID REFERENCES person(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS occupation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    working BOOLEAN NOT NULL,
    studying BOOLEAN NOT NULL,
    unemployed BOOLEAN NOT NULL,
    person_id UUID REFERENCES person(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS animal (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    sex CHAR(1) NOT NULL,
    description VARCHAR(255),
    age_group_id INT NOT NULL,
    castrated BOOLEAN NOT NULL,
    color INT NOT NULL,
    approximated_age INT NOT NULL,
    vaccination_application_date VARCHAR(20),
    anti_fleas_application_date VARCHAR(20),
    deworming_application_date VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    image_name VARCHAR(100),
    image_type VARCHAR(50),
    image BYTEA
);


CREATE TABLE IF NOT EXISTS health_situation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    healthy BOOLEAN NOT NULL,
    dirty BOOLEAN NOT NULL,
    hurt BOOLEAN NOT NULL,
    mange BOOLEAN NOT NULL,
    fleas BOOLEAN NOT NULL,
    ticks BOOLEAN NOT NULL,
    vomiting BOOLEAN NOT NULL,
    limping BOOLEAN NOT NULL,
    other VARCHAR(255),
    animal_id UUID REFERENCES animal(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS assistance_need (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    veterinarian BOOLEAN NOT NULL,
    urgency BOOLEAN NOT NULL,
    bath BOOLEAN NOT NULL,
    other VARCHAR(255),
    animal_id UUID REFERENCES animal(id) ON DELETE CASCADE
);



-- Create adoption_candidate table
CREATE TABLE IF NOT EXISTS adoption_candidate (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    candidate_status VARCHAR(50) NOT NULL,
    person_id UUID REFERENCES person(id) ON DELETE CASCADE
);


-- Insert mock data into users table
-- Assume password for all users is 'password123' (in real scenarios, hash this password)
INSERT INTO users (login, password, role) VALUES
('admin_user', 'password123', 'ADMIN'),
('regular_user1', 'password123', 'USER'),
('regular_user2', 'password123', 'USER');


-- Insert mock data into person
INSERT INTO person (name, date_of_birth, rg, cpf, phone, landline, email, profession) 
VALUES ('John Doe', '1985-05-15', '123456789', '11122233344', '555-1234', '555-4321', 'john@example.com', 'Software Engineer');

-- Insert mock data into address
INSERT INTO address (street,  zip_code, number, complement, neighborhood, person_id)
VALUES 
('Main St',   '12345', '123', 'Apt 4B', 'Downtown', (SELECT id FROM person WHERE name = 'John Doe')),
('Elm St',  '67890', '456', 'Suite 100', 'Uptown', (SELECT id FROM person WHERE name = 'John Doe')),
('Maple Ave',  '54321', '789', NULL, 'Suburbs', (SELECT id FROM person WHERE name = 'John Doe'));


INSERT INTO occupation (working, studying, unemployed, person_id) 
VALUES (TRUE, FALSE, FALSE, (SELECT id FROM person WHERE name = 'John Doe'));



-- Insert mock data into occupation
INSERT INTO occupation (working, studying, unemployed, person_id) 
VALUES (TRUE, FALSE, FALSE, (SELECT id FROM person WHERE name = 'John Doe'));

-- Insert mock data into animal
INSERT INTO animal (name, sex, description, age_group_id, castrated, color, approximated_age) 
VALUES ('Buddy', 'M', 'Friendly dog', 1, TRUE, 2, 5);

-- Insert mock data into health_situation
INSERT INTO health_situation (healthy, dirty, hurt, mange, fleas, ticks, vomiting, limping, animal_id) 
VALUES (FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, (SELECT id FROM animal WHERE name = 'Buddy'));






