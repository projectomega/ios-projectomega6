//
//  ChangePasswordViewController.h
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/9/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *currentPassword;
@property (strong, nonatomic) IBOutlet UITextField *nPassword;

@property (strong, nonatomic) IBOutlet UITextField *retypeNewPassword;

- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickDone:(id)sender;

@property(nonatomic) int invalidCount;

@end
