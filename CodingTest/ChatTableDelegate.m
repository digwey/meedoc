//
//  ChatTableDelegate.m
//  CodingTest
//
//  Created by Mohamed Digwey on 2/24/16.
//  Copyright © 2016 Mohamed Digwey. All rights reserved.
//

#import "ChatTableDelegate.h"
#import "GeneralTableViewCell.h"
#import "UserChatModel.h"

@implementation ChatTableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _chatMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralTableViewCell" forIndexPath:indexPath];
    
    //Configure the cell...
    cell.messageLabel.numberOfLines = 0;
    cell.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UserChatModel *cellUserChatModel =[_chatMessages objectAtIndex:indexPath.row];
    cell.senderLabel.text = cellUserChatModel.sender;
    cell.messageLabel.text  = cellUserChatModel.message;
    
    return cell;
}

@end
