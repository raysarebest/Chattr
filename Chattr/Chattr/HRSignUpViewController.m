//
//  HRSignUpViewController.m
//  Chattr
//
//  Created by Michael Hulet on 11/8/14.
//  Copyright (c) 2014 Human Productions. All rights reserved.
//

#import "HRSignUpViewController.h"


@interface HRSignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
-(IBAction)signUp;
@end
@implementation HRSignUpViewController
-(void)viewDidLoad{
    [super viewDidLoad];
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
-(IBAction)signUp{
}
@end
