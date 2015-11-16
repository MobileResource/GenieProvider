//
//  Provider.h
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Provider : NSObject

+(void) registerWithParametersWithImage:(NSDictionary *)params
                    imageData : (NSData*) image
               imageDataParam : (NSString *) imageParam
              withSuccessBlock:(void (^) (NSDictionary *response)) success
                       failure:(void (^) (NSError *error)) failure
                          view:(UIView *) view;

+(void) registerWithParameters:(NSDictionary *)params
              withSuccessBlock:(void (^) (NSDictionary *response)) success
                       failure:(void (^) (NSError *error)) failure
                          view:(UIView *) view;

+(void) loginWithParameters:(NSDictionary *)params
              withSuccessBlock:(void (^) (NSDictionary *response)) success
                       failure:(void (^) (NSError *error)) failure
                          view:(UIView *) view;

+(void) getRequestsParameters:(NSDictionary *)params
           withSuccessBlock:(void (^) (NSArray *response)) success
                    failure:(void (^) (NSError *error)) failure
                       view:(UIView *) view;
+(void) declineRequestParameters:(NSDictionary *)params
             withSuccessBlock:(void (^) (NSDictionary *response)) success
                      failure:(void (^) (NSError *error)) failure
                         view:(UIView *) view;
+(void) sendResponseParameters:(NSDictionary *)params
                withSuccessBlock:(void (^) (NSDictionary *response)) success
                         failure:(void (^) (NSError *error)) failure
                            view:(UIView *) view;
+(void) updateProfileParameters:(NSDictionary *)params
              withSuccessBlock:(void (^) (NSDictionary *response)) success
                       failure:(void (^) (NSError *error)) failure
                          view:(UIView *) view;
+(void) updateProfileParametersWithImageData:(NSDictionary *)params
                                  imageData : (NSData*) image
                             imageDataParam : (NSString *) imageParam
               withSuccessBlock:(void (^) (NSDictionary *response)) success
                        failure:(void (^) (NSError *error)) failure
                           view:(UIView *) view;
+(void) changePasswordParameters:(NSDictionary *)params
               withSuccessBlock:(void (^) (NSDictionary *response)) success
                        failure:(void (^) (NSError *error)) failure
                           view:(UIView *) view;
+(void) changeNotificationParameters:(NSDictionary *)params
                withSuccessBlock:(void (^) (NSDictionary *response)) success
                         failure:(void (^) (NSError *error)) failure
                            view:(UIView *) view;

+(void) getMessagesParameters:(NSDictionary *)params
             withSuccessBlock:(void (^) (NSArray *response)) success
                      failure:(void (^) (NSError *error)) failure
                         view:(UIView *) view;

+(void) sendMessageWithParameters:(NSDictionary *)params
             withSuccessBlock:(void (^) (NSDictionary *response)) success
                      failure:(void (^) (NSError *error)) failure
                         view:(UIView *) view;

+(void) getRatesParameters:(NSDictionary *)params
             withSuccessBlock:(void (^) (NSArray *response)) success
                      failure:(void (^) (NSError *error)) failure
                         view:(UIView *) view;

@end
