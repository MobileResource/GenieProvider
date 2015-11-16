//
//  QuoteViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/24/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "QuoteViewController.h"
#import "UIHelper.h"
#import "GVUserDefaults+Properties.h"
#import "UtilitiesHelper.h"
#import "Provider.h"
#import "UIAlertView+Starlet.h"
#import <IQKeyboardManager.h>
#import "WYPopoverController.h"

@interface QuoteViewController () <WYPopoverControllerDelegate>{
    WYPopoverController * popoverController;
}

@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIHelper buildRoundedViewWithRadius:self.btn_submit withRadius:3.0f];
    self.txt_quote_from.layer.borderColor = [UIHelper colorRefWithRGB:170.0f g:170.0f b:170.0f];
    
    self.txt_quote_to.layer.borderColor = [UIHelper colorRefWithRGB:170.0f g:170.0f b:170.0f];
    
    [self.txt_overview setText:[GVUserDefaults standardUserDefaults].pvOverview];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[[IQKeyboardManager sharedManager] setEnable:YES];
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

- (IBAction)onClickSubmit:(id)sender {
    NSString * cs_msg = self.txt_client_msg.text;
    if ([UtilitiesHelper IsNullOrEmptyString:cs_msg]) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Please enter message for client" forDelegate:nil];
        return;
    }
    NSString * quote_from = self.txt_quote_from.text;
    if ([UtilitiesHelper IsNullOrEmptyString:quote_from]) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Please enter quote" forDelegate:nil];
        return;
    }
    NSString * quote_to = self.txt_quote_to.text;
    if ([UtilitiesHelper IsNullOrEmptyString:quote_to]) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Please enter quote" forDelegate:nil];
        return;
    }
    
    NSString * pv_msg = self.txt_overview.text;
    
    NSDictionary * param = @{@"rq_id" : [self.dict objectForKey:@"rq_id"],
                             @"pv_id" : [GVUserDefaults standardUserDefaults].pvId,
                             @"provider_msg" : pv_msg,
                             @"customer_msg" : cs_msg,
                             @"quote_from" : quote_from,
                             @"quote_to" : quote_to};
    
    [Provider sendResponseParameters:param withSuccessBlock:^(NSDictionary *response) {
        [UIAlertView showMessage:@"Quoted Successfully!" complete:^(NSInteger buttonIndex) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    } failure:^(NSError *error) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
    } view:self.view];
    
}
@end
