//
//  SelectSubCategoryViewController.h
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectSubCategoryViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *left;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *right;
- (IBAction)onClickNext:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_other;

@property (nonatomic, strong) NSString * category;

@end
