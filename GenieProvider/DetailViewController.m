//
//  DetailViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/23/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "DetailViewController.h"
#import "UIHelper.h"
#import "UtilitiesHelper.h"
#import "Provider.h"
#import "UIAlertView+Starlet.h"
#import "QuoteViewController.h"
#import "ScreenHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()
@property (nonatomic, strong) NSArray * key_arr;
@property (nonatomic, strong) NSArray * arr_images;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.content = [UtilitiesHelper convert2Dictionary:[self.dict objectForKey:@"rq_content"]];
    self.key_arr = [self.content allKeys];
    
    [UIHelper buildRoundedViewWithRadius:self.btn_quote withRadius:3.0f];
    [UIHelper buildRoundedViewWithRadius:self.btn_decline withRadius:3.0f];
    
    self.table_view.tableHeaderView = [UIView new];
    self.table_view.tableFooterView = [UIView new];
    
    self.imagesScrollView.delegate = self;
    
    [self.table_view reloadData];

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    NSString * status = [self.dict objectForKey:@"status"];
    
    if ([status isEqualToString:@"request"]) {
        self.btn_decline.hidden = NO;
        self.btn_quote.hidden = NO;
    } else {
        self.btn_decline.hidden = YES;
        self.btn_quote.hidden = YES;
        self.table_view.frame = CGRectMake(self.table_view.frame.origin.x, self.table_view.frame.origin.y, self.view.frame.size.width, self.table_view.frame.size.height);
    }
    
    NSString * img_list = [self.dict objectForKey:@"img_list"];
    NSData * data = [img_list dataUsingEncoding:NSUTF8StringEncoding];
    
    
    if (data != nil) {
        NSError * e;
        self.arr_images = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&e];
        
        if ([self.arr_images count] > 0) {
            [self.imagesScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            CGRect rect = self.imagesScrollView.frame;
            for (int i = 0 ; i < [self.arr_images count]; i++) {
                NSString * image_url = [self.arr_images objectAtIndex:i];
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * rect.size.width, 0, rect.size.width, rect.size.height)];
                imgView.contentMode = UIViewContentModeScaleAspectFit;
                [imgView sd_setImageWithURL:[NSURL URLWithString:[UtilitiesHelper getFullImageURL:image_url]]];
                //                rect.origin.x = ([self.arr_images count] - 1) * (rect.size.width);
                //                rect.origin.y = 0;
                //                [imgView setFrame:rect];
                [self.imagesScrollView addSubview:imgView];
                
            }
            
            [self.imagesScrollView setContentSize:CGSizeMake((rect.size.width) *[self.arr_images count], 230)];
            //[self.imagesScrollView scrollRectToVisible:rect animated:YES];
            [self.pageViewer setNumberOfPages:[self.arr_images count]];
            
            self.table_view.tableFooterView = self.imagesFooterView;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = scrollView.frame;
    NSInteger nIndex = floor(scrollView.contentOffset.x / frame.size.width);
    self.pageViewer.currentPage = nIndex;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.key_arr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSString * key = [self.key_arr objectAtIndex:section];
    
    NSArray * value_arr = [self.content objectForKey:key];
    
    return [value_arr count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.key_arr objectAtIndex:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerTVC" forIndexPath:indexPath];
    NSString * key = [self.key_arr objectAtIndex:indexPath.section];
    NSString * value = [[self.content objectForKey:key] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"         %@", value];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"SSID_TO_QUOTE"]) {
        QuoteViewController * controller = (QuoteViewController*)segue.destinationViewController;
        controller.dict = self.dict;
    }
    
}

- (IBAction)onClickQuote:(id)sender {
    
}

- (IBAction)onClickDecline:(id)sender {
    [UIAlertView showAlertMessage:@"Are you sure to decline request?" complete:^(NSInteger buttonIndex) {
        if (buttonIndex == OKButton){
            NSDictionary * dict = @{@"rq_id": [self.dict objectForKey:@"rq_id"],
                                    @"pv_id": [self.dict objectForKey:@"pv_id"]};
            [Provider declineRequestParameters:dict withSuccessBlock:^(NSDictionary *response) {
                [UIAlertView showMessage:@"Declined Successfully!" complete:^(NSInteger buttonIndex) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } failure:^(NSError *error) {
                [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
            } view:self.view];
        }
    }];
    
    
}
@end
