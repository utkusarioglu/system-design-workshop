# Parking Lot System Design

Structures and designed needed to create a working Parking lot management system.

## Requirements

1. Register a parking lot of multiple floors, entries, exists.
1. Track occupied and unoccupied spots
1. Schedule certain spots for certain customers at certain times of the day, days of the week and other possible time slots.
1. Ability to calculate fees based on usage, spot and other parameters.
1. Retain past information about the usage of spots and other aspects of the parking lot business.

## Design considerations

### Tracking spots, entries, exits

This can be done some hardware that detects the presence of a car at a spot and then send this over some sort of network to the system. 
The design of the detection hardware is beyond the scope of this document.
A draft of an api that could collect data from sensors for spots and other relevant aspects of the operation can be seen in [sensor api specification](./sensor.api.yaml)

### Scheduling spots 

Spots could be rented out to different people, and they could rent different segments of the day. Scheduled spots could be offered at a lower price and a fine regime could be applied if the vehicle is still present at a spot at a time out of schedule.
