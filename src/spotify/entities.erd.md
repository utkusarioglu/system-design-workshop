# Spotify Entities

```mermaid
erDiagram
    SongMetadata {
        serial song_id PK
        varchar song_name
        serial album_id FK
        serial artist_id FK
    }

    AlbumMetadata {
        serial album_id PK
        varchar album_name
    }

    ArtistMetadata {
        serial artist_id PK
        varchar artist_name
    }

    AlbumSongAssoc {
        serial album_id FK "Partial1"
        serial song_id FK "Partial1"
    }

    ArtistAlbumAssoc {
        serial artist_id FK "Partial1"
        serial album_id FK "Partial1"
    }

    SongMetadata ||--|{ AlbumMetadata : "released in"
    AlbumMetadata }|--|{ ArtistMetadata : "released by"
```
