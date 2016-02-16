//
//  GeneralTableViewCell.h
//  CodingTest
//
//  Created by Mohamed Digwey on 2/16/16.
//  Copyright © 2016 Mohamed Digwey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *senderLabel;


- (void)buildWithData:(id)data;

@end
