//
//  SLFTableViewCell.m
//  Selfie
//
//  Created by Jonathan Fox on 4/21/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell
{
    UIImageView * selfyView;
    UILabel * selfyCaption;
    UIImageView * avatarView;
    UILabel * selfyUserID;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        selfyView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 280, 280)];
        selfyView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:selfyView];
        
        selfyCaption = [[UILabel alloc]initWithFrame:CGRectMake(70, 320, 280, 40)];
        selfyCaption.backgroundColor = [UIColor clearColor];
        selfyCaption.textColor = [UIColor whiteColor];
        [self.contentView addSubview:selfyCaption];
        
        avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 320, 40, 40)];
        avatarView.backgroundColor = [UIColor lightGrayColor];
        avatarView.layer.cornerRadius = 20;
        avatarView.layer.masksToBounds = YES;
        [self.contentView addSubview:avatarView];
        
        selfyUserID = [[UILabel alloc]initWithFrame:CGRectMake(20, 360, 100, 40)];
        selfyUserID.backgroundColor = [UIColor clearColor];
        selfyUserID.textColor = [UIColor whiteColor];
 //       selfyUserID.text = @"USER NAME:";
        [self.contentView addSubview:selfyUserID];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSelfyInfo:(PFObject *)selfyInfo
{
    _selfyInfo = selfyInfo;
 
    selfyCaption.text = [selfyInfo objectForKey:@"caption"];

    PFFile *imageFile = [selfyInfo objectForKey:@"images"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        
        selfyView.image = image;
        
    } progressBlock:^(int percentDone){
        
    }];
    
    PFUser * user = [selfyInfo objectForKey:@"parent"];
    
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        PFFile * avatarFile = [object objectForKey:@"avatar"];
        [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
         {
             avatarView.image = [UIImage imageWithData:data];
        }];
    }];
}

@end
