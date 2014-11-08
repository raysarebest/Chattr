//
//  DetailViewController.h
//  Chattr
//
//  Created by Michael Hulet on 11/8/14.
//  Copyright (c) 2014 Human Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

