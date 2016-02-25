//
//  UserChatModel.m
//  CodingTest
//
//  Created by Mohamed Digwey on 2/16/16.
//  Copyright © 2016 Mohamed Digwey. All rights reserved.
//

#import "UserChatModel.h"

@implementation UserChatModel

-(id) initWithSenderAndMessage:(NSString*) sender andMessage:(NSString*) message{
    self = [super init];
    
    _sender = sender;
    _message = message;
    
    return self;
}

@end
