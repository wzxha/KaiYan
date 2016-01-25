//
//  myCell.m
//  WZXKaiYanDemo
//
//  Created by wordoor－z on 16/1/25.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "MyCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define cellHeight 250
@implementation MyCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //取消选中效果
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        //裁剪看不到的
        self.clipsToBounds = YES;
        
        //pictureView的Y往上加一半cellHeight 高度为2 * cellHeight，这样上下多出一半的cellHeight
        _pictureView = ({
           UIImageView * picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, -cellHeight/2, kWidth, cellHeight * 2)];
            
            picture.contentMode = UIViewContentModeScaleAspectFill;
            
            picture;
        });
        [self.contentView  addSubview:_pictureView];
        
        _coverview = ({
            UIView * coverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, cellHeight)];
            
            coverview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
            
            coverview;
        });
        //[self.contentView addSubview:_coverview];
        
        _titleLabel = ({
           UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cellHeight / 2 - 30, kWidth, 30)];
            
            titleLabel.font = [UIFont boldSystemFontOfSize:16];
            
            titleLabel.textAlignment = NSTextAlignmentCenter;
            
            titleLabel.textColor = [UIColor whiteColor];
            
            titleLabel.text = @"标题";
            
            titleLabel;
        });
        [self.contentView addSubview:_titleLabel];
        
        _littleLabel = ({
          UILabel * littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cellHeight / 2 + 30, kWidth, 30)];
            
            littleLabel.font = [UIFont systemFontOfSize:14];
            
            littleLabel.textAlignment = NSTextAlignmentCenter;
            
            littleLabel.textColor = [UIColor whiteColor];
            
            littleLabel.text = @"xxxxxxxxxxx";
            
            littleLabel;
        
        });
        [self.contentView addSubview:_littleLabel];
        
        
        
    }
    return self;

}

- (CGFloat)cellOffset
{
    /*
     - (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
     将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
     这里用来获取self在window上的位置
     */
    CGRect toWindow = [self convertRect:self.bounds toView:self.window];
    
    //获取父视图的中心
    CGPoint windowCenter = self.superview.center;
    
    //cell在y轴上的位移  CGRectGetMidY之前讲过,获取中心Y值
    CGFloat cellOffsetY = CGRectGetMidY(toWindow) - windowCenter.y;
    
    //位移比例
    CGFloat offsetDig = 2 * cellOffsetY / self.superview.frame.size.height ;
    
    //要补偿的位移
    CGFloat offset =  -offsetDig * cellHeight/2;
    
    //让pictureViewY轴方向位移offset
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0,offset);
    self.pictureView.transform = transY;
    
    return offset;
}

- (void)setImg:(UIImage *)img
{
    self.pictureView.image = img;
}

@end
