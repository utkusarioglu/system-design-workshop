# Scheduling

Spots can be rented or be on spot market.

```mermaid
classDiagram
    class Slot {
        start: int
        end: int
        renterId: string
    }

    class SpotSchedule {
        slots: 
    }

    class Scheduler {
        timeSlotDuration: int
        schedules: SpotSchedule[]
    }


```

## Spot reservation

1. Request all spots that are available for a certain time period
2. After user chooses a spot, save the start and end times for the spot

```mermaid
graph
    
    
```
