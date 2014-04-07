//
//  ViewController.m
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/3/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    // we use this to set a default background image for the home view
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back3.gif"]];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"I Loaded just fine");
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // We first check to see if the user is already logged in
    
    
}

*/

- (IBAction)onClickUserProfile:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        [self performSegueWithIdentifier:@"homeToProfileSegue" sender:nil];
    }
    else{
        
        [self performSegueWithIdentifier:@"homeToLoginSegue" sender:nil];
    }
}
@end
