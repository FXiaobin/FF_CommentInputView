//
//  ChatInputView.m
//  WYShareAndLive
//
//  Created by fanxiaobin on 2017/10/20.
//  Copyright © 2017年 乾坤翰林. All rights reserved.
//

#import "ChatInputView.h"
#import <Masonry.h>

@implementation ChatInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(SZTextView *)textView{
    if (_textView == nil) {
        _textView = [[SZTextView alloc] init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.cornerRadius = 4;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.layer.borderColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0].CGColor;
        _textView.layer.borderWidth = 1.0;
        _textView.delegate = self;
        _textView.placeholder = @"想说的话";
        
    }
    return _textView;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [UIColor redColor];
        _sendBtn.layer.cornerRadius = 4.0;
        [_sendBtn addTarget:self action:@selector(sendMessageAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sendBtn;
}


- (void)sendMessageAction:(UIButton *)sender{
    self.textView.text = @"";
    [self.textView resignFirstResponder];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    if (self.sendMessageActionBlock) {
        self.sendMessageActionBlock(self);
    }
}

-(instancetype)init{
    if (self = [super init]) {
        
        [self addSubview:self.textView];
        [self addSubview:self.sendBtn];
        self.backgroundColor = [UIColor orangeColor];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 80));
        }];
        
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textView.mas_right).offset(10);
            make.centerY.equalTo(self.textView);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(40);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChanged:) name:UITextViewTextDidChangeNotification object:self.textView];
    }
    return self;
}


- (void)textViewDidChanged:(NSNotification *)noti{
    CGFloat height = 50.0;
    CGFloat h = [self.textView.text boundingRectWithSize:
                 CGSizeMake(self.bounds.size.width - 90, CGFLOAT_MAX)
                                                 options:
                 NSStringDrawingUsesLineFragmentOrigin |
                 NSStringDrawingUsesFontLeading |
                 NSStringDrawingUsesDeviceMetrics |
                 NSStringDrawingTruncatesLastVisibleLine
                                              attributes:
                 @{NSFontAttributeName : [UIFont systemFontOfSize:14.0]}
                                                 context:nil].size.height;
    
    if (h + 10 > 50) {
        height = h + 10;
    }
    
    if (height > 80.0) {
        height = 80.0;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (self.beginEditBlock) {
        self.beginEditBlock(self,textView);
    }
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


@end
