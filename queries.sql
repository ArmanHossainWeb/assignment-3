CREATE TABLE users (
  user_id INT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(15),
  role VARCHAR(10) CHECK (role IN ('Admin', 'Customer'))
)
INSERT INTO
  users (user_id, name, email, phone, role)
VALUES
  (
    1,
    'Alice',
    'alice@example.com',
    '1234567890',
    'Customer'
  ),
  (
    2,
    'Bob',
    'bob@example.com',
    '0987654321',
    'Admin'
  ),
  (
    3,
    'Charlie',
    'charlie@example.com',
    '1122334455',
    'Customer'
  );

CREATE TABLE vehicles (
  vehicle_id INT PRIMARY KEY,
  name VARCHAR(50),
  type VARCHAR(50) CHECK (type IN ('car', 'bike', 'truck')),
  model INT,
  registration_number VARCHAR(100) UNIQUE,
  rental_price INT,
  status VARCHAR(20) CHECK (status IN ('available', 'rented', 'maintenance'))
)
INSERT INTO
  vehicles (
    vehicle_id,
    name,
    type,
    model,
    registration_number,
    rental_price,
    status
  )
VALUES
  (
    1,
    'Toyota Corolla',
    'car',
    2022,
    'ABC-123',
    50,
    'available'
  ),
  (
    2,
    'Honda Civic',
    'car',
    2021,
    'DEF-456',
    60,
    'rented'
  ),
  (
    3,
    'Yamaha R15',
    'bike',
    2023,
    'GHI-789',
    30,
    'available'
  ),
  (
    4,
    'Ford F-150',
    'truck',
    2020,
    'JKL-012',
    100,
    'maintenance'
  );

CREATE TABLE bookings (
  booking_id INT PRIMARY KEY,
  user_id INT REFERENCES users (user_id),
  vehicle_id INT REFERENCES vehicles (vehicle_id),
  start_date DATE,
  end_date DATE,
  status VARCHAR(20) CHECK (
    status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled')
  ),
  total_cost INT
)
INSERT INTO
  bookings (
    booking_id,
    user_id,
    vehicle_id,
    start_date,
    end_date,
    status,
    total_cost
  )
VALUES
  (
    1,
    1,
    2,
    '2023-10-01',
    '2023-10-05',
    'Completed',
    240
  ),
  (
    2,
    1,
    2,
    '2023-11-01',
    '2023-11-03',
    'Completed',
    120
  ),
  (
    3,
    3,
    2,
    '2023-12-01',
    '2023-12-02',
    'Confirmed',
    60
  ),
  (
    4,
    1,
    1,
    '2023-12-10',
    '2023-12-12',
    'Pending',
    100
  );

-- -- Query 1: JOIN
-- Requirement: Retrieve booking information along with Customer name and Vehicle name.
SELECT
  bookings.booking_id,
  users.name as customer_name,
  vehicles.name as vehicle_name,
  bookings.start_date,
  bookings.end_date,
  bookings.status  
FROM
  bookings
  JOIN users ON bookings.user_id = users.user_id
  JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id


-- Query 2: EXISTS
-- Requirement: Find all vehicles that have never been booked.
SELECT * FROM vehicles v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings b
  WHERE b.vehicle_id = v.vehicle_id 
)

-- Query 3: WHERE
-- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).
SELECT * FROM vehicles v
WHERE v.type = 'car' AND v.status = 'available'

-- Query 4: GROUP BY and HAVING
-- Requirement: Find the total number of bookings for each vehicle and display 
  -- only those vehicles that have more than 2 bookings.
  
SELECT v.name AS vehicle_name,COUNT(b.booking_id) AS total_booking FROM vehicles as v
  JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING COUNT(b.booking_id) > 2