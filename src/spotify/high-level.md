# Spotify High-Level Design

```mermaid
graph LR
    User1(("User 1"))
    SearchApi[["Search Api"]]
    SongApi[["Song Api"]]
    LB[/"Load Balancer"/]
    SearchStorage[("Search Storage")]
    SongStorage[("Song Storage")]

    User1 --- LB
    LB --- SongApi --- SongStorage
    LB --- SearchApi --- SearchStorage

```
### Legend

User1: Some client on web or some other kind of environment
LB: Load balancer for ingress

SongApi: Feeds the user with the song binaries to be played.
SongStorage: Stores songs as binaries, preferably allows partial retirevals

SearchApi: Provides user with search results for songs, this will use song metadata to handle searches
SearchStorage: Stores song metadatas so that searches can be carried against them.
