CREATE DATABASE IF NOT EXISTS AirlineTravelSystem;
use AirlineTravelSystem;

CREATE TABLE Airline (
Airline_Id char(2) NOT NULL, 
Airline_Name varchar(50) NOT NULL,
PRIMARY KEY (Airline_Id)
);

CREATE TABLE Airport(
Airport_Id char(3) NOT NULL,
Airport_Name varchar(50) NOT NULL,
PRIMARY KEY (Airport_Id)
);


CREATE TABLE Aircraft_Model(
Model_Id int NOT NULL,
firstRows int NOT NULL,
firstSeatsInRow int NOT NULL,
businessRows int NOT NULL,
businessSeatsInRow int NOT NULL,
economyRows int NOT NULL,
economySeatsInRow int NOT NULL,
PRIMARY KEY(Model_Id)
);

CREATE TABLE Aircraft(
Aircraft_id int NOT NULL,
Model_Id int NOT NULL,
PRIMARY KEY (Aircraft_id),
FOREIGN KEY(Model_Id) REFERENCES Aircraft_Model(Model_Id)  ON DELETE CASCADE
);

CREATE TABLE Days_Of_Operation(
Aircraft_id int NOT NULL,
Day varchar(9) NOT NULL,
PRIMARY KEY (Aircraft_id, Day),
FOREIGN KEY (Aircraft_id) REFERENCES Aircraft (Aircraft_id)  ON DELETE CASCADE
);
 
CREATE TABLE Flight(
Flight_number int NOT NULL,
Airline_Id char(2) NOT NULL, 
Aircraft_Id int NOT NULL,
Departure_Airport char(3) NOT NULL,
Arrival_Airport char(3) NOT NULL,
Departing_Time DATETIME NOT NULL,
Arrival_Time DATETIME NOT NULL,
Flight_type varchar(20) NOT NULL,
FirstClassPrice float NOT NULL,
BuisnessClassPrice float NOT NULL,
EconomyClassPrice float NOT NULL,
PRIMARY KEY (flight_number, airline_id),
FOREIGN KEY (Airline_id) REFERENCES Airline(Airline_id)  ON DELETE CASCADE,
FOREIGN KEY (Aircraft_id) REFERENCES Aircraft(Aircraft_id)  ON DELETE CASCADE,
FOREIGN KEY (Departure_Airport) REFERENCES Airport(Airport_Id)  ON DELETE CASCADE,
FOREIGN KEY (Arrival_Airport) REFERENCES Airport(Airport_Id)  ON DELETE CASCADE
);

CREATE TABLE Account(
User_name varchar(50) NOT NULL,
Password varchar(50) NOT NULL,
type varchar(25) NOT NULL,
PRIMARY KEY (user_name)
);


CREATE TABLE Customer(
Customer_name varchar(50) NOT NULL,
User_name varchar(50) NOT NULL,
PRIMARY KEY (Customer_name, User_name),
FOREIGN KEY (User_name) REFERENCES Account(User_name)  ON DELETE CASCADE
);

CREATE TABLE FlightTicket(
Id_number int NOT NULL,
Customer_name varchar(50) NOT NULL,
Purchase_time_date date NOT NULL,
User_name varchar(50) NOT NULL,
Booking_Fee float NOT NULL,
Ticket_Cost float NOT NULL,
Passenger_Name varchar(50) NOT NULL,
PRIMARY KEY (Id_number),
FOREIGN KEY (User_name, Customer_name) REFERENCES Customer(User_name, Customer_name)  ON DELETE CASCADE
);



