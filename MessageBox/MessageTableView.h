//
//  MessageTableView.h
//  MessageBox
//
//  Created by zeng on 13-1-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageTableViewDelegate <NSObject>

- (void)closeKeyboard;

@end


@interface MessageTableView : UITableView
{
    id <MessageTableViewDelegate> _messageDelegate;
}

@property(nonatomic, retain) id <MessageTableViewDelegate> messageDelegate;
@end
