//
//  MyReviewController.m
//  GenieProvider
//
//  Created by Goldman on 4/29/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "MyReviewController.h"
#import <UIViewController+ECSlidingViewController.h>
#import "Provider.h"
#import "GVUserDefaults+Properties.h"
#import "UIHelper.h"
#import "ReviewTableViewCell.h"

@interface MyReviewController (){
    NSMutableArray * arr_rates;
}

@end

@implementation MyReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arr_rates = [NSMutableArray array];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    [self getRates];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)getRates{
    
    [arr_rates removeAllObjects];
    
    NSDictionary * dict = @{@"pv_id" : [GVUserDefaults standardUserDefaults].pvId};
    [Provider getRatesParameters:dict withSuccessBlock:^(NSArray *response) {
        [arr_rates addObjectsFromArray:response];
        
        if ([arr_rates count] == 0) {
            [self setTitle:@"My Reviews"];
        } else {
            [self setTitle:[NSString stringWithFormat:@"My Reviews ( %ld )", [arr_rates count]]];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
    } view:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (arr_rates == nil) {
        return 0;
    }
    return [arr_rates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewTableViewCell *cell = (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"reviewIdentifier" forIndexPath:indexPath];
    cell.dict = [arr_rates objectAtIndex:indexPath.row];
    [cell configureCell];
    // Configure the cell...
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onClickMenu:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
