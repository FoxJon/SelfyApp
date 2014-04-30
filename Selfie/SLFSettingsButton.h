//
//  SLFSettingsButton.h
//  Selfie
//
//  Created by Jonathan Fox on 4/29/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFSettingsButton : UIButton

@property (nonatomic, getter = isToggled) BOOL toggled;

@property (nonatomic) UIColor * toggledTintColor;


-(void)toggle;

@end
