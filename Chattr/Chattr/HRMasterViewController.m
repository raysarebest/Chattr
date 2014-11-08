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
#define HRFirebaseURLString @"https://blistering-inferno-2971.firebaseio.com/"
@interface HRMasterViewController()
@property (strong, nonatomic) Firebase *db;
@property NSMutableArray *objects;
@end
@implementation HRMasterViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //Set up loading view while we determine if the user is logged in
//    UIViewController *overlay = [[UIViewController alloc] init];
//    overlay.view.frame = [UIScreen mainScreen].bounds;
//    overlay.view.alpha = .5;
//    overlay.view.backgroundColor = [UIColor whiteColor];
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] init];
//    spinner.center = overlay.view.center;
//    [self presentViewController:overlay animated:YES completion:nil];
//    [spinner startAnimating];
    NSLog(@"%f, %f, %f, %f", overlay.view.frame.origin.x, overlay.view.frame.origin.y, overlay.view.frame.size.width, overlay.view.frame.size.height);
    [self.db observeAuthEventWithBlock:^(FAuthData *authData) {
        if(authData){
            //We're logged in, set up the list of conversations
        }
        else{
            //Tell them to log in by sending them to the login view
            //[self.navigationController performSegueWithIdentifier:@"login" sender:self.navigationController];
        }
    }];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}
-(void)insertNewObject:(id)sender{
    if(!self.objects){
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
#pragma mark - Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objects.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert){
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
#pragma mark - Object Lazy Instantiation
-(Firebase *)db{
    if(!_db){
        _db = [[Firebase alloc] initWithUrl:HRFirebaseURLString];
    }
    return _db;
}
@end