//
//  ViewController.m
//  CodingTest
//
//  Created by Mohamed Digwey on 2/15/16.
//  Copyright © 2016 Mohamed Digwey. All rights reserved.
//

//Test Commit
#import "ViewController.h"
#import "SRWebSocket.h"
#import "Constants.h"
#import "UserChatModel.h"
#import "GeneralTableViewCell.h"


@interface ViewController ()
{
    __weak IBOutlet UITextField *UsernameTextField;
    __weak IBOutlet UITableView *chatTableView;
}
@end

@implementation ViewController

SRWebSocket *webSocket;
NSMutableArray *chatMessages;

- (void)viewDidLoad {
    [super viewDidLoad];
    chatMessages = [[NSMutableArray alloc] init];
    chatTableView.delegate = self;
}

- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    webSocket = newWebSocket;
    [webSocket send:[NSString stringWithFormat:@"Hello from %@", [UIDevice currentDevice].name]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    //[self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    //[self connectWebSocket];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog([[NSString alloc]initWithFormat:@"%@",message]);
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    NSLog(@"%@", json);
   // UserChatModel *chatModel = [[UserChatModel alloc]init];
    
//    chatModel.sender = [[json objectAtIndex:0]objectForKey:@"sender"];
//    chatModel.message = [[json objectAtIndex:0]objectForKey:@"message"];
//    
    [chatMessages addObject:json];
    
    [chatTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)connectToWebSocket:(id)sender {
    if(UsernameTextField.text && UsernameTextField.text.length > 0){
        NSString *urlString = [[NSString alloc] initWithFormat:@"%@?%@=%@",WebSocketURL,Username,UsernameTextField.text];
        webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
        webSocket.delegate = self;
        [webSocket open];
        
    }else{
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error!"
                                      message:@"Please input your username"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:nil];
     [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
}
#pragma mark - Table view data source (Main Table View)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return chatMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GeneralTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.messageLabel.numberOfLines = 0;
    cell.messageLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.messageLabel.text=[[chatMessages objectAtIndex:indexPath.row] objectForKey:@"message"];
    cell.senderLabel.text=[[chatMessages objectAtIndex:indexPath.row] objectForKey:@"sender"];
    
    return cell;
}

@end
