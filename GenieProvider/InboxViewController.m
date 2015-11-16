//
//  InboxViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "InboxViewController.h"
#import "GPMainViewController.h"
#import "GVUserDefaults+Properties.h"
#import "Provider.h"
#import "UIHelper.h"
#import "RequestTableViewCell.h"
#import "UtilitiesHelper.h"
#import "DetailViewController.h"
#import "JSQMessagesViewController.h"
#import "PopupTableController.h"

@interface InboxViewController ()<UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate, PopupTableDelegate>

@property (nonatomic, strong) UIPopoverController *currentPopoverController;
@property (nonatomic, strong) PopupTableController *tablePopupController;

@property (nonatomic, strong) NSMutableArray * rq_array;
@property (nonatomic, strong) NSMutableArray * rq_filtered_array;

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setMenuNavigationItem];
    
    self.rq_array = [NSMutableArray array];
    self.rq_filtered_array = [NSMutableArray array];
    
    self.tableView.tableFooterView = [UIView new];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getRequests];
}

-(void)getRequests{
    
    [self.rq_array removeAllObjects];
    [self.rq_filtered_array removeAllObjects];
    
    NSDictionary * dict = @{@"id" : [GVUserDefaults standardUserDefaults].pvId};
    
    [Provider getRequestsParameters:dict withSuccessBlock:^(NSArray *response) {
        [self.rq_array addObjectsFromArray:response];
        [self.rq_filtered_array addObjectsFromArray:response];
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
    return [self.rq_filtered_array count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary * dict = [self.rq_filtered_array objectAtIndex:indexPath.row];
    DetailViewController * detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detailVC"];
    [detailVC setDict:dict];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestTVC" forIndexPath:indexPath];
    
    NSDictionary * dict = [self.rq_filtered_array objectAtIndex:indexPath.row];
    
    [cell setRq_id:[dict objectForKey:@"rq_id"]];
    [cell setCs_id:[dict objectForKey:@"cs_id"]];
    [cell setStatus:[dict objectForKey:@"status"]];
    NSData * data = [[NSData alloc] init];
    data = [[dict objectForKey:@"rq_content"] dataUsingEncoding:NSUTF8StringEncoding];
    [cell setRq_content:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]];
    
    [cell setRq_content:[UtilitiesHelper convert2Dictionary:[dict objectForKey:@"rq_content"]]];
    
    cell.img_list = [[NSMutableArray alloc] init];
    data = [[dict objectForKey:@"img_list"] dataUsingEncoding:NSUTF8StringEncoding];
    [cell.img_list addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]];
    [cell setCreated_at:[dict objectForKey:@"created_at"]];
    [cell setCs_image:[dict objectForKey:@"cs_image"]];
    [cell setCs_name:[dict objectForKey:@"cs_name"]];
    [cell setCs_email:[dict objectForKey:@"cs_email"]];
    [cell setCs_phone:[dict objectForKey:@"cs_phone"]];
    [cell setCt_id:[dict objectForKey:@"ct_id"]];
    [cell setDelegate:self];
    [cell setTag:indexPath.row + 1000];
    [cell configureCell];
    // Configure the cell...
    
    return cell;
}

- (void)chatAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    NSInteger index = btn.tag - 1000;
    JSQMessagesViewController  *messageVC = [[JSQMessagesViewController alloc] initWithNibName:@"JSQMessagesViewController" bundle:nil];
    
    NSDictionary * dict = [self.rq_array objectAtIndex:index];
    
    [messageVC setDict:dict];
    [self.navigationController pushViewController:messageVC animated:YES];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    /*if ([segue.identifier isEqualToString:@"SSID_FILTER"])
    {
        WYStoryboardPopoverSegue *popoverSegue = (WYStoryboardPopoverSegue *)segue;
        filter_popup = [popoverSegue popoverControllerWithSender:sender
                                                    permittedArrowDirections:WYPopoverArrowDirectionDown
                                                                    animated:YES
                                                                     options:WYPopoverAnimationOptionFadeWithScale];
        filter_popup.delegate = self;
    }*/
}

- (void)showMessagePopupInBarButtonItem:(UIBarButtonItem*)sender {
    if (self.tablePopupController == nil) {
        self.tablePopupController = [[PopupTableController alloc] initWithStyle:UITableViewStylePlain];
        self.tablePopupController.selectByNone = YES;
    }
    
    UINavigationController* popoverNav = [[UINavigationController alloc] initWithRootViewController:self.tablePopupController];
    popoverNav.navigationBarHidden = YES;
    popoverNav.modalPresentationStyle = UIModalPresentationPopover;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        UIPopoverPresentationController *popPC = popoverNav.popoverPresentationController;
        popPC.delegate = self;
    }
    
    UIStoryboardPopoverSegue * segue = [[UIStoryboardPopoverSegue alloc] initWithIdentifier:@"showViewList" source:self destination:popoverNav];
    self.currentPopoverController = segue.popoverController;
    self.currentPopoverController.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    NSArray *msgArray = @[@"All", @"Requests", @"Quotes Submitted", @"Won"];
    self.tablePopupController.itemsForDisplay = msgArray;
    self.tablePopupController.selectedItem = nil;
    
    if (self.tablePopupController.itemsForDisplay.count < 1) {
        return;
    }
    
    self.tablePopupController.popupDelegate = self;
    self.currentPopoverController.popoverContentSize = [self.tablePopupController contentSize];
    
    [self.currentPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp /*| UIPopoverArrowDirectionRight*/  animated:YES];
}

- (IBAction)onClickFilter:(id)sender{
    [self showMessagePopupInBarButtonItem:sender];
}

#pragma mark - Popover

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (void)popupTableController:(PopupTableController *)controller didSelectIndex:(NSInteger)selectedIndex {
    [self.currentPopoverController dismissPopoverAnimated:NO];
    NSString * status = @"";
    [self.rq_filtered_array removeAllObjects];
    if (selectedIndex == 0) {
        [self.rq_filtered_array addObjectsFromArray:self.rq_array];
    } else {
        if (selectedIndex == 1) {
            status = @"request";
        } else if (selectedIndex == 2){
            status = @"quoted";
        } else {
            status = @"won";
        }
        NSPredicate * predicate;
        predicate = [NSPredicate predicateWithFormat:@"SELF.status like %@", status];
        [self.rq_filtered_array addObjectsFromArray:[self.rq_array filteredArrayUsingPredicate:predicate]];
    }
    
    [self.tableView reloadData];

}

@end
