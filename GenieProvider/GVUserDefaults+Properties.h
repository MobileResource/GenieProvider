//
//  GVUserDefaults+Properties.h
//  GameStaker
//
//  Created by Goldman on 2/5/15.
//  Copyright (c) 2015 TS Application Ltd. All rights reserved.
//

#ifndef GameStaker_GVUserDefaults_Properties_h
#define GameStaker_GVUserDefaults_Properties_h
#import "GVUserDefaults.h"

@interface GVUserDefaults (Properties)

@property (nonatomic, weak) NSString* pvName;
@property (nonatomic, weak) NSString * pvId;
@property (nonatomic, weak) NSString * pvEmail;
@property (nonatomic, weak) NSString * pvImage;
@property (nonatomic, weak) NSString * pvBusinessName;
@property (nonatomic, weak) NSString* pvBusinessAddress;
@property (nonatomic, weak) NSString* device_token;
@property (nonatomic, weak) NSString* pvPostalCode;
@property (nonatomic, weak) NSString* pvWebSite;
@property (nonatomic, weak) NSString* pvFbPage;
@property (nonatomic, weak) NSString* pvUen;
@property (nonatomic, weak) NSString* pvOverview;
@property (nonatomic, weak) NSString* pvPhone;
@property (nonatomic, weak) NSString* pvNotification;
@end

#endif
