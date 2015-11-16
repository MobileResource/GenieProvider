//
//  SelectSubCategoryViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "SelectSubCategoryViewController.h"
#import "RegisterNavigationController.h"
#import "BusinessRegViewController.h"
#import "UIHelper.h"

@interface SelectSubCategoryViewController ()
@property (nonatomic, strong) NSMutableArray * subArray;
@property (nonatomic, strong) NSMutableDictionary * selectedCategories;
@property (nonatomic) long otherIndex;
@end

@implementation SelectSubCategoryViewController

@synthesize category = _category;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RegisterNavigationController * navController = (RegisterNavigationController*)self.navigationController;
    
    self.subArray = [[NSMutableArray alloc] initWithArray:[navController.pCategories objectForKey:self.category]];
    
    self.otherIndex = -1;
    
    for (NSDictionary * dict in self.subArray) {
        if ([[dict objectForKey:@"name"] isEqualToString:@"Others"]) {
            self.otherIndex = [[dict objectForKey:@"id"] longValue];
            [self.subArray removeObject:dict];
            break;
        }
    }
    
    self.selectedCategories = [NSMutableDictionary dictionary];
    
    [self.tableView reloadData];
    
    UIImageView * check_mark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13.5f, 13.5f)];
    UIImage * img = [UIImage imageNamed:@"check_mark.png"];
    check_mark.image = img;
    check_mark.contentMode = UIViewContentModeScaleAspectFit;
    self.txt_other.rightView = check_mark;
    self.txt_other.rightViewMode = UITextFieldViewModeNever;
    
    [self.txt_other addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)textFieldDidChange:(id)sender{
    NSString * content = self.txt_other.text;
    if ([content isEqualToString:@""]) {
        self.txt_other.rightViewMode = UITextFieldViewModeNever;
    } else {
        self.txt_other.rightViewMode = UITextFieldViewModeAlways;
    }
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
    return [self.subArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subcategoryIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"subcategoryIdentifier"];
    }
    
    NSDictionary * dict = [self.subArray objectAtIndex:indexPath.row];
    
    long value = [[dict objectForKey:@"id"] longValue];
    
    if ([self.selectedCategories objectForKey:[NSString stringWithFormat:@"%ld",value]] != nil) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [dict objectForKey:@"name"];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dict = [self.subArray objectAtIndex:indexPath.row];
    long value = [[dict objectForKey:@"id"] longValue];
    
    if ([self.selectedCategories objectForKey:[NSString stringWithFormat:@"%ld",value]] != nil) {
        [self.selectedCategories removeObjectForKey:[NSString stringWithFormat:@"%ld", value]];
    } else {
        [self.selectedCategories setValue:@"1" forKey:[NSString stringWithFormat:@"%ld", value]];
    }
    [self.tableView reloadData];
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

- (IBAction)onClickNext:(id)sender {
    /*if ([self.selectedCategory isEqualToString:@""]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please selected category" forDelegate:nil];
        return;
    }
    if (self.selectedIndex == -1) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please selected category" forDelegate:nil];
        return;
    }
    
    UITableViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"subCategoryVC"];
    [self.navigationController pushViewController:controller animated:YES];
    */
    
    if ([self.txt_other.text isEqualToString:@""]) {
        if ([self.selectedCategories count] == 0) {
            [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please select at least one category" forDelegate:nil];
            return;
        }
    }
    
    BusinessRegViewController * controller = (BusinessRegViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"regBusinessVC"];
    
    controller.other_id = self.otherIndex;
    controller.other_content = self.txt_other.text;
    controller.category = [[NSMutableArray alloc] initWithArray:[self.selectedCategories allKeys]];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark - Text View delegates

@end
