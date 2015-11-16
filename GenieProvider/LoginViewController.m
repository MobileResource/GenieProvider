//
//  LoginViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/20/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "LoginViewController.h"
#import <ECSlidingViewController.h>
#import "UIHelper.h"
#import "Provider.h"
#import "GVUserDefaults+Properties.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the
    [UIHelper buildRoundedViewWithRadius:self.btn_login withRadius:3.0f];
    
    if (![[GVUserDefaults standardUserDefaults].pvId isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"SSID_TO_MAIN_NO_ANIM" sender:nil];
        return;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SSID_TO_MAIN"] || [segue.identifier isEqualToString:@"SSID_TO_MAIN_NO_ANIM"]) {
        ECSlidingViewController *controller = segue.destinationViewController;
        controller.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping;
    }
}

- (IBAction)onClickLogin:(id)sender {
    NSString * email = self.txt_email.text;
    NSString * pwd = self.txt_password.text;
    if ([email isEqualToString:@""]) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Please enter email or phone number" forDelegate:nil];
        return;
    }
    
    if ([pwd isEqualToString:@""]) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Please enter password" forDelegate:nil];
        return;
    }
    
    NSDictionary * dict = @{@"email_phone" : email,
                            @"password" : pwd,
                            @"device_token" : [GVUserDefaults standardUserDefaults].device_token};
    
    [Provider loginWithParameters:dict withSuccessBlock:^(NSDictionary *response) {
        if ([response count] == 0) {
            [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Invalid credential" forDelegate:nil];
        } else {
            [GVUserDefaults standardUserDefaults].pvId = [response objectForKey:@"pv_id"];
            [GVUserDefaults standardUserDefaults].pvName = [response objectForKey:@"pv_name"];
            [GVUserDefaults standardUserDefaults].pvBusinessName = [response objectForKey:@"pv_business_name"];
            [GVUserDefaults standardUserDefaults].pvBusinessAddress = [response objectForKey:@"pv_business_address"];
            [GVUserDefaults standardUserDefaults].pvPostalCode = [response objectForKey:@"pv_postal_code"];
            [GVUserDefaults standardUserDefaults].pvWebSite = [response objectForKey:@"pv_website"];
            [GVUserDefaults standardUserDefaults].pvFbPage = [response objectForKey:@"pv_fb_page"];
            [GVUserDefaults standardUserDefaults].pvUen = [response objectForKey:@"pv_uen"];
            [GVUserDefaults standardUserDefaults].pvImage = [response objectForKey:@"pv_image"];
            [GVUserDefaults standardUserDefaults].pvOverview = [response objectForKey:@"pv_overview"];
            [GVUserDefaults standardUserDefaults].pvPhone = [response objectForKey:@"pv_phone"];
            
            [self performSegueWithIdentifier:@"SSID_TO_MAIN" sender:nil];
        }
    } failure:^(NSError *error) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
    } view:self.view];

}
@end
