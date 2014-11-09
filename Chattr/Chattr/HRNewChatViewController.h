//
//  HRNewChatViewController.h
//  Chattr
//
//  Created by Michael Hulet on 11/9/14.
//  Copyright (c) 2014 Human Productions. All rights reserved.
//

@import UIKit;
@interface HRNewChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSString *currentUser;
@end