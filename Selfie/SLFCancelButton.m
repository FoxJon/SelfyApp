//
//  SLFCancelButton.m
//  Selfie
//
//  Created by Jonathan Fox on 4/29/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFCancelButton.h"

@implementation SLFCancelButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    
    
    [[UIColor blueColor] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    
    
//    CGContextMoveToPoint(context, 1, 2);
//    CGContextAddLineToPoint(context, 3, 2);
//    CGContextMoveToPoint(context, 5, 2);
//    CGContextAddLineToPoint(context, 19, 2);
//    
//    CGContextMoveToPoint(context, 1, 10);
//    CGContextAddLineToPoint(context, 3, 10);
//    CGContextMoveToPoint(context, 5, 10);
//    CGContextAddLineToPoint(context, 19, 10);
//    
//    CGContextMoveToPoint(context, 1, 18);
//    CGContextAddLineToPoint(context, 3, 18);
//    CGContextMoveToPoint(context, 5, 18);
//    CGContextAddLineToPoint(context, 19, 18);
//    
//    CGContextStrokePath(context);
    
    
       CGContextMoveToPoint(context, 1, 1);
        CGContextAddLineToPoint(context, 19, 19);
    
        CGContextMoveToPoint(context, 1, 19);
        CGContextAddLineToPoint(context, 19, 1);
    
        CGContextStrokePath(context);
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
