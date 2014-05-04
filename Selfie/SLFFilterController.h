//
//  LPSFilterController.h
//  LibraryPhotoDisplayer
//
//  Created by Jonathan Fox on 5/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLFFilterControllerDelegate;

@interface SLFFilterController : UIViewController

@property (nonatomic, assign) id<SLFFilterControllerDelegate> delegate;

@property (nonatomic) UIImage * imageToFilter;

@end

@protocol SLFFilterControllerDelegate <NSObject>

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image;

@end
