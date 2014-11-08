//
//  HRLoginViewController.m
//  Chattr
//
//  Created by Michael Hulet on 11/8/14.
//  Copyright (c) 2014 Human Productions. All rights reserved.
//

#import "HRLoginViewController.h"
#import <Firebase/Firebase.h>
@interface HRLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (strong, nonatomic) Firebase *db;
-(IBAction)login;
@end
@implementation HRLoginViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
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
-(IBAction)login{
    [self.db authUser:self.emailLabel.text password:self.passwordLabel.text withCompletionBlock:^(NSError *error, FAuthData *authData){
        if(error){
            //An error occurred, and we need to react accordingly
            NSLog(@"Failure: %@", error);
        }
        else{
            //The user logged in successfully, and we can transition to the list view
            NSLog(@"Success: %@", authData);
        }
    }];
}
-(Firebase *)db{
    if(!_db){
        _db = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-2971.firebaseio.com/"];
    }
    return _db;
}
@end
