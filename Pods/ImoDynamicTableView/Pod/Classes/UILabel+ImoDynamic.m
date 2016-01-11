//
//  UILabel+ImoDynamic.m
//  Pods
//
//  Created by Borinschi Ivan on 1/14/15.
//
//

#import "UILabel+ImoDynamic.h"

@implementation UILabel (ImoDynamic)

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat availableLabelWidth = self.frame.size.width;
    self.preferredMaxLayoutWidth = availableLabelWidth;
    [super layoutSubviews];
}

@end
