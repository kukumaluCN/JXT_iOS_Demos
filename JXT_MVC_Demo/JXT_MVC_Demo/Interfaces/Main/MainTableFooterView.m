/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainTableFooterView.m
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "MainTableFooterView.h"

@interface MainTableFooterView ()
@property (nonatomic, strong) UIControl * tapControl;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) UILabel *errorLabel;

@property (nonatomic, copy) void(^handlerBlock)();
@end

@implementation MainTableFooterView

#pragma mark - Intial Methods
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createBaseUI];
    }
    return self;
}

#pragma mark - UI and Layout
- (void)createBaseUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIControl *tapControl = [[UIControl alloc] initWithFrame:CGRectZero];
    [tapControl addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    tapControl.enabled = NO;
    [self addSubview:tapControl];
    self.tapControl = tapControl;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [self addSubview:indicator];
    self.indicator = indicator;
    
    UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    errorLabel.text = @"加载失败，请点击屏幕重试";
    errorLabel.font = [UIFont systemFontOfSize:15];
    errorLabel.textColor = [UIColor grayColor];
    errorLabel.hidden = YES;
    errorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:errorLabel];
    self.errorLabel = errorLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tapControl.frame = self.bounds;
    
    _indicator.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    
    _errorLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, 30);
    _errorLabel.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
}


#pragma mark - Target Methods
- (void)tapAction:(UIControl *)aSender
{
    aSender.enabled = NO;
    [self.indicator startAnimating];
    self.errorLabel.hidden = YES;
    
    if (self.handlerBlock) {
        self.handlerBlock();
    }
}

#pragma mark - Public Method
- (void)loadFailureMessage:(NSString *)errorMag andReloadWithHandler:(void(^)())handler
{
    self.tapControl.enabled = YES;
    [self.indicator stopAnimating];
    if (errorMag.length > 0) {
        self.errorLabel.text = errorMag;
    }
    self.errorLabel.hidden = NO;
    
    if (handler) {
        self.handlerBlock = handler;
    }
}
- (void)loadSuccess
{
    self.tapControl.enabled = NO;
    [self.indicator stopAnimating];
    self.errorLabel.hidden = YES;
    self.handlerBlock = nil;
}

#pragma mark - Other
- (void)dealloc
{
    NSLog(@"释放 - %@", [self class]);
}

@end
