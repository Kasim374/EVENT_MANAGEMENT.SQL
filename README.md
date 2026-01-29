# EVENT_MANAGEMENT.SQL

--Project Overview--
This project implements an Event Management System using SQL.
It demonstrates core to advanced SQL concepts such as CRUD operations, filtering, joins, subqueries, aggregate functions, window functions, and case expressions.

--Technologies Used--
Database: MySQL
Language: SQL

--Database Schema--
(1)events
Stores event-related information.
event_id (Primary Key)
event_name
event_date
city
total_seats
available_seats
organizer_id

(2) venues
Stores venue details.
venue_id (Primary Key)
venue_name
location
capacity

(3) organizers
Stores organizer information.
organizer_id (Primary Key)
organizer_name
email

(4) attendees
Stores attendee information.
attendee_id (Primary Key)
attendee_name
email

(5) tickets
Stores ticket booking details.
ticket_id (Primary Key)
event_id (Foreign Key)
attendee_id (Foreign Key)
price
booking_date

(6) payments
Stores payment information.
payment_id (Primary Key)
ticket_id (Foreign Key)
payment_status
payment_date

--SQL Queries Included--

Q1. CRUD Operations
Add, update, delete, and search:
Events
Venues
Organizers
Attendees
Ticket bookings

 Q2. WHERE, HAVING, LIMIT
Get upcoming events in a specific city
Retrieve top 5 highest revenue-generating events
Find attendees who booked tickets in the last 7 days

 Q3. AND, OR, NOT Operators
Events scheduled in December AND having more than 50% seats available
Attendees who booked a ticket OR have pending payment
Events that are NOT fully booked

 Q4. ORDER BY & GROUP BY
Sort events by date in ascending order
Count number of attendees per event
Calculate total revenue generated per event

 Q5. Aggregate Functions
Total revenue generated from all events
Event with the highest number of attendees
Average ticket price across all events

Q6. Primary & Foreign Key Constraints
Prevent attendees from booking the same event multiple times
Link payments to tickets using foreign key constraints

 Q7. SQL Joins
INNER JOIN: Events with venue information
LEFT JOIN: Attendees who booked tickets but did not complete payment
RIGHT JOIN: Events without any attendees
FULL OUTER JOIN: Attendees who have not booked any tickets

 Q8. Subqueries
Events generating revenue above average ticket sales
Attendees who booked tickets for multiple eventsOrganizers managing more than three events

 Q9. Date & Time Functions
Extract month from event date
Calculate days remaining for upcoming events
Format payment date as YYYY-MM-DD HH:MM:SS

Q10. String Functions
Convert organizer names to uppercase
Remove extra spaces from attendee names using TRIM()
Replace NULL email values with "Not Provided"

 Q11. Window Functions
Rank events based on total revenue earned
Display cumulative sum of ticket sales
Show running total of attendees registered per event

Q12. CASE Expressions
Categorize events based on seat availability:
High Demand
Moderate Demand
Low Demand
Assign payment status:
Successful
Failed
Pending
