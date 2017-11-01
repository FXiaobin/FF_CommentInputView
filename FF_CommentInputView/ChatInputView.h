//
//  ChatInputView.h
//  WYShareAndLive
//
//  Created by fanxiaobin on 2017/10/20.
//  Copyright © 2017年 乾坤翰林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SZTextView/SZTextView.h>

@interface ChatInputView : UIView<UITextViewDelegate>

@property  (nonatomic,strong) SZTextView *textView;

@property  (nonatomic,strong) UIButton *sendBtn;

@property (nonatomic,copy) void (^sendMessageActionBlock) (ChatInputView *aInpntView);

@property (nonatomic,copy) void (^beginEditBlock) (ChatInputView *aInpntView,UITextView *textView);

@end
