//
//  SLFSignInVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/28/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFSignInVC.h"
#import "SLFTableVC.h"
#import <Parse/Parse.h>

@interface SLFSignInVC () <UITextFieldDelegate>

@end

@implementation SLFSignInVC

{
    UITextField * userNameLabel;
    UITextField * nameLabel;
    UITextField * passwordLabel;
    UITextField * emailLabel;
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
        
        nameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 150, 200, 40)];
        nameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        nameLabel.layer.cornerRadius = 6;
        nameLabel.delegate = self;
        nameLabel.leftViewMode = UITextFieldViewModeAlways;
        nameLabel.placeholder = @" First and last name";
        nameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        nameLabel.delegate = self;
        
        [newForm addSubview:nameLabel];

        
        userNameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 200, 200, 40)];
        userNameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        userNameLabel.layer.cornerRadius = 6;
        userNameLabel.delegate = self;
        userNameLabel.leftViewMode = UITextFieldViewModeAlways;
        userNameLabel.placeholder = @" Enter user name";
        userNameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        userNameLabel.delegate = self;
        
        [newForm addSubview:userNameLabel];
        
        passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 250, 200, 40)];
        passwordLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        passwordLabel.layer.cornerRadius = 6;
        passwordLabel.delegate = self;
        passwordLabel.leftViewMode = UITextFieldViewModeAlways;
        passwordLabel.placeholder = @" Enter password";
        passwordLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        passwordLabel.secureTextEntry = YES;
        
        passwordLabel.delegate = self;
        
        [newForm addSubview:passwordLabel];
        
        emailLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 300, 200, 40)];
        emailLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        emailLabel.layer.cornerRadius = 6;
        emailLabel.delegate = self;
        emailLabel.leftViewMode = UITextFieldViewModeAlways;
        emailLabel.placeholder = @" Enter email";
        emailLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        emailLabel.keyboardType = UIKeyboardTypeEmailAddress;
        
        emailLabel.delegate = self;
        
        [newForm addSubview:emailLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-30), 350, 60, 60)];
        imageView.image = [UIImage imageNamed: @"BF049b.png"];
        imageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [newForm addSubview:imageView];

        
        UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 420, 100, 40)];
        [submitButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
        submitButton.backgroundColor = [UIColor blueColor];
        submitButton.layer.cornerRadius = 6;
        [newForm addSubview:submitButton];
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem;

        
    }
    return self;
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
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -115, 320, self.view.frame.size.height);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Enter here";
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

- (void)newUser{
    
    PFUser * user = [PFUser currentUser];
    
    user[@"First_Last"] = nameLabel.text;
    user.username = userNameLabel.text;
    user.password = passwordLabel.text;
    user.email = emailLabel.text;
    
    nameLabel.text=nil;
    userNameLabel.text = nil;
    passwordLabel.text = nil;
    emailLabel.text = nil;
    
    [nameLabel resignFirstResponder];
    [userNameLabel resignFirstResponder];
    [passwordLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    
    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 480);
    spinner.hidesWhenStopped = YES;
    [spinner setColor:[UIColor orangeColor]];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
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

@end
