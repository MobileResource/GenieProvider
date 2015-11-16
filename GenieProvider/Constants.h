//
//  Constants.h
//  GenieProvider
//
//  Created by Goldman on 3/21/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#ifndef GenieProvider_Constants_h
#define GenieProvider_Constants_h

#define AppCachePath [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"AppCache"]

//#define GPWebServiceUrl                  @"http://192.168.1.130/genie/provider_api/"
//#define GPWebServiceDomain               @"http://192.168.1.130/genie/"

#define GPWebServiceUrl                  @"http://genieapp.co/provider_api/"
#define GPWebServiceDomain               @"http://genieapp.co/"

#define GPWebServiceRegister             @"register"
#define GPWebServiceLogin                @"login"
#define GPWebServiceGetRequests          @"get_requests"
#define GPWebServiceDeclineRequest       @"decline_request"
#define GPWebServiceSendResponse         @"send_response"
#define GPWebServiceUpdateProfile        @"update_profile"
#define GPWebServiceChangePassword       @"change_password"
#define GPWebServiceChangeNotification   @"change_notification"
#define GPWebServiceGetMessages          @"get_messages"
#define GPWebServiceSendMessage          @"send_message"
#define GPWebServiceGetRates             @"get_rates"


/*****  Notifications *****/
#define GPNotificationAvatarChanged @"notificationAvatarChanged"
#endif