CREATE TABLE AssociatedWith(
Airline_Id char(2) NOT NULL, 
Airport_Id char(3) NOT NULL,
FOREIGN KEY (Airline_Id) REFERENCES Airline(Airline_Id)  ON DELETE CASCADE,
FOREIGN KEY (Airport_Id) REFERENCES Airport(Airport_Id)  ON DELETE CASCADE,
PRIMARY KEY(Airline_Id, Airport_Id)
);

	
CREATE TABLE Reserves(
Id_number int NOT NULL,
Seat_Number varchar(3) NOT NULL,
Flight_number int NOT NULL,
Airline_Id char(2) NOT NULL,
Class varchar(20) NOT NULL,
UNIQUE(Flight_number, Airline_Id, Seat_Number),
FOREIGN KEY (Id_Number) REFERENCES FlightTicket(Id_Number) ON DELETE CASCADE,
FOREIGN KEY (Flight_number) REFERENCES Flight(Flight_number) ON DELETE CASCADE,
FOREIGN KEY (Airline_Id) REFERENCES Flight(Airline_Id) ON DELETE CASCADE,
PRIMARY KEY (Id_number, Flight_number, Airline_Id)
);

CREATE TABLE Owns(
Airline_Id char(2) NOT NULL, 
Aircraft_Id int NOT NULL,
FOREIGN KEY (Airline_Id) REFERENCES Airline(Airline_Id) ON DELETE CASCADE,
FOREIGN KEY (Aircraft_Id) REFERENCES Aircraft(Aircraft_Id) ON DELETE CASCADE,
PRIMARY KEY (Airline_Id, Aircraft_Id)
);

CREATE TABLE QA(
Question_Id int NOT NULL,
Question_User_name varchar(50), 
Question_Text text,
Answer_User_name varchar(50),
Answer_Text text,
PRIMARY KEY(Question_Id),
FOREIGN KEY(Question_User_name) REFERENCES Account(User_name) ON DELETE CASCADE
);

CREATE TABLE Waitlist(
User_name varchar(50),
Flight_number int,
Airline_Id char(2),
PRIMARY KEY(User_name, Flight_number, Airline_Id),
FOREIGN KEY(User_name) REFERENCES Account(User_name) ON DELETE CASCADE,
FOREIGN KEY(Flight_number) REFERENCES Flight(Flight_number) ON DELETE CASCADE
);

INSERT INTO Account (User_name, Password, type)
VALUES ('admin', 'pass', 'Admin'), ('cr', 'pass', 'Customer Representative'), ('customer', 'pass', 'Customer');

INSERT INTO Airline (Airline_Id, Airline_name)
VALUES
    ('AA', 'American Airlines'),
    ('UA', 'United Airlines'),
    ('DL', 'Delta Air Lines'),
    ('WN', 'Southwest Airlines'),
    ('BA', 'British Airways'),
    ('LH', 'Lufthansa'),
    ('AF', 'Air France'),
    ('EK', 'Emirates'),
    ('SQ', 'Singapore Airlines'),
    ('QF', 'Qantas');

INSERT INTO Aircraft_Model(Model_Id, firstRows, firstSeatsInRow, businessRows, businessSeatsInRow, economyRows, economySeatsInRow)
VALUES 
	(1, 5, 2, 10, 4, 15, 6),
    (2, 1, 1, 1, 1, 1, 1);

INSERT INTO Aircraft (Aircraft_id, Model_Id)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 1),
    (10, 1);
    
INSERT INTO Owns (Airline_Id, Aircraft_Id)
VALUES
    ('AA', 1),
    ('UA', 2),
    ('DL', 3),
    ('WN', 4),
    ('BA', 5),	
    ('LH', 6),
    ('AF', 7),
    ('EK', 8),
    ('SQ', 9),
    ('QF', 10);

INSERT INTO Airport (Airport_Id, Airport_Name)
VALUES
    ('LAX', 'Los Angeles International Airport'),
    ('JFK', 'John F. Kennedy International Airport'),
    ('LHR', 'Heathrow Airport'),
    ('ATL', 'Hartsfield-Jackson Atlanta International Airport'),
    ('CDG', 'Charles de Gaulle Airport'),
    ('HND', 'Tokyo Haneda Airport'),
    ('SIN', 'Singapore Changi Airport'),
    ('DXB', 'Dubai International Airport'),
    ('SYD', 'Sydney Airport'),
    ('AMS', 'Amsterdam Airport Schiphol');
    
