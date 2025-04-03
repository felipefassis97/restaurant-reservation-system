# Restaurant Reservation System

This is a restaurant reservation system that allows managing table bookings and availability online. The system is developed in Ruby, using a simple architecture with an SQLite database and a RESTful API approach.

## Features

- **Create a reservation**: Users can make reservations at the restaurant by providing their name and the number of people.
- **View existing reservations**: Users can check the current reservations.
- **View available tables**: The system shows available tables based on the number of people.
- **Cancel a reservation**: Users can cancel their reservations.

## Technologies Used

- **Ruby**: Programming language used to build the system.
- **SQLite**: Database used to store reservation and table information.
- **Rack**: Framework used to build the RESTful API.
- **HTML, CSS, JavaScript**: Frontend technologies.
- **Fetch API**: Used for communication between the frontend and backend.

## API Usage

### API Endpoints

- **GET /reservas**: Retrieves a list of all reservations.
- **POST /reservas**: Creates a new reservation.
- **GET /reservas/{id}**: Retrieves details of a specific reservation.
- **DELETE /reservas/{id}**: Cancels an existing reservation.
- **GET /mesas**: Retrieves a list of all tables.
- **GET /mesas/disponiveis?pessoas={number}**: Retrieves available tables based on the number of people.
