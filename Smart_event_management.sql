------------------SMART EVENT MANAGEMENT SYSTEM----------------
--IN THIS PROJECT WE CAN DO FOLLOWING TOPICS--
--FOLLOWING TOPICS ARE AS FOLLOWS:-
--(1) MANAGE EVENTS AND VENUES
--(2) HANDLE ATTENDEE REGISTRATION & TICKET SALES
--(3) TRACK PAYMENTS AND REVENUE
--(4) GENERATE INSIGHTS AND REPORTS

--CREATING DATABASE AND CREATING TABLES--
CREATE DATABASE smart_event_management;
USE smart_event_management;
CREATE TABLE IF NOT EXISTS events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
    venue_id INT,
    organizer_id INT,
    ticket_price DECIMAL(10,2),
    total_seats INT,
    available_seats INT
    FOREIGN KEY (venue_id) REFERENCES venues (venue_id),
    FOREIGN KEY (organizer_id) REFERENCES organizers (organizer_id));

CREATE TABLE IF NOT EXISTS venues (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(100),
    location VARCHAR(100),
    capacity INT);

CREATE TABLE IF NOT EXISTS organizers (
    organizer_id INT PRIMARY KEY,
    organizer_name VARCHAR(100),
    contact_email VARCHAR(100),
    phone_number INT);

CREATE TABLE IF NOT EXISTS attendees (
    attendee_id INT PRIMARY KEY,
    attendee_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15));

CREATE TABLE IF NOT EXISTS tickets (
    ticket_id INT PRIMARY KEY,
    event_id INT,
    attendee_id INT,
    booking_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id));

CREATE TABLE IF NOT EXISTS payments(
    payment_id INT PRIMARY KEY,
    ticket_id INT,
    amount_paid DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id));

--INSERT SAMPLE DATAS--

INSERT INTO events
(event_id, event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats)
VALUES
(1, 'Tech Conference 2025', '2025-12-10', 3, 2, 2500.00, 800, 400),
(2, 'Music Night', '2025-12-15', 1, 3, 1500.00, 1000, 200),
(3, 'Startup Expo', '2025-11-20', 2, 6, 2000.00, 2000, 1200),
(4, 'Art & Culture Fest', '2025-10-05', 4, 5, 800.00, 1500, 750),
(5, 'Business Summit', '2025-09-25', 2, 4, 3000.00, 2000, 300),
(6, 'Open Air Concert', '2025-12-20', 5, 1, 1800.00, 3000, 1500);

INSERT INTO venues (venue_id, venue_name, location, capacity)
 VALUES
(1, 'Grand Hall', 'Mumbai', 1000),
(2, 'Expo Center', 'Delhi', 2000),
(3, 'City Auditorium', 'Bangalore', 800),
(4, 'Convention Hub', 'Ahmedabad', 1500),
(5, 'Open Arena', 'Pune', 3000),
(6, 'Seaside Pavilion', 'Goa', 1200);

INSERT INTO organizers (organizer_id, organizer_name, contact_email, phone_number)
 VALUES
(1, 'EventSphere', 'info@eventsphere.com', 987654321),
(2, 'TechFest Org', 'contact@techfest.com', 987654322),
(3, 'Music Mania', 'music@mania.com', 987654323),
(4, 'Business Meet', 'biz@meet.com', 987654324),
(5, 'Cultural Club', 'culture@club.com', 987654325),
(6, 'Startup Connect', 'startup@connect.com', 987654326);

INSERT INTO attendees (attendee_id, attendee_name, email, phone)
 VALUES
(1, 'Aisha Khan', 'aisha@gmail.com', '987650001'),
(2, 'Rohit Sharma', 'rohit@gmail.com', '987650002'),
(3, 'Priya Patel', 'priya@gmail.com', '987650003'),
(4, 'Arjun Mehta', 'arjun@gmail.com', '987650004'),
(5, 'Neha Verma', 'neha@gmail.com', '987650005'),
(6, 'Sameer Joshi', 'sameer@gmail.com', '987650006');

INSERT INTO tickets (ticket_id, event_id, attendee_id, booking_date, status)
VALUES
(1, 1, 1, '2025-12-01', 'Booked'),
(2, 2, 2, '2025-12-02', 'Booked'),
(3, 3, 3, '2025-11-18', 'Booked'),
(4, 4, 4, '2025-10-01', 'Cancelled'),
(5, 5, 5, '2025-09-20', 'Booked'),
(6, 6, 6, '2025-12-05', 'Booked');

INSERT INTO payments (payment_id, ticket_id, amount_paid, payment_status, payment_date)
VALUES
(1, 1, 2500.00, 'Paid', '2025-12-02'),
(2, 2, 1500.00, 'Paid', '2025-12-03'),
(3, 3, 0.00, 'Pending', NULL),
(4, 4, 0.00, 'Failed', NULL),
(5, 5, 3000.00, 'Paid', '2025-09-21'),
(6, 6, 1800.00, 'Paid', '2025-12-06');

-- (Q1) PERFORM CRUD OPERATIONS --
UPDATE events
SET available_seats = 150
WHERE event_id = 1;

DELETE FROM attendees 
WHERE attendee_id = 2;

SELECT * FROM events;
SELECT * FROM venues;
SELECT * FROM organizers;
SELECT * FROM attendees;
SELECT * FROM tickets;
SELECT * FROM payments;

-- (Q2) USES SQL CLAUSES.

SELECT event_name,event_date
FROM events
WHERE venue_id = 1
AND event_date > CURDATE();

