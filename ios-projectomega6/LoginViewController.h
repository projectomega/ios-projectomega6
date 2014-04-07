//
//  LoginViewController.h
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/6/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
- (IBAction)onClickBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)onClicklogin:(id)sender;

- (IBAction)onClickFbLogin:(id)sender;

@end
