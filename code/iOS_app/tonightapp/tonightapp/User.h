//
//  User.h
//  tonightapp
//
//  Created by Ryan Clarke on 31/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
-(id)initWithUser;
    - (NSString *)loginUser:(NSString *)email withPassword:(NSString *)password;
    -(NSString *)registerUser:(NSString *)email withPassword:(NSString *)password withName:(NSString*)name;
    -(NSString *)checkToken;
    -(void)logoutUser;
@end
