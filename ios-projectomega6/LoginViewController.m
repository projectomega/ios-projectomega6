//
//  LoginViewController.m
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/6/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UIView+Toast.h"

@interface LoginViewController ()

NSString *CreateRandomString();

@end

@implementation LoginViewController
const NSUInteger NUMBER_OF_CHARS = 40 ;

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
    self.currentUser = [PFUser currentUser];
    if (self.currentUser)
    {
        NSLog(@"This should never show up if the user is already logged in");
    
    }
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

- (IBAction)onClickSignUp:(id)sender {
    [self performSegueWithIdentifier:@"loginToSignUpSegue" sender:nil];
}

- (IBAction)onClickFbLogin:(id)sender {
    // we only want email permissions
    NSArray *permissions = [NSArray arrayWithObjects:@"email", nil];
    
    // now login with Facebook
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        self.currentUser = user;
        
        if (!self.currentUser) {
            NSLog(@"Couldn't find the user");
            
        } else if (self.currentUser.isNew) {
            // get the user's data from Facebook
            [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *fbUser, NSError *error) {
                // check and see if a user already exists for this email
                PFQuery *query = [PFUser query];
                [query whereKey:@"email" equalTo:fbUser[@"email"]];
                [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                    if(number > 0) {
                        NSLog(@"User already Exist. deleting the facebook account in parse");
                        
                        // delete the user that was created as part of Parse's Facebook login
                        [self.currentUser deleteInBackground];
                        
                        // put the user logged out notification on the wire
                        //[[NSNotificationCenter defaultCenter] postNotificationName:UserLoggedOutNotification object:nil];
                        [[FBSession activeSession] closeAndClearTokenInformation];
                        
                        // toast
                        [self.view makeToast:@"It looks like you already have an account. Sign in and then go to Profile to link to Facebook."
                                    duration:3.0
                                    position:@"center"
                                       title:@"Duplicate accounts detected"];
                    } else {
                        self.currentUser.username = [NSString stringWithFormat:@"%@", fbUser[@"email"]];
                        self.currentUser.email = fbUser[@"email"];
                        self.currentUser.password = CreateRandomString();
                        [self.currentUser setObject:[fbUser objectForKey:@"id"] forKey:@"facebook_id"];
                        [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if(!error){
                                NSLog(@"user updated successfully");
                            }
                        }];
                    }
                }];
            }];
        } else
        {
            NSLog(@"user just logging in");
        }
    }];
    
    
}
- (IBAction)onClickBack:(id)sender {
    [self performSegueWithIdentifier:@"loginToHomeSegue" sender:nil];
}


NSString *CreateRandomString()
{
    static char const possibleChars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    unichar characters[NUMBER_OF_CHARS];
    for( int index=0; index < NUMBER_OF_CHARS; ++index )
    {
        characters[ index ] = possibleChars[arc4random_uniform(sizeof(possibleChars)-1)];
    }
    
    return [ NSString stringWithCharacters:characters length:NUMBER_OF_CHARS ] ;
}

@end
