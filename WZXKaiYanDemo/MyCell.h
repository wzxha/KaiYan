//
//  myCell.h
//  WZXKaiYanDemo
//
//  Created by wordoor－z on 16/1/25.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell

/**
 *  图片imgView
 */
@property (nonatomic, strong) UIImageView * pictureView;

/**
 *  标题label
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 *  内容Label
 */
@property (nonatomic, strong) UILabel * littleLabel;

/**
 *  遮挡的View
 */
@property (nonatomic, strong) UIView * coverview;

//cell的位移
- (CGFloat)cellOffset;

//设置图片
- (void)setImg:(UIImage *)img;
@end
