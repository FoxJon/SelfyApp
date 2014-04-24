//
//  SLFLogInVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/22/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFLogInVC.h"
#import <Parse/Parse.h>

@interface SLFLogInVC ()

@end

@implementation SLFLogInVC
{
    UITextField * userNameLabel;
    UITextField * passwordLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        userNameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 125, 200, 40)];
        userNameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        userNameLabel.layer.cornerRadius = 6;
        userNameLabel.leftViewMode = UITextFieldViewModeAlways;
        userNameLabel.placeholder = @" Enter User Name here";
        userNameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        userNameLabel.delegate = self;

        [self.view addSubview:userNameLabel];

        passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 200, 200, 40)];
        passwordLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        passwordLabel.layer.cornerRadius = 6;
        passwordLabel.leftViewMode = UITextFieldViewModeAlways;
        passwordLabel.placeholder = @" Enter User Name here";
        passwordLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        passwordLabel.secureTextEntry = YES;
        
        passwordLabel.delegate = self;
        
        [self.view addSubview:passwordLabel];
        
        UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 275, 100, 40)];
        [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
        submitButton.backgroundColor = [UIColor blueColor];
        submitButton.layer.cornerRadius = 6;
        [self.view addSubview:submitButton];

    }
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textColor = [UIColor blackColor];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Enter here";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newUser{
    
    PFUser * user = [PFUser currentUser];
    
    user.username = userNameLabel.text;
    user.password = passwordLabel.text;
    
    NSLog(@"%@", user.username);
    NSLog(@"%@", user.password);

    NSLog(@"clicking");
    
    [user saveInBackground];
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
