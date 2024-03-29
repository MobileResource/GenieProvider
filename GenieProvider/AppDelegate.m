//
//  AppDelegate.m
//  GenieProvider
//
//  Created by Goldman on 3/20/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "AppDelegate.h"
#import "UIHelper.h"
#import "OSHelper.h"
#import "GVUserDefaults+Properties.h"
#import "CENotifier.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UITableViewCell appearance] setTintColor:[UIHelper colorWithRGB:233.0f g:33.0f b:71.0f]];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        } else {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
        }
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.jsqController = nil;
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [GVUserDefaults standardUserDefaults].device_token = token;
    NSLog(@"%@", token);
}

-(void) application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    [GVUserDefaults standardUserDefaults].device_token = @"";
}

-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)msg {
    
    NSLog(@"APNS message:%@", msg);
    
    //NSString * data = [[msg objectForKey:@"aps"] objectForKey:@"data"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:msg];
    NSDictionary * data = [dict objectForKey:@"data"];
    
    NSString * type = [NSString stringWithFormat:@"%d", [[data objectForKey:@"type"] intValue]];
    if ([type isEqualToString:@"1"]) {
        //New Request Reached
        [CENotifier displayInView:self.window imageURL:[NSString stringWithFormat:@"%@",[data objectForKey:@"cs_image"]] title:[data objectForKey:@"cs_name"] text:[data objectForKey:@"message"] duration:5.0f userInfo:data delegate:nil];
    } else if ([type isEqualToString:@"2"]){
        //New Chat Arrived
        if (self.jsqController == nil) {
            [CENotifier displayInView:self.window imageURL:[NSString stringWithFormat:@"%@",[data objectForKey:@"cs_image"]] title:[data objectForKey:@"cs_name"] text:[data objectForKey:@"message"] duration:5.0f userInfo:data delegate:nil];
        } else {
            if (![self.jsqController  receiveMessage:data]) {
                [CENotifier displayInView:self.window imageURL:[NSString stringWithFormat:@"%@",[data objectForKey:@"cs_image"]] title:[data objectForKey:@"cs_name"] text:[data objectForKey:@"message"] duration:5.0f userInfo:data delegate:nil];
            }
        }
    } else if ([type isEqualToString:@"3"]){
        [CENotifier displayInView:self.window imageURL:[NSString stringWithFormat:@"%@",[data objectForKey:@"cs_image"]] title:[data objectForKey:@"cs_name"] text:[data objectForKey:@"message"] duration:5.0f userInfo:data delegate:nil];
    }
    
    //NSNumber * type = [dict objectForKey:@"type"];
    
    /*
     [UtilitiesHelper showPromptAlertforTitle:@"Alert"
     withMessage:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
     forDelegate:nil];
     
     NSString * data = [[userInfo objectForKey:@"aps"] objectForKey:@"data"];
     NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[data objectFromJSONString]];
     
     if ([[dict objectForKey:@"type"] isEqualToString:@"1"]) {
     // Receive New Gift
     
     NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:missingNewGiftNotification] == nil ? (NSInteger)0 : [[NSUserDefaults standardUserDefaults] integerForKey:missingNewGiftNotification];
     
     value++;
     
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     [defaults setInteger:value forKey:missingNewGiftNotification];
     [defaults synchronize];
     
     [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidReceiveNewGift object:self];
     }*/
}



@end
