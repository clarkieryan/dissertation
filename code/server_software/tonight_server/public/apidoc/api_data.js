define({ api: [
  {
    "type": "get",
    "url": "/user/",
    "title": "Request Currently Logged In User information",
    "name": "index",
    "group": "User",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "field": "first_name",
            "optional": false,
            "description": "Firstname of the User."
          },
          {
            "group": "Success 200",
            "type": "String",
            "field": "last_name",
            "optional": false,
            "description": "Lastname of the User."
          },
          {
            "group": "Success 200",
            "type": "String",
            "field": "email",
            "optional": false,
            "description": "Email of the User"
          },
          {
            "group": "Success 200",
            "type": "DateTime",
            "field": "created_at",
            "optional": false,
            "description": "When the User was created"
          },
          {
            "group": "Success 200",
            "type": "DateTime",
            "field": "updated_at",
            "optional": false,
            "description": "When the User was last edited"
          }
        ]
      }
    },
    "version": "0.0.0",
    "filename": "app/controllers/api/v1/user_controller.rb"
  }
] });