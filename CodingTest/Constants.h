//
//  Constants.h
//  CodingTest
//
//  Created by Mohamed Digwey on 2/15/16.
//  Copyright (c) 2016 Mohamed Digwey. All rights reserved.
//

// urls
#define WebSocketURL @"https://codingtest.meedoc.com/ws"

//uri
#define Username @"username"


// device
#define IsIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IsIPhone4sOrLess (IsIPhone && [[UIScreen mainScreen] bounds].size.height < 568.0)

// OS
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] < 9 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8 && [[[UIDevice currentDevice] systemVersion] floatValue] >= 7)

