//
//  JXTAlertView.m
//  JXTAlertView
//
//  Created by JXT on 16/3/5.
//  Copyright © 2016年 JXT. All rights reserved.
//
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXT_iOS_Demos
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import "JXTAlertView.h"

#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define OnePixel     (1./[UIScreen mainScreen].scale)
#define animateTime  0.35f
#define UIColorFromHEX(hexValue, alphaValue) \
        [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
                        green:((float)((hexValue & 0x00FF00) >> 8))/255.0 \
                         blue:((float)(hexValue & 0x0000FF))/255.0 \
                        alpha:alphaValue]

@interface JXTAlertView ()

@property (nonatomic, assign) BOOL notifiKeyboardHide;

@property (nonatomic, strong) UITextField * inputTextField;  //输入框
@property (nonatomic, strong) UIView * alertBackgroundView;
@property (nonatomic, strong) UIView * operateView; //操作视图

@property (nonatomic, strong) UIButton * reloadImageBtn;

@property (nonatomic, copy) ClickBlock confirmBlock;
@property (nonatomic, copy) ReloadBlock reloadBlock;

@end

@implementation JXTAlertView

+ (JXTAlertView *)sharedAlertView
{
    static dispatch_once_t once;
    static JXTAlertView * _alertView = nil;
    dispatch_once(&once, ^{
        if (_alertView == nil) {
            _alertView = [[self alloc] init];
        }
    });
    return _alertView;
}

#pragma mark - 创建UI
- (void)showAlertViewWithConfirmAction:(ClickBlock)confirmBlock andReloadAction:(ReloadBlock)refreshBlcok
{
    _notifiKeyboardHide = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    /**
     *  背景视图
     */
    _alertBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _alertBackgroundView.backgroundColor = UIColorFromHEX(0x000000, 0.7);
    [[UIApplication sharedApplication].keyWindow addSubview:_alertBackgroundView];
    _alertBackgroundView.alpha = 0;
    [UIView animateWithDuration:animateTime animations:^{
        _alertBackgroundView.alpha = 1;
    }];

    /**
     *  操作区背景
     */
    _operateView = [[UIView alloc] init];
    _operateView.center = CGPointMake(ScreenWidth/2., ScreenHeight/2.);
    _operateView.bounds = CGRectMake(0, 0, ScreenWidth - 32, 208);
    _operateView.backgroundColor = [UIColor whiteColor];
    _operateView.layer.cornerRadius = 6;
    _operateView.clipsToBounds = YES;
    [_alertBackgroundView addSubview:_operateView];
    [self shakeToShow:_operateView];
    
    /**
     *  按钮
     */
    UIButton * cancelBtn = [self createButtonWithFrame:CGRectMake(0, CGRectGetHeight(_operateView.frame) - 48, _operateView.frame.size.width/2., 48) title:@"取消" andAction:@selector(removeAlertView)];
    [cancelBtn setBackgroundImage:[self imageWithColor:UIColorFromHEX(0xffffff, 1) andSize:cancelBtn.bounds.size] forState:UIControlStateNormal];

    
    self.confirmBlock = confirmBlock;
    UIButton * confirmBtn = [self createButtonWithFrame:CGRectMake(_operateView.frame.size.width/2., CGRectGetHeight(_operateView.frame) - 48, _operateView.frame.size.width/2., 48) title:@"确认" andAction:@selector(clickAction:)];
    [confirmBtn setBackgroundImage:[self imageWithColor:UIColorFromHEX(0xffffff, 1) andSize:cancelBtn.bounds.size] forState:UIControlStateNormal];
    
    
    /**
     *  分割线
     */
    UILabel * horLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_operateView.frame) - 48 - OnePixel, _operateView.frame.size.width, OnePixel)];
    horLine.backgroundColor = UIColorFromHEX(0xcccccc, 1);
    [_operateView addSubview:horLine];
    UILabel * verLine = [[UILabel alloc] initWithFrame:CGRectMake(_operateView.frame.size.width/2. - OnePixel/2., CGRectGetHeight(_operateView.frame) - 48 - OnePixel, OnePixel, 48)];
    verLine.backgroundColor = UIColorFromHEX(0xcccccc, 1);
    [_operateView addSubview:verLine];
    
    /**
     *  输入框背景
     */
    UIView * inputBkView = [[UIView alloc] init];
    inputBkView.layer.borderColor = UIColorFromHEX(0xcccccc, 1).CGColor;
    inputBkView.layer.borderWidth = 1;
    inputBkView.bounds = CGRectMake(0, 0, CGRectGetWidth(_operateView.frame) - 64, 48);
    inputBkView.center = CGPointMake(CGRectGetMidX(_operateView.bounds), 32 + 24);
    [_operateView addSubview:inputBkView];
    
    /**
     *  验证码图片按钮
     */
    self.reloadBlock = refreshBlcok;
    _reloadImageBtn = [self createButtonWithFrame:CGRectZero title:nil andAction:@selector(reloadImageAction:)];
    _reloadImageBtn.bounds = CGRectMake(0, 0, 120, 48);
    _reloadImageBtn.center = CGPointMake(CGRectGetMidX(_operateView.bounds), CGRectGetMaxY(inputBkView.frame) + 16 + CGRectGetHeight(_reloadImageBtn.frame)/2.);
    [_reloadImageBtn setBackgroundImage:[VerifyNumberView iniVerifyNumberImage] forState:UIControlStateNormal];
    
    /**
     *  输入框
     */
    _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(16, 0, CGRectGetWidth(inputBkView.bounds) - 32, CGRectGetHeight(inputBkView.bounds))];
    _inputTextField.delegate = self;
    _inputTextField.keyboardType = UIKeyboardTypeDefault;
    _inputTextField.returnKeyType = UIReturnKeyDone;
    _inputTextField.font = [UIFont systemFontOfSize:16];
    _inputTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入图片内容" attributes:@{NSForegroundColorAttributeName:UIColorFromHEX(0xcccccc, 1), NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _inputTextField.textColor = UIColorFromHEX(0x333333, 1);
    _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [inputBkView addSubview:_inputTextField];
}

