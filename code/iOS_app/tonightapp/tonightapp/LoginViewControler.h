//
//  LoginViewControler.h
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewControler : UIViewController
    -(BOOL)loginUser:(NSString *)email withPassword:(NSString *)password;
@end
