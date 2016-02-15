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

@interface ViewController ()
{
    __weak IBOutlet UITextField *UsernameTextField;
}
@end

@implementation ViewController

SRWebSocket *webSocket;

- (void)viewDidLoad {
    [super viewDidLoad];    
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)connectToWebSocket:(id)sender {
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@?%@=%@",WebSocketURL,Username,UsernameTextField.text];
    webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    webSocket.delegate = self;
    
    [webSocket open];
}

@end
