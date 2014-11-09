//
//  MasterViewController.m
//  Chattr
//
//  Created by Michael Hulet on 11/8/14.
//  Copyright (c) 2014 Human Productions. All rights reserved.
//

#import "HRMasterViewController.h"
#import "HRDetailViewController.h"
#import <Firebase/Firebase.h>
@interface HRMasterViewController()
@property (strong, nonatomic) Firebase *db;
@property (strong, nonatomic) NSMutableArray *conversations;
-(IBAction)logout:(UIBarButtonItem *)sender;
-(IBAction)newConversation:(UIBarButtonItem *)sender;
@end
@implementation HRMasterViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //Set up loading view while we determine if the user is logged in
    CGRect viewport = [UIScreen mainScreen].bounds;
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewport.size.width, viewport.size.height)];
    overlay.frame = [UIScreen mainScreen].bounds;
    overlay.alpha = .75;
    overlay.backgroundColor = [UIColor whiteColor];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = overlay.center;
    [overlay addSubview:spinner];
    [spinner startAnimating];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:overlay];
    [self.db observeAuthEventWithBlock:^(FAuthData *authData){
        if(authData){
            //We're logged in, set up the list of conversations
            [overlay removeFromSuperview];
        }
        else{
            //Tell them to log in by sending them to the login view
            [self.navigationController performSegueWithIdentifier:@"login" sender:self.navigationController];
        }
    }];
}
-(void)insertNewObject:(id)sender{
    if(!self.conversations){
        self.conversations = [[NSMutableArray alloc] init];
    }
    [self.conversations insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.conversations[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
#pragma mark - Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.conversations.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDate *object = self.conversations[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.conversations removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert){
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
#pragma mark - Object Lazy Instantiation
-(Firebase *)db{
    if(!_db){
        _db = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-2971.firebaseio.com/"];
    }
    return _db;
}
-(IBAction)logout:(UIBarButtonItem *)sender{
    [self.db unauth];
    [self.navigationController performSegueWithIdentifier:@"login" sender:self.navigationController];
}
-(IBAction)newConversation:(UIBarButtonItem *)sender{
    [self.conversations insertObject:@"New Chat" atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(NSMutableArray *)conversations{
    if(!_conversations){
        _conversations = [[NSMutableArray alloc] init];
    }
    return _conversations;
}
@end