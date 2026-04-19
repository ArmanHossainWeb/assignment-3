# Vehicle Rental System

## Overview

This project is about designing a simple Vehicle Rental System database. I created three main tables to manage users, vehicles, and bookings. The goal was to understand how real-world systems store and manage data using SQL.

---

## Database Structure

**Users**
This table stores basic user information like name, email, phone number, and role. Each user has a unique email.

**Vehicles**
This table contains details about vehicles such as name, type, model, price, and availability status.

**Bookings**
This table keeps track of which user booked which vehicle, along with dates, status, and total cost.

---

## Relationships

One user can make multiple bookings.
A vehicle can also be booked multiple times.
Each booking is connected to one user and one vehicle.

---

## Queries Explanation

I used JOIN to combine data from different tables and show booking details with user and vehicle names.

I used EXISTS to find vehicles that have never been booked.

I used WHERE to filter specific data, like available cars.

I used GROUP BY and HAVING to count bookings and find vehicles that were booked more than two times.

---

## Conclusion

Through this project, I learned how to design a database, create relationships between tables, and write basic SQL queries. It helped me understand how a real vehicle rental system can work.
