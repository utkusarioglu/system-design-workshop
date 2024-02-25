# Telegram

## Requirement

### Questions

#### Functional requirements

1. Messaging supported
1. User profiles
1. Group chat
1. Notifications
1. Media transfer for dms
1. Media transfer for groups
1. Dm retention
1. Media retention

1. System entrypoint: whether a frontend is considered the entrypoint or the web api.

#### Non-Functional Requirements

1. Scale of the system
   1. How many messages per second
   1. How many active users per day
   1. Data retention policies
1. Geographical distribution of the users
1. Availability targets
1. Latency targets

#### Data stats

1. Number of daily users
1. Number of total users
1. User profile data size and its variance
1. Expected compression effectiveness
1. Profile views per day (avg)

1. Number of dms sent per second
1. Message size (avg)
1. Dm server retention time (avg)
1. Sent notifications
   1. Sent notifications size (avg)
   1. Number of sent notifications per day (avg)
1. Media transfer
   1. Types of media
   1. Media sizes (avg)
   1. Media retention time (avg)

1. Group chat
   1. Number of groups
   1. Participant per group (avg)
