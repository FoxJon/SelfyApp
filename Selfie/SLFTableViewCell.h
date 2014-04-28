//
//  SLFTableViewCell.h
//  Selfie
//
//  Created by Jonathan Fox on 4/21/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SLFTableViewCell : UITableViewCell

@property (nonatomic) PFObject * selfyInfo;

@end
