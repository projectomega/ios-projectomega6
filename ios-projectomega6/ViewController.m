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
    self.username.delegate = self;
    self.password.delegate = self;
    NSLog(@"I Loaded just fine");
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if(textField){
        
        [textField resignFirstResponder];
    }
    
    return NO;
}

- (IBAction)onClickLogin:(UIButton *)sender {
    //NSLog(self.username.text);
    //NSLog(self.password.text);
    NSLog(@"button pressed");
}
@end
