# Package UrlParser

```mermaid
graph LR
    p[Parse url search string]
    c[Cats like]

    p --> c

    subgraph "loop"
        g[Get next parsed url string]

        p --> g
    end
    
```
