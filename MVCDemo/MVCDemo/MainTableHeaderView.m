/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainTableHeaderView.m
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "MainTableHeaderView.h"

#import "MainModel.h"

@interface MainTableHeaderView ()
@property (nonatomic, strong) UILabel * headerView;
@property (nonatomic, strong) UILabel * titleLabel;
@end


@implementation MainTableHeaderView

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
    [self addSubview:self.headerView];
    [self addSubview:self.titleLabel];
}
- (UILabel *)headerView
{
    if (!_headerView) {
        _headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _headerView.layer.cornerRadius = 30.;
        _headerView.layer.masksToBounds = YES;
        _headerView.backgroundColor = [UIColor lightGrayColor];
        _headerView.text = @" ";
        _headerView.textAlignment = NSTextAlignmentCenter;
        _headerView.font = [UIFont systemFontOfSize:17];
    }
    return _headerView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _titleLabel.backgroundColor = [UIColor lightGrayColor];
        _titleLabel.text = @"      ";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _headerView.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5 - 15);
    
    [_titleLabel sizeToFit];
    _titleLabel.bounds = CGRectMake(0, 0, _titleLabel.bounds.size.width, 20);
    _titleLabel.center = CGPointMake(self.bounds.size.width*0.5, CGRectGetMaxY(_headerView.frame)+_titleLabel.bounds.size.height*0.5+5);
}


#pragma mark - DataSource
- (void)configTableHeaderViewWith:(MainModel *)mainModel
{
    self.headerView.text = mainModel.headUrl;
    self.titleLabel.text = mainModel.nameText;
    
    self.headerView.backgroundColor = [UIColor redColor];
    self.titleLabel.backgroundColor = [UIColor greenColor];
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

@end
