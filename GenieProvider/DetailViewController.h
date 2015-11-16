//
//  DetailViewController.h
//  GenieProvider
//
//  Created by Goldman on 3/23/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table_view;
@property (strong, nonatomic) IBOutlet UIButton *btn_quote;
@property (strong, nonatomic) IBOutlet UIButton *btn_decline;

@property (strong, nonatomic) NSDictionary * dict;
@property (strong, nonatomic) NSDictionary * content;
- (IBAction)onClickQuote:(id)sender;
- (IBAction)onClickDecline:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *imagesScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageViewer;
@property (strong, nonatomic) IBOutlet UIView *imagesFooterView;

@end
