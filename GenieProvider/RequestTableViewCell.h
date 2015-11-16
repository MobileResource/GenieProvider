//
//  RequestTableViewCell.h
//  GenieProvider
//
//  Created by Goldman on 3/23/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *customer_image;
@property (strong, nonatomic) IBOutlet UILabel *customer_name;
@property (strong, nonatomic) IBOutlet UILabel *txt_status;
@property (strong, nonatomic) IBOutlet UIButton *btn_chat;
@property (strong, nonatomic) IBOutlet UILabel *txt_content;
@property (strong, nonatomic) IBOutlet UILabel *txt_timer;

@property (strong, nonatomic) NSString * rq_id;
@property (strong, nonatomic) NSString * cs_id;
@property (strong, nonatomic) NSString * status;
@property (strong, nonatomic) NSString * cs_name;
@property (strong, nonatomic) NSDictionary * rq_content;
//@property (nonatomic) int ct_id;
@property (strong, nonatomic) NSString * ct_id;
@property (strong, nonatomic) NSMutableArray * img_list;
@property (strong, nonatomic) NSString * created_at;
@property (strong, nonatomic) NSString * cs_email;
@property (strong, nonatomic) NSString * cs_phone;
@property (strong, nonatomic) NSString * cs_image;

@property(nonatomic,strong) NSDictionary *ctPlist;

@property (nonatomic, strong) id delegate;
- (IBAction)onClickChat:(id)sender;

-(void)configureCell;

@end
