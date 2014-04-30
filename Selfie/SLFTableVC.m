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

#import <Parse/Parse.h>

@interface SLFTableVC ()

@end

@implementation SLFTableVC
{
    NSArray * selfies;
    SLFSettingsButton * settingsButtonView;
    SLFSettingsVC * settingsVC;
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
    
    settingsButtonView = [[SLFSettingsButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    settingsButtonView.backgroundColor = [UIColor clearColor];
    settingsButtonView.toggledTintColor = [UIColor redColor];
    
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc]initWithCustomView:settingsButtonView];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    [settingsButtonView addTarget:self action:@selector(openSettings) forControlEvents:UIControlEventTouchUpInside];
}

-(void)openSettings
{
    
    [settingsButtonView toggle];
    
    int X = [settingsButtonView isToggled] ? SCREEN_WIDTH - 52:0; //if yes 50, else 0
    
    [UIView animateWithDuration:0.3 delay:0.0 options:
     UIViewAnimationOptionCurveEaseInOut animations:^{
    
        self.navigationController.view.frame = CGRectMake(X, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    } completion:^(BOOL finished) {
        if(![settingsButtonView isToggled])
        {
            [settingsVC.view removeFromSuperview];
        }

    }];
    if([settingsButtonView isToggled])
    {
        if (settingsVC == nil) settingsVC = [[SLFSettingsVC alloc]initWithNibName:nil bundle:nil];
        
        settingsVC.view.frame = CGRectMake(52 - SCREEN_WIDTH, 0, SCREEN_WIDTH-52, SCREEN_HEIGHT);

        [self.navigationController.view addSubview:settingsVC.view];
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
