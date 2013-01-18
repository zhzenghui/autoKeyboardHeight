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

- (void)removeRerurnButton:(UIView *)keyboardView
{
    UIButton *doneButton = (UIButton *)[keyboardView viewWithTag:1000];
    if (doneButton) {
        [doneButton removeFromSuperview];   
    }
}
- (void)addReturnKeyButton:(CGRect)doneButtonRect
{
    
    //    http://www.neoos.ch/blog/37-uikeyboardtypenumberpad-and-the-missing-return-key
    // create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = doneButtonRect;
    doneButton.tag = 1000;
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(hiddenKeyBord:) forControlEvents:UIControlEventTouchUpInside];
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        NSLog(@"%@", keyboard);
        // keyboard found, add the button
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
            if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
            {   
                [self removeRerurnButton:keyboard];
                [keyboard addSubview:doneButton];
            }
        } else {
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
                [keyboard addSubview:doneButton];
        }
    }

}

- (void) keyboardWasShown:(NSNotification *) notif{ 
    NSDictionary *info = [notif userInfo]; 
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey]; 
    CGSize keyboardSize = [value CGRectValue].size; 
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216 
    
    CGRect doneButtonRect = CGRectMake(243-16, 174-7, 106, 53);
    if (keyboardSize.height == 252) {
        doneButtonRect = CGRectMake(243-16, 174-7+36, 106, 53); 
    }

    keyboardWasShown = NO;
    self.view.frame = CGRectMake(0, -keyboardSize.height+20, self.view.frame.size.width, self.view.frame.size.height);
    

    [self addReturnKeyButton:doneButtonRect];
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

-(void)dismissKeyboard {
    [messageTextField resignFirstResponder];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self registerForKeyboardNotifications];
    keyboardWasShown = false;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
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
//    [messageTextField resignFirstResponder];
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
