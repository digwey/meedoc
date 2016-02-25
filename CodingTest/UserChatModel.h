//
//  UserChatModel.h
//  CodingTest
//
//  Created by Mohamed Digwey on 2/16/16.
//  Copyright © 2016 Mohamed Digwey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger{
    PATIENT = 0,
    DOCTOR,
}UserType;

@interface UserChatModel : NSObject

-(id) initWithSenderAndMessage:(NSString*) sender andMessage:(NSString*) message;

@property (nonatomic,strong,readonly) NSString* sender;
@property (nonatomic,strong,readonly) NSString* message;
@property(nonatomic) UserType userType;

@end
