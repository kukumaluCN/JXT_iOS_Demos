/***************************************************************
 //工程名称 : JXTTwinkleStarView
 //文件名称 : JXTTwinkleStarView.h
 //创建时间 : 2017/6/13
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <UIKit/UIKit.h>

/**
 星星视图范围形状

 - JXTTwinkleStarViewShapeRound: 圆形
 - JXTTwinkleStarViewShapeSquare: 方形
 */
typedef NS_ENUM(NSUInteger, JXTTwinkleStarViewShape) {
    JXTTwinkleStarViewShapeRound,
    JXTTwinkleStarViewShapeSquare
};


@interface JXTTwinkleStarView : UIView

/**
 创建星星闪烁视图

 @param frame frame
 @param number 数量（不建议太大，因为不复用，消耗内存的）
 @param shape 外观形状
 @param overflowRadius 圆形溢出半径（JXTTwinkleStarViewShapeSquare设置无效）
 @return 视图
 */
+ (instancetype)twinkleStarViewWithFrame:(CGRect)frame
                                  number:(NSUInteger)number
                                   shape:(JXTTwinkleStarViewShape)shape
                          overflowRadius:(CGFloat)overflowRadius;

@end
