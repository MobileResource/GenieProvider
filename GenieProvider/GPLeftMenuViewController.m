//
//  GPLeftMenuViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "GPLeftMenuViewController.h"
#import <UIViewController+ECSlidingViewController.h>
#import "UIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UtilitiesHelper.h"
#import "GVUserDefaults+Properties.h"
#import "Constants.h"

@interface GPLeftMenuViewController ()

@end

@implementation GPLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    
    [UIHelper buildCircleImageView:self.img_avatar];
    
    [self.img_avatar sd_setImageWithURL:[NSURL URLWithString:[UtilitiesHelper getFullImageURL:[GVUserDefaults standardUserDefaults].pvImage]] placeholderImage:[UIImage imageNamed:@"empty_photo.png"]];
    
    [self.txt_name setText:[GVUserDefaults standardUserDefaults].pvName];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(avatarChanged:) name:GPNotificationAvatarChanged object:nil];
}

- (void)avatarChanged:(NSNotification*)userInfo{
        [self.img_avatar sd_setImageWithURL:[NSURL URLWithString:[UtilitiesHelper getFullImageURL:[GVUserDefaults standardUserDefaults].pvImage]] placeholderImage:[UIImage imageNamed:@"empty_photo.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 5) {
        //Sign out
        [GVUserDefaults standardUserDefaults].pvId = @"";
        [self.slidingViewController.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [UIHelper colorWithRGBAndAlpha:233.0f g:33.0f b:71.0f alpha:0.3f];
    
    // Configure the cell...
    
    return cell;
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

@end
