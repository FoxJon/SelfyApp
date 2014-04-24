//
//  SLFSlefyVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/22/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFSelfyVC.h"
#import <Parse/Parse.h>

@interface SLFSelfyVC () <UITextViewDelegate>

@end

@implementation SLFSelfyVC
{
    UIView * newForm;
    UITextView * caption;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        newForm = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:newForm];
        
        
        UIImageView * imageArea = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-140), 20, 280, 280)];
        imageArea.image = [UIImage imageNamed: @"camera.png"];
        imageArea.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        imageArea.contentMode = UIViewContentModeCenter;
        [newForm addSubview:imageArea];
        
        
        caption = [[UITextView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-120), 310, 240, 80)];
        caption.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
        caption.textColor = [UIColor darkGrayColor];
        caption.text = @"Enter Caption Here";
        caption.delegate = self;
        caption.keyboardType = UIKeyboardTypeTwitter;
        
        [newForm addSubview:caption];
        
        
        UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 400, 100, 40)];
        [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(newSelfy)forControlEvents:UIControlEventTouchUpInside];
        submitButton.backgroundColor = [UIColor blueColor];
        submitButton.layer.cornerRadius = 6;
        [newForm addSubview:submitButton];
        
        
        UIButton *CancelButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-50), 450, 100, 40)];
        [CancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
        // [submitButton addTarget:self action:@selector(newUser)forControlEvents:UIControlEventTouchUpInside];
        CancelButton.backgroundColor = [UIColor redColor];
        CancelButton.layer.cornerRadius = 6;
        
        [newForm addSubview:CancelButton];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];

    }
    return self;
}

-(void)tapScreen
{
    [caption resignFirstResponder];
     [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = self.view.frame;
    }];
}

- (BOOL) textView: (UITextView*) textView shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) String
{
    if ([String isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
    newForm.frame = CGRectMake(0, -KB_HEIGHT, 320, self.view.frame.size.height);
    }];
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

- (void)newSelfy  //called when hitting submit button
{
    UIImage *image = [UIImage imageNamed:@"images2"];
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"images2.png" data:imageData];
    
    PFObject *userPhoto = [PFObject objectWithClassName:@"UserSelfy"];
    userPhoto[@"images2"] = @"My Selfy!";
    userPhoto[@"images2"] = imageFile;
    [userPhoto saveInBackground];
    
    
    
    //PFObject class name "UserSelfy"
    //put a png file inside app
    //PFFile
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
