# Telegram Messaging High-Level Design

```mermaid
graph LR 
    User1((User 1))
    User2((User 2))
    LB["Load Balancer"]
    MessageApi[["Message API Servers (50)"]]
    MessageDB[("Message Storage")]

    User1 --- LB
    User2 --- LB

    LB --- MessageApi --- MessageDB
```

## Entity Design

```mermaid
erDiagram 
    Message {
        serial messageId PK
        serial roomId FK
        serial senderId FK
        string text
        timestamptz time
    }

    User {
        serial userId PK
        varchar(20) username
    }

    Room {
        serial roomId PK
        serial creatorId FK
    }

    MessageEvent {
        serial userId FK
        serial messageId FK
        %% Sent, Read, etc
        enum eventType 
    }

    User ||--|| Message : creates
    Message ||--|| Room : "is posted to"
    User }|--o{ Room : creates
     
    Message ||--o{ MessageEvent : has
```

## Message sending

1. Client 1 sends a message to Client 2
2. MessageApi1 Receives the message
3. MessageApi1 saves the message to storage
4. MessageApi1 saves the message received event to storage
5. MessageApi2, where Client2 is connected to is subscribed to MessageReceived event on the cache, it receives the update and pulls the message from message storage
5. MessageApi2 sends the message to Client2

There needs to be a background job that checks MessageReceived and other similar events to make sure that no message remains unsent.
