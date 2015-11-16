//
//  QuoteViewController.h
//  GenieProvider
//
//  Created by Goldman on 3/24/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteViewController : UIViewController

@property (strong, nonatomic) NSDictionary * dict;
@property (strong, nonatomic) IBOutlet UITextView *txt_overview;
@property (strong, nonatomic) IBOutlet UITextView *txt_client_msg;
@property (strong, nonatomic) IBOutlet UITextField *txt_quote_from;
@property (strong, nonatomic) IBOutlet UITextField *txt_quote_to;
- (IBAction)onClickSubmit:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_submit;

@end
