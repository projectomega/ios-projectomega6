//
//  ChangePasswordViewController.m
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/9/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import <Parse/Parse.h>

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPassword.delegate = self;
    self.nPassword.delegate = self;
    self.retypeNewPassword.delegate = self;
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser){
        NSLog(@"This Should Never happen");
        [self performSegueWithIdentifier: @"changePasswordToHomeSegue" sender:nil];
    }
    self.invalidCount = 0;
    
    
    
    
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.currentPassword resignFirstResponder];
    [self.nPassword resignFirstResponder];
    [self.retypeNewPassword resignFirstResponder];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if(textField){
        
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickBack:(id)sender {
    [self performSegueWithIdentifier: @"changePasswordToProfileSegue" sender:nil];
    
}

- (IBAction)onClickDone:(id)sender {
    //NSLog(self.currentPassword.text);
    //NSLog(self.nPassword.text);
    //NSLog(self.retypeNewPassword.text);
    PFUser *currentUser = [PFUser currentUser];
    
    if (![self.nPassword.text isEqualToString:self.retypeNewPassword.text])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"New Password" message:@"Passwords Dont Match" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    [PFUser logInWithUsernameInBackground:currentUser.username password:self.currentPassword.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            self.invalidCount = 0;
                                            [PFUser currentUser].password = self.nPassword.text;
                                            [[PFUser currentUser] saveInBackground];
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Saving New Password" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                                            [alert show];
                                            [alert dismissWithClickedButtonIndex:0 animated:YES];
                                            [self performSegueWithIdentifier:@"changePasswordToProfileSegue" sender:nil];
                                            //[self dismissViewControllerAnimated:YES completion:NULL];
                                            
                                        } else {
                                            self.invalidCount++;
                                            if(self.invalidCount < 4)
                                            {
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to Login" message:@"Invalid Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                            [alert show];
                                            }
                                            else{
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Password" message:@"Logging Out" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                                                [alert show];
                                                [alert dismissWithClickedButtonIndex:0 animated:YES];
                                                [PFUser logOut];
                                                [self performSegueWithIdentifier:@"changePasswordToHomeSegue" sender:nil];
                                            }
                                            
                                        }
                                    }];
    
    
    }
    
}
@end
