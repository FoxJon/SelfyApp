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
#import "SLFSignInVC.h"
#import "SLFNewNavController.h"

@interface SLFLogInVC () 

@end

@implementation SLFLogInVC
{
    UITextField * userNameLabel;
    UITextField * passwordLabel;
    UIActivityIndicatorView * spinner;
    UIView *newForm;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        newForm = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        [self.view addSubview:newForm];

        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 50, 200, 100)];
        title.text = @"Selfy";
        title.font = [UIFont fontWithName:@"zapfino" size:25.0];
        
        title.textAlignment = 1;
        [newForm addSubview:title];
        
        userNameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 170, 200, 40)];
        userNameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        userNameLabel.layer.cornerRadius = 6;
        userNameLabel.delegate = self;
        userNameLabel.leftViewMode = UITextFieldViewModeAlways;
        userNameLabel.placeholder = @" Enter user name";
        userNameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        userNameLabel.delegate = self;

        [newForm addSubview:userNameLabel];

        passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 220, 200, 40)];
        passwordLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        passwordLabel.layer.cornerRadius = 6;
        passwordLabel.delegate = self;
        passwordLabel.leftViewMode = UITextFieldViewModeAlways;
        passwordLabel.placeholder = @" Enter password";
        passwordLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        passwordLabel.secureTextEntry = YES;
        
        passwordLabel.delegate = self;
        
        [newForm addSubview:passwordLabel];
        
        UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 280, 100, 40)];
        [submitButton setTitle:@"LOG IN" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        submitButton.backgroundColor = [UIColor blueColor];
        submitButton.layer.cornerRadius = 6;
        [newForm addSubview:submitButton];
        
        UIButton *newUserButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 320, 100, 20)];
        [newUserButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        [newUserButton setTitle:@"New User?" forState:UIControlStateNormal];
        [newUserButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
        [newUserButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [newForm addSubview:newUserButton];
    }
    return self;
}
-(void)signIn
{
    NSLog(@"SignIn");
    
    SLFSignInVC * newSignUpVC = [[SLFSignInVC alloc] initWithNibName:nil bundle:nil];
    
    SLFNewNavController * nc = [[SLFNewNavController alloc]initWithRootViewController:newSignUpVC];
//    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:newSignUpVC];

    nc.navigationBar.barTintColor = [UIColor blueColor];
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES
                                          completion:^{
                                              
                                          }];
}
                                                   

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textColor = [UIColor blackColor];
    textField.autocorrectionType = FALSE;
    textField.autocapitalizationType = FALSE;
//    [UIView animateWithDuration:0.2 animations:^{
//        newForm.frame = CGRectMake(0, -80, 320, self.view.frame.size.height);
//    }];
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

- (void)logIn{
    
//    PFUser * user = [PFUser currentUser];
//    
//    user.username = userNameLabel.text;
//    user.password = passwordLabel.text;
//    
//
    
//    userNameLabel.text = nil;
//    passwordLabel.text = nil;
    
//    [passwordLabel resignFirstResponder];
//    [userNameLabel resignFirstResponder];
    
    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 400);
    spinner.hidesWhenStopped = YES;
    [spinner setColor:[UIColor orangeColor]];
    [self.view addSubview:spinner];
    [spinner startAnimating];
      
    [PFUser logInWithUsernameInBackground:userNameLabel.text password:passwordLabel.text
    block:^(PFUser *user, NSError *error) {
        
        NSLog(@"logged in %@", user.username);
        NSLog(@"current user %@", [PFUser currentUser].username);

        
        if (user) {
            self.navigationController.navigationBarHidden = NO;
            self.navigationController.viewControllers = @[[[SLFTableVC alloc]initWithStyle:UITableViewStylePlain]];
        } else {
            NSString * errorDescription = error.userInfo[@"error"];
            
            [spinner removeFromSuperview];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"ERROR" message: errorDescription delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
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
