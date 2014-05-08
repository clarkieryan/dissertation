#REST API V1 Resources

All requests need to be prepended with the url /api/v1/

###Events

| Resource | Description | Parameters |Response |
|---|---|---|---|
| GET /events | This resource responds with all of the events on the system paginated | 200 OK <br />`[{ name: "", }]` | |
| GET /events/:id | This resource responds with the details of a specific event | 200 OK <br /> `{name:}` | |

###Venues
| Resource | Description | Parameters |Response |
|---|---|---|---|
| GET /venues | This resource responds with all of the venues on the system paginated | 200 OK <br />`[{ name: "", }]` | |
| GET /venues/:id | This resource responds with the details of a specific venue | 200 OK <br /> `{name:}` | |
| GET /venues/:id/events | This resource responds with all of the events that a specific venue is hosting | 200 OK <br /> `[{name:}]` | |

###User
| Resource | Description | Parameters |Response |
|---|---|---|---|
| GET /user | This resource returns details about the user | 200 OK <br />  `Example JSON`| |
| POST /user | This resource updates a users details | 200 OK  | |
| POST /register | This resource allows a new user to be registered onto the system | | |
| GET /user/feed | This resource returns the currently logged on users personal feed | | |
| GET /user/following| | |  |
| POST /user/follow/:id | | | |

###Categories
| Resource | Description | Parameters |Response |
|---|---|---|---|
| GET /categories | | | |
| GET /categories/:id | | ||
| GET /categories/:id/events | | ||

###Cities
| Resource | Description | Parameters |Response |
|---|---|---|---|
| GET /cities | | ||
| GET /cities/:id | | ||
| GET /cities/:id/events | | ||
| GET /cities/:id/categories | | ||
| GET /cities/:id/venues | | ||