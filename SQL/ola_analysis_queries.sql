CREATE TABLE bookings(
	date TIMESTAMP,
	time TIME,
	booking_id VARCHAR(50),
	booking_status VARCHAR(50),
	customer_id VARCHAR(50),
	vehicle_type VARCHAR(50),
	pickup_location VARCHAR(100),
	drop_location VARCHAR(100),
	v_tat INT,
	c_tat INT,
	cancelled_rides_by_customer VARCHAR(200),
	cancelled_rides_by_driver VARCHAR(200),
	incomplete_rides VARCHAR(20),
	incomplete_rides_reason VARCHAR(200),
	booking_value NUMERIC,
	payment_method VARCHAR(50),
	ride_distance NUMERIC,
	driver_ratings NUMERIC,
	customer_ratings NUMERIC
);

SELECT * FROM bookings;

-- 1. Retrieve all successful bookings:

CREATE VIEW success_booking AS
SELECT * FROM bookings
WHERE booking_status = 'Success';

SELECT * FROM success_booking;

-- 2. Find the average ride distance for each vehicle type:

CREATE VIEW ride_distance AS
SELECT vehicle_type, AVG(ride_distance) AS avg_distance FROM bookings
GROUP BY vehicle_type;

SELECT * FROM ride_distance;

-- 3. Get the total number of cancelled rides by customers:

CREATE VIEW canceled_ride_by_customer AS
SELECT COUNT(*) AS num_of_canceled_ride FROM bookings
WHERE booking_status = 'Canceled by Customer';

SELECT * FROM canceled_ride_by_customer;

-- 4. List the top 5 customers who booked the highest number of rides:

CREATE VIEW top_5_customers AS
SELECT customer_id, COUNT(booking_id) AS total_rides FROM bookings
GROUP BY customer_id
ORDER BY total_rides DESC
LIMIT 5;

SELECT * FROM top_5_customers;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

CREATE VIEW ride_cancelled_by_driver_pcissue AS
SELECT COUNT(*) AS total_rides FROM bookings
WHERE cancelled_rides_by_driver = 'Personal & Car related issue';

SELECT * FROM ride_cancelled_by_driver_pcissue;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

CREATE VIEW max_min_driver_rating AS
SELECT MAX(driver_ratings) AS max_rating, MIN(driver_ratings) AS min_rating FROM bookings
WHERE vehicle_type = 'Prime Sedan';

SELECT * FROM max_min_driver_rating;

-- 7. Retrieve all rides where payment was made using UPI:

CREATE VIEW upi_payment AS
SELECT * FROM bookings
WHERE payment_method = 'UPI';

SELECT * FROM upi_payment;

-- 8. Find the average customer rating per vehicle type:

CREATE VIEW avg_customer_rating_per_vehicle AS
SELECT vehicle_type, AVG(customer_ratings) AS avg_customer_rating FROM bookings
GROUP BY vehicle_type;

SELECT * FROM avg_customer_rating_per_vehicle;

-- 9. Calculate the total booking value of rides completed successfully:

CREATE VIEW total_booking_value AS
SELECT SUM(booking_value) AS total_value FROM bookings
WHERE booking_status = 'Success';

SELECT * FROM total_booking_value;

-- 10. List all incomplete rides along with the reason:

CREATE VIEW incomplete_ride_with_reason AS
SELECT booking_id, incomplete_rides_reason FROM bookings
WHERE incomplete_rides = 'Yes';

SELECT * FROM incomplete_ride_with_reason;