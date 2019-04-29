//
//  HomeHotCollectionViewCell.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/20.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "HomeHotCollectionViewCell.h"

@implementation HomeHotCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self = [[NSBundle mainBundle]loadNibNamed:@"HomeHotCollectionViewCell" owner:self options:nil].lastObject;
//        
//
//    }
//    return self;
//}
#pragma mark — 实现自适应文字宽度的关键步骤:item的layoutAttributes
- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= size.height;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}
@end
