//
//  HRNewChatViewController.m
//  Chattr
//
//  Created by Michael Hulet on 11/9/14.
//  Copyright (c) 2014 Human Productions. All rights reserved.
//

#import "HRNewChatViewController.h"
#import <Firebase/Firebase.h>
@interface HRNewChatViewController ()
@property (strong, nonatomic) Firebase *db;
@property (strong, nonatomic) NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UIView *recipientView;
@property (weak, nonatomic) IBOutlet UITextField *recipientField;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIView *messageView;
-(IBAction)cancel:(UIBarButtonItem *)sender;
-(IBAction)send;
@end
@implementation HRNewChatViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"%@", self.db);
    self.recipientView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.recipientView.layer.shadowOpacity = .1;
    self.recipientView.layer.shadowOffset = CGSizeMake(0, 3);
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, self.messageView.frame.size.width, 1.0);
    topBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.messageView.layer addSublayer:topBorder];
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc] initWithTarget:self.recipientField action:@selector(resignFirstResponder)];
    taps.numberOfTapsRequired = 2;
    [self.navigationController.navigationBar addGestureRecognizer:taps];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.messageField action:@selector(resignFirstResponder)];
    taps.numberOfTapsRequired = 2;
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(Firebase *)db{
    if(!_db){
        _db = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-2971.firebaseio.com/"];
    }
    return _db;
}
#pragma mark - UITableViewDataSource Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}
-(IBAction)cancel:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)send{
    if(![self.messageField.text isEqualToString:@""]){
        [[self.db childByAppendingPath:@"users"] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
            for(NSString *key in snapshot.value){
                if([key isEqualToString:self.db.authData.uid]){
                    if([snapshot.value[key] isEqualToString:self.recipientField.text]){
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Messaging Error" message:@"You can't message yourself!" preferredStyle:UIAlertControllerStyleAlert];
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    //This is the current user
                    NSLog(@"Current user found");
                    continue;
                }
                if([snapshot.value[key] isEqualToString:self.recipientField.text]){
                    NSLog(@"Recipient found");
                    [[self.db childByAppendingPath:[NSString stringWithFormat:@"conversations/%@/%@", key, self.db.authData.uid]] updateChildValues:@{[NSString stringWithFormat:@"%i", (int)NSTimeIntervalSince1970]:self.messageField.text}];
                }
            }
        }];
    }
    else if([self.recipientField.text isEqualToString:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Message Failed to Send" message:@"You must specify a recipient for this message!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
