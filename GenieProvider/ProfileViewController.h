//
//  ProfileViewController.h
//  GenieProvider
//
//  Created by Goldman on 3/23/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
- (IBAction)onClickMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *main_container;
@property (strong, nonatomic) IBOutlet UIView *overview_container;
@property (strong, nonatomic) UIImage * img;
@property (strong, nonatomic) IBOutlet UIImageView *img_avatar;
@property (strong, nonatomic) IBOutlet UILabel *txt_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_address;
@property (strong, nonatomic) IBOutlet UITextField *txt_number;
@property (strong, nonatomic) IBOutlet UITextView *txt_overview;
@property (strong, nonatomic) IBOutlet UIButton *btn_update;
- (IBAction)onClickUpdate:(id)sender;

@end
