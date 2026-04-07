# CLI Lab Booking System

Simple command-line lab booking system in plain Ruby.  
Users can book resources (microscope, projector, etc.) with rules for availability and cancellation.

## What I Completed
- **Core**: All 5 rules + User, Resource, Booking classes
- **Extension**: Role check, BookingManager, constants, lists
- **Extra**: Interactive menu CLI


## Folder Structure
```bash
lab_booking/
├── test/test_booking.rb
├── booking.rb
├── booking_manager.rb
├── constants.rb
├── errors.rb
├── resource.rb
├── user.rb
└── app.rb 
```


## How to Run
```bash
cd lab_booking
ruby app.rb          # interactive menu
ruby test/test_booking.rb   # run tests
```