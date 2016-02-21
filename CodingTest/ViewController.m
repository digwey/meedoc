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
    __weak IBOutlet UITextField *messageTextField;
    __weak IBOutlet UITableView *chatTableView;
    __weak IBOutlet UIView *messagesView;
    __weak IBOutlet UIView *connectView;
    __weak IBOutlet UIButton *signoutButton;
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



- (IBAction)connectToWebSocket:(id)sender {
    if(UsernameTextField.text && UsernameTextField.text.length > 0){
        [self openSocketConnection:UsernameTextField.text];
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
- (IBAction)sendMessage:(id)sender {
    [messageTextField resignFirstResponder];
    UserChatModel *chatModel = [[UserChatModel alloc] init];
    chatModel.sender = UsernameTextField.text;
    chatModel.message = messageTextField.text;
    [chatMessages addObject:chatModel];
    [self openSocketConnection:UsernameTextField.text];
    [chatTableView reloadData];
}

- (IBAction)signout:(id)sender {
    signoutButton.hidden = true;
    connectView.hidden = false;
    [chatMessages removeAllObjects];
    [webSocket close];
    [messageTextField setText:@""];
    [chatTableView reloadData];
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
    
    //Configure the cell...
    cell.messageLabel.numberOfLines = 0;
    cell.messageLabel.lineBreakMode = UILineBreakModeWordWrap;
    UserChatModel *cellUserChatModel =[chatMessages objectAtIndex:indexPath.row];
    cell.senderLabel.text = cellUserChatModel.sender;
    cell.messageLabel.text  = cellUserChatModel.message;
    
    return cell;
}

#pragma mark - Websocket delegate methods
- (void)webSocketDidOpen:(SRWebSocket *)newWebSocket {
    webSocket = newWebSocket;
    [webSocket send:[NSString stringWithFormat:@"Hello from %@", [UIDevice currentDevice].name]];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    messagesView.hidden = false;
    connectView.hidden = true;
    signoutButton.hidden = false;
    [UsernameTextField resignFirstResponder];
    
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSObject *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    UserChatModel *chatModel = [[UserChatModel alloc] initWithSenderAndMessage:[json valueForKey:@"sender"] andMessage:[json valueForKey:@"message"]];
    [chatMessages addObject:chatModel];
    [chatTableView reloadData];
}


-(void) openSocketConnection : (NSString*) chatUsername{
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@?%@=%@",WebSocketURL,Username,chatUsername];
    webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    webSocket.delegate = self;
    [webSocket open];
}


@end
