//
//  MessageTableView.m
//  MessageBox
//
//  Created by zeng on 13-1-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MessageTableView.h"

@implementation MessageTableView
@synthesize messageDelegate = _messageDelegate;



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.messageDelegate closeKeyboard];
}
@end
