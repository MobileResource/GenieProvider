//
//  BusinessRegViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "BusinessRegViewController.h"
#import "PersonalRegViewController.h"
#import "UtilitiesHelper.h"
#import "UIHelper.h"

@interface BusinessRegViewController ()

@end

@implementation BusinessRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString * business_name = self.txt_business_name.text;
    NSString * business_address = self.txt_business_address.text;
    NSString * postal_code = self.txt_postal_code.text;
    NSString * website = self.txt_website.text;
    NSString * fb_page = self.txt_fb_page.text;
    NSString * business_reg_number = self.txt_business_reg_number.text;
    
    if ([UtilitiesHelper IsNullOrEmptyString:business_name]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please input business name" forDelegate:nil];
        return;
    }
    
    if ([UtilitiesHelper IsNullOrEmptyString:business_address]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please input business address" forDelegate:nil];
        return;
    }
    
    if ([UtilitiesHelper IsNullOrEmptyString:postal_code]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please input postal code" forDelegate:nil];
        return;
    }
    
    /*if ([UtilitiesHelper IsNullOrEmptyString:website]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please input website" forDelegate:nil];
        return;
    }
    
    if ([UtilitiesHelper IsNullOrEmptyString:fb_page]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please input facebook page" forDelegate:nil];
        return;
    }
    
    if ([UtilitiesHelper IsNullOrEmptyString:business_reg_number]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please input business registration number(UEN)" forDelegate:nil];
        return;
    }*/
    
    PersonalRegViewController * controller = (PersonalRegViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"regPersonVC"];
    
    controller.other_id = self.other_id;
    controller.other_content = self.other_content;
    controller.category = self.category;
    controller.business_reg_number = business_reg_number;
    controller.business_address = business_address;
    controller.business_name = business_name;
    controller.fb_page = fb_page;
    controller.website = website;
    controller.postal_code = postal_code;
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
