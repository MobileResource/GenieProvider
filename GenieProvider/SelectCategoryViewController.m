//
//  SelectCategoryViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "SelectCategoryViewController.h"
#import "RegisterNavigationController.h"
#import "SelectSubCategoryViewController.h"

#import "UIHelper.h"

@interface SelectCategoryViewController ()

@property (nonatomic, strong) NSArray * categoryArray;
@property (nonatomic, strong) NSString * selectedCategory;
@property (nonatomic) long selectedIndex;

@end

@implementation SelectCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RegisterNavigationController * navController = (RegisterNavigationController*)self.navigationController;
    
    self.categoryArray = [navController.pCategories allKeys];
    self.categoryArray = [self.categoryArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.selectedIndex = -1;
    self.selectedCategory = @"";
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.categoryArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Myidentifier = @"categoryIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Myidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Myidentifier];
    }
    
    if (indexPath.row == self.selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [self.categoryArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    self.selectedCategory = [self.categoryArray objectAtIndex:indexPath.row];
    [tableView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickNext:(id)sender {
    if ([self.selectedCategory isEqualToString:@""]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please select category" forDelegate:nil];
        return;
    }
    if (self.selectedIndex == -1) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please select category" forDelegate:nil];
        return;
    }
    
    SelectSubCategoryViewController * controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"subCategoryVC"];
    controller.category = self.selectedCategory;

    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