#pragma mark - 移除视图
- (void)removeAlertView
{
    if ([_inputTextField isFirstResponder]) {
        [_inputTextField resignFirstResponder];
    }
    //退出
    [UIView animateWithDuration:animateTime animations:^{
        _alertBackgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        if (_notifiKeyboardHide) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        }
        
        [self.alertBackgroundView removeFromSuperview];
        self.alertBackgroundView = nil;
        self.operateView = nil;
    }];
}

#pragma mark - 添加验证码图片
- (void)refreshVerifyImage:(UIImage *)verifyImage
{
    [_reloadImageBtn setBackgroundImage:verifyImage forState:UIControlStateNormal];
}

#pragma mark - 创建按钮
- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title andAction:(SEL)action
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitleColor:UIColorFromHEX(0x333333, 1) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [_operateView addSubview:btn];
    
    return btn;
}
- (void)clickAction:(UIButton *)sender
{
    if (self.confirmBlock) {
        self.confirmBlock(_inputTextField.text);
    }
    
    [self removeAlertView];
}
- (void)reloadImageAction:(UIButton *)sender
{
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

#pragma mark - 监听键盘弹起，操作框动画
///键盘弹起，页面动画，监听
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 键盘的frame
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    CGFloat keyboardOriginY = ScreenHeight - keyboardHeight;
    CGFloat operateMaxY = ScreenHeight/2. + _operateView.bounds.size.height/2. + 16;
    //    DLog(@"--- %lf %lf", keyboardOriginY, operateMaxY);
    
    if (operateMaxY >= keyboardOriginY) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = _operateView.frame;
            rect.origin.y = keyboardOriginY - rect.size.height - 16;
            _operateView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
        _notifiKeyboardHide = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    else {
        _notifiKeyboardHide = NO;
    }
}
///键盘收起，页面动画，监听
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect = _operateView.frame;
        rect.origin.y = (ScreenHeight - rect.size.height)/2.;
        _operateView.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 输入框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - 颜色转换为图片
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize
{
    CGRect rect = CGRectMake(0.0f, 0.0f, aSize.width, aSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 弹性震颤动画
- (void)shakeToShow:(UIView *)aView
{
    CAKeyframeAnimation * popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.35;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, /*@0.75f,*/ @0.8f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
//                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [aView.layer addAnimation:popAnimation forKey:nil];
}

@end