INSERT INTO Flight (
    Flight_number,
    Airline_Id,
    Aircraft_Id,
    Departure_Airport,
    Arrival_Airport,
    Departing_Time,
    Arrival_Time,
    Flight_type,
    FirstClassPrice,
    BuisnessClassPrice,
    EconomyClassPrice
) VALUES 
    (1, 'AA', 2, 'JFK', 'LAX', '2023-12-01 08:00:00', '2023-12-01 12:00:00', 'Domestic', 500.00, 300.00, 150.00),
    (2, 'AF', 3, 'CDG', 'LHR', '2023-12-02 14:30:00', '2023-12-02 18:45:00', 'International', 700.00, 400.00, 200.00),
    (3, 'BA', 6, 'LHR', 'JFK', '2023-12-03 10:15:00', '2023-12-03 15:30:00', 'International', 600.00, 350.00, 180.00),
    (4, 'DL', 1, 'JFK', 'LAX', '2023-12-04 07:45:00', '2023-12-04 11:30:00', 'Domestic', 550.00, 320.00, 160.00),
    (5, 'EK', 5, 'DXB', 'JFK', '2023-12-05 20:00:00', '2023-12-06 01:30:00', 'International', 750.00, 450.00, 220.00);

    
INSERT INTO Flight (
    Flight_Number,
    Airline_Id,
    Aircraft_Id,
    Departure_Airport,
    Arrival_Airport,
    Departing_Time,
    Arrival_Time,
    Flight_Type,
    FirstClassPrice,
    BuisnessClassPrice,
    EconomyClassPrice
) VALUES
    (301, 'AA', 1, 'CDG', 'JFK', '2023-11-02 09:45:00', '2023-11-03 14:20:00', 'International', 700.00, 400.00, 200.00),
    (302, 'AA', 3, 'JFK', 'CDG', '2023-11-10 12:30:00', '2023-11-11 18:15:00', 'International', 650.00, 380.00, 190.00);

INSERT INTO Customer(Customer_name, user_name) VALUES("Filler Name", "customer");

INSERT INTO Aircraft (Aircraft_id, Model_Id)
VALUES (11, 2);

INSERT INTO Owns (Airline_Id, Aircraft_Id)
VALUES ('UA', 11);

-- Create a flight involving the previously made airline
INSERT INTO Flight (
    Flight_number,
    Airline_Id,
    Aircraft_Id,
    Departure_Airport,
    Arrival_Airport,
    Departing_Time,
    Arrival_Time,
    Flight_type,
    FirstClassPrice,
    BuisnessClassPrice,
    EconomyClassPrice
) VALUES 
    (6, 'UA', 11, 'LAX', 'JFK', '2023-12-15 14:00:00', '2023-12-15 18:00:00', 'Domestic', 480.00, 280.00, 140.00);
    
INSERT INTO FlightTicket (Id_number, Customer_name, Purchase_time_date, User_name, Booking_Fee, Ticket_Cost, Passenger_Name)
VALUES
    (1, 'Filler Name', '2023-12-01', 'customer', 50.00, 480.00, 'Passenger 1'),
    (2, 'Filler Name', '2023-12-01', 'customer', 50.00, 480.00, 'Passenger 2'),
	(3, 'Filler Name', '2023-12-01', 'customer', 50.00, 480.00, 'Passenger 3');

-- Add entries to Reserves for each seat in the flight
INSERT INTO Reserves(Id_number, Seat_Number, Flight_number, Airline_Id, Class)
VALUES
    (1, '1A', 6, 'UA', 'first'),
    (2, '2A', 6, 'UA','business'),
    (3, '3A', 6, 'UA', 'economy');

