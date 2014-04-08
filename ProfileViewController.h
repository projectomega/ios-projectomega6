//
//  ProfileViewController.h
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/7/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickLogOut:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *ProfileName;
@property (strong, nonatomic) IBOutlet UIImageView *ProfilePicture;

@end
