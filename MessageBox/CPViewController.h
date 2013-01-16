//
//  CPViewController.h
//  MessageBox
//
//  Created by zeng on 13-1-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTableView.h"


@interface CPViewController : UIViewController<MessageTableViewDelegate, UITextFieldDelegate>
{
    bool keyboardWasShown;
}
@property (retain, nonatomic) IBOutlet MessageTableView *messageTableView;
@property (retain, nonatomic) IBOutlet UITextField *messageTextField;
- (IBAction)hiddenKeyBord:(id)sender;
@end
