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
    UIImageView *avatar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    newForm = [[UIView alloc] initWithFrame:CGRectMake(0, -50, 320, self.view.frame.size.height)];
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
    nameLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    nameLabel.leftViewMode = UITextFieldViewModeAlways;
    nameLabel.placeholder = @" First and last name";
    nameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    nameLabel.delegate = self;
    
    [newForm addSubview:nameLabel];
    
    
    userNameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 200, 200, 40)];
    userNameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    userNameLabel.layer.cornerRadius = 6;
    userNameLabel.delegate = self;
    userNameLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    userNameLabel.leftViewMode = UITextFieldViewModeAlways;
    userNameLabel.placeholder = @" Enter user name";
    userNameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    userNameLabel.delegate = self;
    
    [newForm addSubview:userNameLabel];
    
    passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 250, 200, 40)];
    passwordLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    passwordLabel.layer.cornerRadius = 6;
    passwordLabel.delegate = self;
    passwordLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
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
    emailLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    emailLabel.leftViewMode = UITextFieldViewModeAlways;
    emailLabel.placeholder = @" Enter email";
    emailLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    emailLabel.keyboardType = UIKeyboardTypeEmailAddress;
    
    emailLabel.delegate = self;
    
    [newForm addSubview:emailLabel];
    
    avatar = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-30), 350, 60, 60)];
    avatar.image = [UIImage imageNamed: @"BF049b.png"];
    avatar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    avatar.contentMode = UIViewContentModeScaleAspectFit;
    [newForm addSubview:avatar];
    
    
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 420, 100, 40)];
    [submitButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor = [UIColor blueColor];
    submitButton.layer.cornerRadius = 6;
    [newForm addSubview:submitButton];
    
    
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelLogin)];
    
    cancelNewSelfyButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapScreen
{
    [nameLabel resignFirstResponder];
    [userNameLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    [passwordLabel resignFirstResponder];

    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -50, 320, self.view.frame.size.height);
    }];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = [UIColor blackColor];
    textField.autocorrectionType = FALSE;
    textField.autocapitalizationType = FALSE;
    
    if ([textField.placeholder  isEqual: @" Enter email"]) {
        [UIView animateWithDuration:0.2 animations:^{
            newForm.frame = CGRectMake(0, -200, 320, self.view.frame.size.height);
        }];
    }else{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -115, 320, self.view.frame.size.height);
    }];
  }
    textField.placeholder = @"";

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Enter here";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)cancelLogin
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newUser{
    
    avatar.image = [UIImage imageNamed:@"BF049b"];
    NSData * imageData = UIImagePNGRepresentation(avatar.image);
    PFFile * imageFile = [PFFile fileWithName:@"avatar.png" data:imageData];
    
    PFUser * user = [PFUser user];
    
    user[@"First_Last"] = nameLabel.text;
    user.username = userNameLabel.text;
    user.password = passwordLabel.text;
    user.email = emailLabel.text;
    user[@"avatar"] = imageFile;
    
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
            UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
            
            pnc.navigationBarHidden = NO;
            pnc.viewControllers = @[[[SLFTableVC alloc]initWithStyle:UITableViewStylePlain]];
            
            [self cancelLogin];
            
        }else{
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            [spinner removeFromSuperview];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"ERROR" message: errorDescription delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }
        
        
    }];
}

@end
