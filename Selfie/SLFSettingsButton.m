//
//  SLFSettingsButton.m
//  Selfie
//
//  Created by Jonathan Fox on 4/29/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFSettingsButton.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(void)toggle
{
    self.toggled = !self.toggled;
    
//    self.toggled = ![self isToggled];
//    [self setToggled:![self isToggled];


}

-(void)setToggled:(BOOL)toggled
{
    _toggled = toggled;
    
    self.alpha = 0.0;
    
    // redraw by calling drawRect
    [self setNeedsDisplay];
    
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:nil];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    [[UIColor blueColor] set];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.6);
//    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextClearRect(context, rect);
    
//    [self.tintColor set];
    
    if([self isToggled])
        
    {
        [self.toggledTintColor set];
        
        CGContextMoveToPoint(context, 1, 1);
        CGContextAddLineToPoint(context, 19, 19);

        CGContextMoveToPoint(context, 1, 19);
        CGContextAddLineToPoint(context, 19, 1);

        CGContextStrokePath(context);
    
    }
    else
    {
        [[UIColor blueColor] set];

        CGContextMoveToPoint(context, 1, 4);
        CGContextAddLineToPoint(context, 3, 4);
        CGContextMoveToPoint(context, 5, 4);
        CGContextAddLineToPoint(context, 19, 4);
        
        CGContextMoveToPoint(context, 1, 10);
        CGContextAddLineToPoint(context, 3, 10);
        CGContextMoveToPoint(context, 5, 10);
        CGContextAddLineToPoint(context, 19, 10);
        
        CGContextMoveToPoint(context, 1, 16);
        CGContextAddLineToPoint(context, 3, 16);
        CGContextMoveToPoint(context, 5, 16);
        CGContextAddLineToPoint(context, 19, 16);
    }
    CGContextStrokePath(context);
}

@end
