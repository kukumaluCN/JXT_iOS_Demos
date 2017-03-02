/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : BaseTableViewCell.m
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

#pragma mark - Intial Methods

#pragma mark - UI and Layout

@end



@implementation BaseTableViewCell (ConfigDataModelForCell)

#pragma mark - Public Methods
- (void)configTableViewCellWithModel:(id)dataModel
{
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

@end
