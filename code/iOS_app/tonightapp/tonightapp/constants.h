//
//  constants.h
//  
//
//  Created by Ryan Clarke on 12/03/2014.
//
//

#ifndef _constants_h
#define _constants_h

#define SITE_URL(url) @"http://ryc-diss.herokuapp.com/" url
#define API_URL(url) SITE_URL("/api/v1") url

//User URL's
#define LOGIN_URL           SITE_URL("/oauth/token")
#define REGISTER_URL        API_URL("/register")
#define USER_URL            API_URL("/user")

//Feeds
#define USER_FEED_URL        API_URL("/user/feed");

//Discover URL's
#define CITIES_URL          API_URL("/cities")
#define CATEGORIES_URL      API_URL("/categories")

//Venue URL's
#define VENUES_URL          API_URL("/venues")

//Event URL's
#define EVENTS_URL          API_URL("/events")


//OAuth tokens
#define CLIENT_KEY @"bd402410a6099481f156f1e8b629b982208fdaabda3a1d4cf7d745ee17838d9c"
#define CLIENT_SECRET @"bd402410a6099481f156f1e8b629b982208fdaabda3a1d4cf7d745ee17838d9c"


//Hex Color function
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif
