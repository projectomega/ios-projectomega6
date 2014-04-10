//
//  LoginViewController.m
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/6/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController


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
    self.username.delegate = self;
    self.password.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if(textField){
        
        [textField resignFirstResponder];
    }
    
    return YES;
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

- (IBAction)onClicklogin:(id)sender {
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Logging In" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                                            [alert show];
                                            [alert dismissWithClickedButtonIndex:0 animated:YES];
                                            [self dismissViewControllerAnimated:YES completion:NULL];
                                        
                                        } else {
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to Login" message:@"Invalid Username/Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                            [alert show];
                                                }
                                    }];
    
}

- (IBAction)onClickFbLogin:(id)sender {
}
- (IBAction)onClickBack:(id)sender {
    [self performSegueWithIdentifier:@"loginToHomeSegue" sender:nil];
}
@end
