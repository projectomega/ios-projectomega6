//
//  SignUpViewController.m
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/5/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser)
    {
        NSLog(@"This should never show up if the user is already logged in");
        [self performSegueWithIdentifier: @"signUpToHomeSegue" sender:nil];
    }
    
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
    [self performSegueWithIdentifier:@"signUpToLoginSegue" sender:nil];
}
- (IBAction)onClickSignedUp:(id)sender {
    [self performSegueWithIdentifier:@"signUpToLoginSegue" sender:nil];
}
@end
