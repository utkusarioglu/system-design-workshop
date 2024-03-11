# Phone company billing system

A system that tracks phone calls made by susbcriber and creates billing for them monthly.

## Requirements

### Functional

1. Track start and end timestamp of every phone conversation.
1. track the source and target of every phone conversation.
1. Create monthly bills for the users.
1. Staggered billing, if the user subscribes on 7th, they get their bill on 7th every month.
1. Scope of the system of North America
1. Users cannot place calls if they have overdue bills

### Nonfunctional

#### Durable

The bills should persist once they are created.

#### Reliable

The system should reliably create the bills with the expected amounts.

#### Available

The system should be able to provide bills on demand at anytime.
The system should be available to notify the call system for overdue bills before each call is connected during any time of the day.

#### Scalable

The system should be able to handle millions of calls starting at ending, with unpredictable peaks in usage.

#### Secure

Each bill should only be available to the respective subscriber and no one else.

## High Level Design

The system is basically the infrastructure for a massive data transformation algorithm that takes in the call logs and outputs the billing statements.

We shall assume the following call log entity:

```mermaid
erDiagram
    Call {
        SERIAL call_id PK
        INT source_phone_number
        INT target_phone_number
        DATETIMETZ start
        DATETIMETZ end
    }

    Subscriber {
        SERIAL subscriber_id PK
        INT phone_number
        DATE subscription_date
    }
```

### As a batch processing system

If we design the system to run in a daily batch mode, the system may look like this:

```mermaid
graph TB
    subgraph Call System
        SubscriberStore[(Subscriber Store)]
        CallsStore[(Calls Store)]
        CallsCache[\Calls Cache\]
    end

    SubscriberQueue[/Subscriber Queue/]
    BillCalcSvc[[Bill Calculation Service]]
    SubscriberMngSvc[Subscriber Manager Service]

    BillsStore[(Bills Store)]
    BillsCache[\Bills Cache\]

    SubscriberStore ===> |1| SubscriberMngSvc

    SubscriberMngSvc ..-> |2| SubscriberQueue
    SubscriberQueue ..-> |3| BillCalcSvc

    CallsStore ===> CallsCache
    CallsCache ===> |4| BillCalcSvc

    BillCalcSvc ---> |5| BillsCache
    BillsCache ---> |6| BillsStore
```

### As an event based system

In this architecture, we will assume that the calls system emits events when a call ends.

The structure of a `CallEndEvent` may look like this:

```mermaid
erDiagram
    CallEndEvent {
        INT source_number
        INT target_number
        DATETIMETZ start
        DATETIMETZ end
    }
```

The system is responsible for queuing an update for the respective subscriber's running bill in accordance with the event.

```mermaid
graph TB
    subgraph Call Service
        CallEvent((Call Event))
        SubscriberStore[(Subscriber Store)]
    end

    %% Queues the call end events received from the call system upon the end of a call
    CallEventQueue[/Call Event Queue/]

    %% Responsible for updating the running bills based on call events. They are likely to issue an atomic operation to the database
    CallEventSvc[[Call Event Service]]

    %% Stores the running bills
    BillStore[(Bill Store)]

    CallEvent ..-> |1| CallEventQueue
    CallEventQueue ..-> |2| CallEventSvc
    SubscriberStore ===> |3| CallEventSvc
    CallEventSvc ..-> |4| BillStore
```