SELECT ticket_id, SUM(amount_paid) AS total_revenue 
FROM payments
WHERE payment_status = "paid"
GROUP BY ticket_id
HAVING  SUM(amount_paid)>0
ORDER BY total_revenue DESC
LIMIT 5;

SELECT attendee_id FROM tickets
WHERE booking_date >= CURDATE()
LIMIT 5;

-- (Q3) APPLYING SQL OPERATORS.

SELECT event_name FROM events
WHERE MONTH(event_date) = 12
AND available_seats > (total_seats/2);

SELECT attendee_id FROM tickets
WHERE status = "booked"
OR ticket_id IN (SELECT ticket_id FROM payments
WHERE payment_status = "pending");

SELECT event_name FROM events
WHERE available_seats = 0;

-- (Q4) SORTING And GROUPING DATA.

SELECT event_name, event_date FROM events
ORDER BY event_date ASC;

SELECT event_id, COUNT(ticket_id) AS total_tickets
FROM tickets
GROUP BY event_date;

SELECT event_id, SUM(amount_paid) AS total_revenue
FROM payments
WHERE payment_status = "paid"
GROUP BY event_id;

-- (Q5) USING AGGREGRATE FUNCTIONS.

SELECT SUM(amount_paid) AS total_revenue
FROM payments
WHERE payment_status = "paid";

SELECT event_id, COUNT(ticket_id) AS total_tickets
FROM tickets
GROUP BY event_id
ORDER BY total_tickets DESC
LIMIT 1;

SELECT AVG(ticket_price) AS avg_ticket_price
FROM events;

-- (Q6) ESTABLISH PRIMARY AND FOREIGN KEY RELATIONSHIP.

ALTER TABLE tickets
ADD CONSTRAINT unique_event_attendee
UNIQUE (event_id,attendee_id);

ALTER TABLE payments
ADD CONSTRAINT fk_ticket_payment
FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id);

-- (Q7) APPLYING JOINS.

SELECT e.event_name,e.event_date,v.venue_name,v.location
FROM events e
JOIN venues v
ON e.venue_id=v.venue_id;

SELECT a.attendee_id,t.ticket_id
FROM attendees a
LEFT JOIN tickets t
ON a.attendee_id = t.attendee_id
LEFT JOIN payments p
ON t.ticket_id = p.ticket_id
WHERE p.payment_status <> "paid" OR p.payment_status IS NULL;

SELECT e.event_name
FROM tickets t
RIGHT JOIN events e
ON t.event_id = e.event_id
WHERE t.ticket_id IS NULL;

SELECT a.attendee_name
FROM attendees a
LEFT JOIN tickets t
ON a.attendee_id = t.attendee_id
WHERE t.ticket_id IS NULL;

UNION

SELECT a.attendee_name
FROM tickets t
RIGHT JOIN attendees a
ON t.attendee_id = a.attendee_id
WHERE t.ticket_id IS NULL;


-- (Q8) USING SUBQUERY.

SELECT event_id, SUM (price) AS total_revenue
FROM tickets
GROUP BY event_id
HAVING SUM(price)>
(
    SELECT AVG(price) FROM tickets);

SELECT attendee_id FROM tickets
WHERE attendee_id IN (
    SELECT attendee_id FROM tickets 
    GROUP BY attendee_id
    HAVING COUNT(DISTINCT event_id) > 1);

SELECT organizer_id FROM events
WHERE organizer_id IN(
    SELECT organizer_id FROM events
    GROUP BY organizer_id
    HAVING COUNT(event_id)>3);

-- (Q9) IMPLEMENT DATE AND TIME FUNCTIONS.

SELECT event_id, MONTH(event_date) AS event_month
FROM events;

SELECT event_name, DATEDIFF(event_date, CURDATE()) AS days_remaining
FROM events
WHERE event_date > CURDATE();

SELECT payment_id,DATE_FORMAT(payment_date, %Y-%m-%d %H:%i:%s) AS formatted_payment_date
FROM payments;

-- (Q10) USING STRING MANIPULATION FUNCTIONS.

SELECT UPPER(organizer_name) AS organizer_name
FROM organizers;

SELECT TRIM(attendee_name) AS attendee_name
FROM attendees;

SELECT attendee_name, ISNULL(email, "NOT PROVIDED") AS email
FROM attendees;

-- (Q11) IMPLEMENT WINDOWS FUNCTIONS.

SELECT event_id SUM(price) AS total_revenue,
RANK() OVER (ORDER BY SUM(price) DESC) AS revenue_rank
FROM tickets
GROUP BY event_date;

SELECT ticket_id, price, SUM(price) 
OVER (ORDER BY ticket_id) AS cumulative_sales
FROM tickets;

SELECT event_id, attendee_id COUNT(attendee_id)
OVER(PARTITION BY event_id ORDER BY attendee_id) AS running_total
FROM tickets;

-- (Q12) USING SQL CASE EXPRESSIONS.

SELECT event_id,
CASE 
    WHEN available_seats < 0.2 * total_seats THEN "HIGH DEMAND"
    WHEN available_seats BETWEEN 0.2 * total_seats AND 0.5 * total_seats THEN "MODERATE DEMAND"
    ELSE "LOW DEMAND"
END AS demand_status
FROM events;

SELECT payment_id,
CASE 
    WHEN payment_status = "Success" THEN "Successful"
    WHEN payment_status = "Failed"  THEN "Failed"
    ELSE "Pending"
END AS final_status
FROM payments;

---------------------THANK YOU--------------------------------------