//
//  SLFAppDelegate.m
//  Selfie
//
//  Created by Jonathan Fox on 4/21/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFAppDelegate.h"
#import "SLFTableVC.h"
#import "SLFLogInVC.h"
#import "SLFSelfyVC.h"

@implementation SLFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
//    [Parse setApplicationId:@"H1JHLiA7kFRmIWvtbkHDcnA1Caj4UofHxRx6UZAB"
//                 clientKey:@"dKLyXccYHUy1MXNgrdR2Sq5b1fNQoTr4clSXVd3p"];
    
    //My app key
    [Parse setApplicationId:@"EA12PN66kpUX1ybbpJ0kNv1HptlccmCkEiH6n67p"
                  clientKey:@"TBuBa4OH6eWgo13rdvK1zF57V9I0NL8nXQRNxpRE"];
    
    [PFUser enableAutomaticUser];
    
    UINavigationController * nc;
    
    PFUser * user = [PFUser currentUser];
    
    NSString * username = user.username;
    
    if (username == nil) {
        nc = [[UINavigationController alloc]initWithRootViewController:[[SLFLogInVC alloc]initWithNibName:nil bundle:nil]];
        nc.navigationBarHidden = YES;

    }else{
        nc = [[UINavigationController alloc]initWithRootViewController:[[SLFTableVC alloc]initWithNibName:nil bundle:nil]];
    }
    

    self.window.rootViewController = nc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
