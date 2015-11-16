//
//  BusinessRegViewController.h
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessRegViewController : UIViewController
@property (nonatomic, strong) NSMutableArray * category;
@property (nonatomic) long other_id;
@property (nonatomic, strong) NSString * other_content;
@property (strong, nonatomic) IBOutlet UITextField *txt_business_name;

@property (strong, nonatomic) IBOutlet UITextField *txt_business_address;
@property (strong, nonatomic) IBOutlet UITextField *txt_postal_code;
@property (strong, nonatomic) IBOutlet UITextField *txt_website;
@property (strong, nonatomic) IBOutlet UITextField *txt_fb_page;
@property (strong, nonatomic) IBOutlet UITextField *txt_business_reg_number;
- (IBAction)onClickNext:(id)sender;

@end
