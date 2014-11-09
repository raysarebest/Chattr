//
//  HRSignUpViewController.m
//  Chattr
//
//  Created by Michael Hulet on 11/8/14.
//  Copyright (c) 2014 Human Productions. All rights reserved.
//

#import "HRSignUpViewController.h"
#import <Firebase/Firebase.h>
@interface HRSignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (strong, nonatomic) Firebase *db;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
-(IBAction)signUp;
@end
@implementation HRSignUpViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)signUp{
    NSLog(@"Sign Up button pressed");
    if([self.passwordField.text isEqualToString:self.confirmPasswordField.text]){
        NSLog(@"Registering user");
        [self.db createUser:self.emailField.text password:self.passwordField.text withCompletionBlock:^(NSError *error) {
            if(error){
                //An error occurred, and we need to handle it accordingly
                NSLog(@"%@", error);
            }
            else{
                NSLog(@"User registered, authenticating...");
                //User successfully created, now we log them in and let them into the app
                [self.db authUser:self.emailField.text password:self.passwordField.text withCompletionBlock:^(NSError *error, FAuthData *authData){
                    if(error){
                        //Although unlikely, an error occurred, and we need to handle it
                        NSLog(@"User registered, but an authentication error occurred");
                        NSLog(@"%@", error);
                    }
                    else{
                        //User successfully authenticated, we let them into the app
                        NSLog(@"User successfully registered and authenticated");
                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
            }
        }];
    }
    else{
        NSLog(@"Passwords do not match");
    }
}
-(Firebase *)db{
    if(!_db){
        _db = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-2971.firebaseio.com/"];
    }
    return _db;
}
@end
