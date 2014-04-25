//
//  SLFLogInVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/22/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFLogInVC.h"
#import <Parse/Parse.h>
#import "SLFTableVC.h"

@interface SLFLogInVC () 

@end

@implementation SLFLogInVC
{
    UITextField * userNameLabel;
    UITextField * passwordLabel;
    UIActivityIndicatorView * spinner;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       // UIView * newForm = [[UIView alloc]initWithFrame:self.view.frame];
        
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 50, 200, 100)];
        title.text = @"Selfy";
        title.font = [UIFont fontWithName:@"zapfino" size:25.0];
        
        title.textAlignment = 1;
        [self.view addSubview:title];
        
        userNameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 175, 200, 40)];
        userNameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        userNameLabel.layer.cornerRadius = 6;
        userNameLabel.delegate = self;
        userNameLabel.leftViewMode = UITextFieldViewModeAlways;
        userNameLabel.placeholder = @" Enter User Name here";
        userNameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        userNameLabel.delegate = self;

        [self.view addSubview:userNameLabel];

        passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 250, 200, 40)];
        passwordLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        passwordLabel.layer.cornerRadius = 6;
        passwordLabel.delegate = self;
        passwordLabel.leftViewMode = UITextFieldViewModeAlways;
        passwordLabel.placeholder = @" Enter User Name here";
        passwordLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        passwordLabel.secureTextEntry = YES;
        
        passwordLabel.delegate = self;
        
        [self.view addSubview:passwordLabel];
        
        UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 325, 100, 40)];
        [submitButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
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
    
    userNameLabel.text = nil;
    passwordLabel.text = nil;
    
    [passwordLabel resignFirstResponder];
    [userNameLabel resignFirstResponder];
    
    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 400);
    spinner.hidesWhenStopped = YES;
    [spinner setColor:[UIColor orangeColor]];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    //remove auto caps
    //animate up login form
    
//    userNameLabel.te
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
 
        if (error == nil)
        {
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableVC alloc]initWithStyle:UITableViewStylePlain]];
            
        }else{
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            [spinner removeFromSuperview];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"ERROR" message: errorDescription delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
        }
        

   }];
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
