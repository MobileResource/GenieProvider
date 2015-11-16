//
//  LoginViewController.h
//  GenieProvider
//
//  Created by Goldman on 3/20/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
- (IBAction)onClickLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_login;

@end
