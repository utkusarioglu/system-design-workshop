# Youtube System Design

## Requirements

### Functional

#### In focus

1. Upload videos
1. Watch videos
1. Search videos

#### Out of focus

1. Reactions
1. video-attached content (comments)
1. Authentication & Authorization

### Nonfunctional

1. 5-9's availability globally
1. Reliable: Uploaded videos stay uploaded
1. Scalable: Handles uneven traffic and peaks
1. Globally Responsive: < 100ms RT @ 99%

## High Level Design

This design only focuses on video upload and viewing related apis and components.

```mermaid
graph TB
    Client((Client))

    LB[/Load Balancer\]
    VideoCdn[\Video CDN/]

    UploadSvc[[Upload Service]]
    SearchSvc[[Search Service]]

    %% Local object store (S3 in private setting)
    UploadStore[(Upload Store)]

    %% Something like Celery
    UploadProcessQueue[\Upload Process Queue\]

    VideoProcessor[[Video Processor]]

    %% Object storage (S3 and alike)
    VideoBlobStore[(Video Blob Store)]

    %% Search optimized database such as elastic search
    VideoMetadataStore[(Video Meta Store)]

    %% Redis-like
    VideoMetadataCache[/Video Meta Cache/]

    Client === VideoCdn
    Client --- LB

    LB --- UploadSvc
    LB --- SearchSvc

    UploadSvc === UploadStore
    UploadSvc ..- UploadProcessQueue

    UploadProcessQueue ..- VideoProcessor
    UploadStore === VideoProcessor
    VideoProcessor === VideoBlobStore
    SearchSvc --- VideoMetadataCache
    VideoMetadataCache --- VideoMetadataStore

    VideoProcessor --- VideoMetadataStore
    
    VideoCdn === VideoBlobStore

    
```
