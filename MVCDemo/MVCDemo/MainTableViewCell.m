/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainTableViewCell.m
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "MainTableViewCell.h"

#import "MainModel.h"

@implementation MainTableViewCell

#pragma mark - Intial Methods


#pragma mark - UI and Layout


#pragma mark - DataSource
- (void)configTableViewCellWithModel:(id)dataModel
{
    if ([dataModel isKindOfClass:[SubMainModel class]])
    {
        SubMainModel *subModel = (SubMainModel *)dataModel;
        self.textLabel.text = subModel.order.stringValue;
        self.detailTextLabel.text = subModel.title;
    }
    
    //后刷新
    [super configTableViewCellWithModel:dataModel];
}

@end
