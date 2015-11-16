//
//  PersonalRegViewController.h
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalRegViewController : UIViewController<UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIImage *img;
}

- (IBAction)onClickSubmit:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_full_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_phone;
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
@property (strong, nonatomic) IBOutlet UITextField *txt_password_confirm;

@property (nonatomic, strong) NSString* business_name;
@property (nonatomic, strong) NSString* business_address;
@property (nonatomic, strong) NSString* postal_code;
@property (nonatomic, strong) NSString* website;
@property (nonatomic, strong) NSString* fb_page;
@property (nonatomic, strong) NSString* business_reg_number;
@property (nonatomic, strong) NSMutableArray * category;
@property (nonatomic) long other_id;
@property (nonatomic, strong) NSString * other_content;
@property (strong, nonatomic) IBOutlet UIImageView *img_avatar;


@end
