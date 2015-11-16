//
//  Provider.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "Provider.h"
#import "Constants.h"
#import "WebClient.h"

@implementation Provider

+(void) registerWithParametersWithImage:(NSDictionary *)params
                    imageData : (NSData*) image
               imageDataParam : (NSString *) imageParam
              withSuccessBlock:(void (^) (NSDictionary *response)) success
                       failure:(void (^) (NSError *error)) failure
                          view:(UIView *) view{
    
    [[WebClient sharedClient] POST:GPWebServiceRegister
                        parameters:params
                  imageDataProfile:image
         imageParamaterNameProfile:imageParam
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Register Response:%@", responseObject);
                                
                                success([responseObject objectForKey:@"result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) registerWithParameters:(NSDictionary *)params
                       withSuccessBlock:(void (^) (NSDictionary *response)) success
                                failure:(void (^) (NSError *error)) failure
                                   view:(UIView *) view{
    
    [[WebClient sharedClient] POST:GPWebServiceRegister
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Register Response:%@", responseObject);
                                
                                success([responseObject objectForKey:@"result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) loginWithParameters:(NSDictionary *)params
           withSuccessBlock:(void (^) (NSDictionary *response)) success
                    failure:(void (^) (NSError *error)) failure
                       view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceLogin
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Login Response:%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) getRequestsParameters:(NSDictionary *)params
             withSuccessBlock:(void (^) (NSArray *response)) success
                      failure:(void (^) (NSError *error)) failure
                         view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceGetRequests
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Get Requests Response:%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
    
}

+(void) declineRequestParameters:(NSDictionary *)params
                withSuccessBlock:(void (^) (NSDictionary *response)) success
                         failure:(void (^) (NSError *error)) failure
                            view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceDeclineRequest
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Decline Request Response:%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) sendResponseParameters:(NSDictionary *)params
              withSuccessBlock:(void (^) (NSDictionary *response)) success
                       failure:(void (^) (NSError *error)) failure
                          view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceSendResponse
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Send Response Result:%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) updateProfileParameters:(NSDictionary *)params
               withSuccessBlock:(void (^) (NSDictionary *response)) success
                        failure:(void (^) (NSError *error)) failure
                           view:(UIView *) view{

    [[WebClient sharedClient] POST:GPWebServiceUpdateProfile
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Update Profile Response :%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) updateProfileParametersWithImageData:(NSDictionary *)params
                                  imageData : (NSData*) image
                             imageDataParam : (NSString *) imageParam
                            withSuccessBlock:(void (^) (NSDictionary *response)) success
                                     failure:(void (^) (NSError *error)) failure
                                        view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceUpdateProfile
                        parameters:params
                  imageDataProfile:image
         imageParamaterNameProfile:imageParam
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Update Profile Response :%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];

}

+(void) changePasswordParameters:(NSDictionary *)params
                withSuccessBlock:(void (^) (NSDictionary *response)) success
                         failure:(void (^) (NSError *error)) failure
                            view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceChangePassword
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Change Password Response :%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) changeNotificationParameters:(NSDictionary *)params
                    withSuccessBlock:(void (^) (NSDictionary *response)) success
                             failure:(void (^) (NSError *error)) failure
                                view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceChangeNotification
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Change Notification Response :%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) getMessagesParameters:(NSDictionary *)params
             withSuccessBlock:(void (^) (NSArray *response)) success
                      failure:(void (^) (NSError *error)) failure
                         view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceGetMessages
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Get Messages Response :%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) sendMessageWithParameters:(NSDictionary *)params
                 withSuccessBlock:(void (^) (NSDictionary *response)) success
                          failure:(void (^) (NSError *error)) failure
                             view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceSendMessage
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Send Message Response :%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

+(void) getRatesParameters:(NSDictionary *)params
          withSuccessBlock:(void (^) (NSArray *response)) success
                   failure:(void (^) (NSError *error)) failure
                      view:(UIView *) view{
    [[WebClient sharedClient] POST:GPWebServiceGetRates
                        parameters:params
                            onView:view success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSLog(@"Get Rates Response :%@", responseObject);
                                
                                success([responseObject objectForKey:@"Result"]);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error);
                            }];
}

@end
