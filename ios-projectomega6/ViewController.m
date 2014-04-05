//
//  ViewController.m
//  ios-projectomega6
//
//  Created by Niraj Khandekar on 4/3/14.
//  Copyright (c) 2014 Fenrir Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back2.gif"]];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"I Loaded just fine");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
