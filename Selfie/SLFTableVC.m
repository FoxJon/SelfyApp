//
//  SLFTableVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/21/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFTableVC.h"
#import "SLFTableViewCell.h"
#import "SLFSelfyVC.h"
#import "SLFNewNavController.h"
#import "SLFSettingsButton.h"
#import "SLFSettingsVC.h"
#import "SLFCancelButton.h"

#import <Parse/Parse.h>

@interface SLFTableVC ()

@end

@implementation SLFTableVC
{
NSArray * selfies;


}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
//        selfies = @[
//                    @{
                        /*
                        @"image" : @"http://distilleryimage7.ak.instagram.com/6756ea06a44b11e2b62722000a1fbc10_7.jpg",
                        @"caption" : @"This is a selfy!",
                        @"user_id" : @"3n2mb23bnm",
                        @"avatar" : @"https://media.licdn.com/mpr/mpr/shrink_200_200/p/4/005/036/354/393842f.jpg",
                        @"selfy_id" : @"hjk2l32bn1"
                         */
//                    }
//                   ];
//        
//        PFObject *testObject = [PFObject objectWithClassName:@"UserSelfy"];
//        testObject[@"foo"] = @"bar";
//        [testObject saveInBackground];
        
        self.tableView.rowHeight = self.tableView.frame.size.width+100;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem * addNewSelfyButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openNewSelfy)];
    self.navigationItem.rightBarButtonItem = addNewSelfyButton;
    
    
    SLFSettingsButton * settingsView = [[SLFSettingsButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    settingsView.backgroundColor = [UIColor clearColor];
    [settingsView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc]initWithCustomView:settingsView];
    self.navigationItem.leftBarButtonItem = settingsButton;

}
-(void)openSettings
{
    SLFSettingsVC * svc = [[SLFSettingsVC alloc]initWithNibName:nil bundle:nil];
    
    [self.navigationController.view addSubview:svc.view];
    
    svc.view.frame = CGRectMake(-280, 0, 280, self.view.frame.size.height);
    svc.view.backgroundColor = [UIColor lightGrayColor];
    
    if (self.navigationController.view.frame.origin.x < 10) {
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.view.frame = CGRectMake(280, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        SLFCancelButton * cancelView = [[SLFCancelButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        cancelView.backgroundColor = [UIColor clearColor];
        [cancelView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc]initWithCustomView:cancelView];
        self.navigationItem.leftBarButtonItem = settingsButton;
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            }];
        SLFSettingsButton * settingsView = [[SLFSettingsButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        settingsView.backgroundColor = [UIColor clearColor];
        [settingsView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc]initWithCustomView:settingsView];
        self.navigationItem.leftBarButtonItem = settingsButton;
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self refreshSelfies];
}

-(void)openNewSelfy
{
    SLFSelfyVC * newSelfyVC = [[SLFSelfyVC alloc] initWithNibName:nil bundle:nil];
    
   SLFNewNavController * nc = [[SLFNewNavController alloc]initWithRootViewController:newSelfyVC];
    nc.navigationBar.barTintColor = [UIColor blueColor];
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES
 completion:^{
     
 }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selfies count];
}

-(void)refreshSelfies
{
    
    //change order by created date. newest first
    //after user connected to selfy, filter only your user's selfies

    PFQuery *query = [PFQuery queryWithClassName:@"UserSelfy"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"parent" equalTo:[PFUser currentUser]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

    selfies = objects;
        
        [self.tableView reloadData];

    }];
    
    
    [self.tableView reloadData];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SLFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    
    if (cell == nil) cell = [[SLFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.selfyInfo = selfies[indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    
    //[cell setSelfyInfo:selfies[indexPath.row]];   //same as above
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSDictionary * listItem = [self getListItem:indexPath.row];
    
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
