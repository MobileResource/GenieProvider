//
//  GVUserDefaults+Properties.m
//  GameStaker
//
//  Created by Goldman on 2/5/15.
//  Copyright (c) 2015 TS Application Ltd. All rights reserved.
//

#import "GVUserDefaults+Properties.h"

@implementation GVUserDefaults (Properties)

@dynamic pvName;
@dynamic pvId;
@dynamic pvEmail;
@dynamic pvImage;
@dynamic pvBusinessName;
@dynamic pvBusinessAddress;
@dynamic device_token;
@dynamic pvPostalCode;
@dynamic pvWebSite;
@dynamic pvFbPage;
@dynamic pvUen;
@dynamic pvOverview;
@dynamic pvPhone;
@dynamic pvNotification;

- (NSDictionary*) setupDefaults{
    return @{
             @"pvName":@"",
             @"pvId": @"",
             @"pvEmail": @"",
             @"pvImage": @"",
             @"pvBusinessName": @"",
             @"pvBusinessAddress": @"",
             @"device_token":@"",
             @"pvPostalCode":@"",
             @"pvWebSite":@"",
             @"pvFbPage":@"",
             @"pvUen":@"",
             @"pvOverview":@"",
             @"pvPhone":@"",
             @"pvNotification":@"1"
    };
}

@end
