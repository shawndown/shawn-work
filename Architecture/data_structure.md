# Data Structure Description

### User

```json
{
    "user_name" : "user name",
    "is_login": true,
    "program_info":
    {
        "name": "program name",
        "desc": "program info"
    },
    "course": [
        {
            "name": "course 1", 
            "desc": "course 1 info"
        },
        {
            "name": "course 2", 
            "desc": "course 2 info"
        }
    ]

}
```

### Map
```json
{
    "current_location" : {
        "center": { 
            "lat": 0.0,
            "lng": 0.0
            },
        "zoom": 3
    },
    "destination_location": {
        "center": { 
            "lat": 0.0,
            "lng": 0.0
            },
        "zoom": 3
    }, 
    "high_light_building": [
        {
            "building_id": 1001,
            "center": { 
                "lat": 0.0,
                "lng": 0.0},
            "zoom": 3
        },
        {
            "building_id": 1002,
            "center": { 
                "lat": 0.0,
                "lng": 0.0},
            "zoom": 3
        },
    ]
}
```

### Building
```json
[
    {
        "building_id": 1001,
        "building_name": "building 1",
        "building_desc": "example desc",
        "url": "https://....."
    },
    {
        "building_id": 1002,
        "building_name": "building 2",
        "building_desc": "example desc",
        "url": "https://....."
    }
]
```

### Class Timetable
```json
[
    {
        "name": "name 1",
        "desc": "example 1",
        "start_time": "1616560503",
        "stop_time": "1616560503"
    },
    {
        "name": "name 2",
        "desc": "example 2",
        "start_time": "1616560503",
        "stop_time": "1616560503"
    } 
]
```