//
//  RequestTableViewCell.m
//  GenieProvider
//
//  Created by Goldman on 3/23/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "RequestTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UtilitiesHelper.h"
#import "UIHelper.h"

@implementation RequestTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClickChat:(id)sender {
    if ([_delegate respondsToSelector:@selector(chatAction:)]){
        [sender setTag:self.tag];
        [_delegate performSelector:@selector(chatAction:) withObject:sender];
    }
}

-(void)configureCell{
    [self.customer_name setText:self.cs_name];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    [dateFormatter1 setDateFormat:@"YYYY-MM-dd HH:mm:SS"];
    NSDate *date = [dateFormatter1 dateFromString:self.created_at];
    NSLog(@"date : %@", date);
    
    NSInteger timeDiff = [date timeIntervalSinceNow];
    
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSInteger currentGMToffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtInterval = currentGMToffset - 28800;
    
    timeDiff = 24 - ((timeDiff + gmtInterval)*-1/60/60);
    NSString *strDiff = [NSString stringWithFormat:@"%li", (long)timeDiff];
    strDiff = [strDiff stringByAppendingString:@"Hour(s) left"];
    [self.txt_timer setText:strDiff];
    
    [UIHelper buildCircleImageView:self.customer_image];
    
    if (![UtilitiesHelper IsNullOrEmptyString:self.cs_image]) {
        [self.customer_image sd_setImageWithURL:[NSURL URLWithString:[UtilitiesHelper getFullImageURL:self.cs_image]] placeholderImage:[UIImage imageNamed:@"empty_photo.png"]];
    }
    
    NSString * content = @"";
    
    for (NSString * key in self.rq_content) {
        id value = [self.rq_content objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray * arr = (NSArray*)value;
            NSString * answers = @"";
            for (int i = 0 ; i < [arr count]; i++) {
                if (i != [arr count] - 1) {
                    answers = [answers stringByAppendingString:[arr objectAtIndex:i]];
                    answers = [answers stringByAppendingString:@", "];
                } else {
                    answers = [answers stringByAppendingString:[arr objectAtIndex:i]];
                }
            }
            content = [content stringByAppendingFormat:@"%@\r%@", key, answers];
        } else if ([value isKindOfClass:[NSString class]]){
            content = [content stringByAppendingFormat:@"%@\r%@", key, value];
        }
        
        content = [content stringByAppendingString:@"\r"];
    }
    
    //[self.txt_content setText:content];
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"];
    _ctPlist = [NSDictionary dictionaryWithContentsOfFile:plistPath];

    for (NSDictionary * cat in _ctPlist)
    {
        NSArray *arrayList = [NSArray arrayWithArray:[_ctPlist objectForKey:cat]];
        [arrayList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *tempid = [obj objectForKey:@"id"];
            NSString *ctid = [tempid stringValue];
            if([ctid isEqualToString:self.ct_id]){
                [self.txt_content setText:[obj valueForKey:@"name"]];
            }
        }];

    }
    
    if ([self.status isEqualToString:@"request"] || [self.status isEqualToString:@"decline"]) {
        self.btn_chat.hidden = YES;
    } else {
        self.btn_chat.hidden = NO;
    }
    
    if ([self.status isEqualToString:@"request"]) {
        [self.txt_status setText:@"NEW"];
    } else if ([self.status isEqualToString:@"quoted"]){
        [self.txt_status setText:@"QUOTED"];
    } else if ([self.status isEqualToString:@"decline"]){
        [self.txt_status setText:@"Declined"];
    } else if ([self.status isEqualToString:@"won"]){
        [self.txt_status setText:@"WON"];
    } else {
        [self.txt_status setText:@"NEW"];
    }
}

@end
