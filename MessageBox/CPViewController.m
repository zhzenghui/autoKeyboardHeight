//
//  CPViewController.m
//  MessageBox
//
//  Created by zeng on 13-1-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CPViewController.h"

@implementation CPViewController
@synthesize messageTableView;
@synthesize messageTextField;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];  ; 

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}


- (void) keyboardWasShown:(NSNotification *) notif{ 
    NSDictionary *info = [notif userInfo]; 
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey]; 
    CGSize keyboardSize = [value CGRectValue].size; 
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216 
    
    int height;
    if (keyboardWasShown == YES) {
        if (keyboardSize.height == 216) {
            height = 252;
        }
        else {
            height = 216;
        }
        self.view.frame = CGRectMake(0, -height+20, self.view.frame.size.width, self.view.frame.size.height);
    }
    else {
        keyboardWasShown = NO;
        self.view.frame = CGRectMake(0, -keyboardSize.height+20, self.view.frame.size.width, self.view.frame.size.height);
    }
} 
- (void) keyboardWasHidden:(NSNotification *) notif{ 
    NSDictionary *info = [notif userInfo]; 
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey]; 
    CGSize keyboardSize = [value CGRectValue].size; 
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height); 
    // keyboardWasShown = NO; 
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    keyboardWasShown = NO;

    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerForKeyboardNotifications];
    keyboardWasShown = false;
}

- (void)viewDidUnload
{
    [self setMessageTextField:nil];
    [self setMessageTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
     [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void)setViewFrame :(CGRect)rect
{
    self.view.frame = rect;
}

#pragma mark message delegate
- (void)closeKeyboard
{
    [messageTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)dealloc {
    [messageTextField release];
    [messageTableView release];
    [super dealloc];
}
- (IBAction)hiddenKeyBord:(id)sender 
{
    [messageTextField resignFirstResponder];
}
@end
