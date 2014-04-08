//
//  ProfileViewController.m
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/7/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    
    
    
    if(!currentUser){
        
        [NSException raise:NSInvalidArgumentException format:@"user cannot be nil"];
    }
        self.ProfileName.text = currentUser.username;
        
        //self.ProfileTitle.text = name;
        [self.ProfilePicture setContentMode:UIViewContentModeScaleToFill];
        self.ProfilePicture.layer.borderWidth = 0.5f;
        self.ProfilePicture.layer.borderColor = [UIColor blackColor].CGColor;
        self.ProfilePicture.layer.masksToBounds = NO;
        self.ProfilePicture.clipsToBounds = YES;
        self.ProfilePicture.layer.cornerRadius = 35;
    
        /*
        PFImageView * imgView = [[PFImageView alloc] init];
        imgView = [UIImage imageNamed:@"defaultuser.png"]; // placeholder image
        imgView.file = (PFFile *)currentUser[@"displayImage"];
        [imgView loadInBackground];
        [self.ProfilePicture setImage:imgView.image];
        */
        
        PFFile *imgfile = [currentUser objectForKey:@"displayImage"];
        __block UIImage *profilePicture = [[UIImage alloc]init];
        
        [imgfile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
            if(!error)
            {
                NSLog(@"Loaded data");
                profilePicture = [UIImage imageWithData:data];
                //imgView.image = MyPicture;
                //profilePicture = [UIImage imageWithData:data];
                [self.ProfilePicture setImage:profilePicture];
            }
            
            else{
                [self.ProfilePicture setImage:[UIImage imageWithContentsOfFile:@"defaultuser.png"]];
                }
            }];
         
    
    
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
    [self performSegueWithIdentifier:@"profileToHomeSegue" sender:nil];
}

- (IBAction)onClickLogOut:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"profileToHomeSegue" sender:nil];
}
@end
