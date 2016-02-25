//
//  ChatTableDelegate.h
//  CodingTest
//
//  Created by Mohamed Digwey on 2/24/16.
//  Copyright © 2016 Mohamed Digwey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChatTableDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *chatMessages;

@end
