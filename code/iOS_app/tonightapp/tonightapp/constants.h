//
//  constants.h
//  
//
//  Created by Ryan Clarke on 12/03/2014.
//
//

#ifndef _constants_h
#define _constants_h

#define SITE_URL(url) @"http://ryc-diss.herokuapp.com" url
#define API_URL(url) SITE_URL("/api/v1") url

//User URL's
#define LOGIN_URL           SITE_URL("/oauth/token")
#define REGISTER_URL        API_URL("/register")
#define USER_URL            API_URL("/user")
#define USER_FOLLOWING      API_URL("/user/following")
#define USER_FOLLOW         [NSString stringWithFormat:@"%@%@", API_URL(), @"/user/follow"]


//Feeds
#define USER_FEED_URL        API_URL("/user/feed");

//Discover URL's
#define CITIES_URL          API_URL("/cities")
#define CATEGORIES_URL      API_URL("/categories")

#define CATEGORIES_EVENTS_URL(venue_id, cat_id) [NSString stringWithFormat:@"%@%@%@%@%@%@",API_URL(),@"/venues/",venue_id ,@"/categories/", cat_id, @"/events"]

//Define algmation of URL's
#define CATEGORY_BY_CITY_URL(id)[NSString stringWithFormat:@"%@%@%@%@",API_URL(),@"/cities/",id ,@"/categories"]
#define VENUE_BY_CITY(id) [NSString stringWithFormat:@"%@%@%@%@",API_URL(),@"/cities/",id ,@"/venues"]


//Venue URL's
#define VENUES_URL          API_URL("/venues")
#define VENUE_EVENTS_URL(id) [NSString stringWithFormat:@"%@%@%@%@",API_URL(),@"/venues/",id ,@"/events"]

//Event URL's
#define EVENTS_URL          API_URL("/events")


//OAuth tokens
#define CLIENT_KEY @"bd402410a6099481f156f1e8b629b982208fdaabda3a1d4cf7d745ee17838d9c"
#define CLIENT_SECRET @"bd402410a6099481f156f1e8b629b982208fdaabda3a1d4cf7d745ee17838d9c"


//Hex Color function
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif
