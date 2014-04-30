//
//  SLFSettingsVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/29/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFSettingsVC.h"

@interface SLFSettingsVC ()

@end

@implementation SLFSettingsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor whiteColor];
        
        UITextField *nameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 150, 200, 40)];
        nameLabel.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        nameLabel.layer.cornerRadius = 6;
        nameLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
        nameLabel.leftViewMode = UITextFieldViewModeAlways;
        nameLabel.placeholder = @"Settings";
        nameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        [self.view addSubview:nameLabel];
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
