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
        _db = [[[Firebase alloc] initWithUrl:@"https://blistering-inferno-2971.firebaseio.com/"] childByAutoId];
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
        
    }
}
@end
