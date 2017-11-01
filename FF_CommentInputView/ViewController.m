//
//  ViewController.m
//  FF_CommentInputView
//
//  Created by fanxiaobin on 2017/11/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "ChatInputView.h"
#import <Masonry.h>

@interface ViewController ()

@property  (nonatomic,strong) ChatInputView *commentInputView;

@end

@implementation ViewController

-(ChatInputView *)commentInputView{
    if (_commentInputView == nil) {
        _commentInputView = [[ChatInputView alloc] init];
    }
    return _commentInputView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self removeObserverForKeyboardNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self registerForKeyboardNotifications];
    
    [self.view addSubview:self.commentInputView];
    
    [self.commentInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    ///发送消息请求
    self.commentInputView.sendMessageActionBlock = ^(ChatInputView *aInpntView) {
        
    };
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.commentInputView.textView resignFirstResponder];
}

#pragma mark - UIKeyboard 评论框弹出和下落
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeObserverForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --- 滚动时隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.commentInputView.textView resignFirstResponder];
}

- (void)keyboardWillShown:(NSNotification *)notification{
    
    NSDictionary *dict = [notification userInfo];
    CGSize kbSize = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat keyboardHeight = kbSize.height;
    [_commentInputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-keyboardHeight);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
 
}

- (void)keyboardWillBeHidden:(NSNotification *)notification{
  
    [_commentInputView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
