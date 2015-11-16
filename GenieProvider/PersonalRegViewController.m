//
//  PersonalRegViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "PersonalRegViewController.h"
#import "UIHelper.h"
#import "Provider.h"
#import "UtilitiesHelper.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GVUserDefaults+Properties.h"
#import "UIAlertView+Starlet.h"

@interface PersonalRegViewController ()

@end

@implementation PersonalRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIHelper buildCircleImageView:self.img_avatar];
    
    img = nil;
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped)];
    singleTap.numberOfTapsRequired = 1;
    [self.img_avatar setUserInteractionEnabled:YES];
    [self.img_avatar addGestureRecognizer:singleTap];
}

-(void)singleTapped{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Select image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Album", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickSubmit:(id)sender {
    
    NSString * full_name = self.txt_full_name.text;
    NSString * phone = self.txt_phone.text;
    NSString * email = self.txt_email.text;
    NSString * pwd = self.txt_password.text;
    NSString * pwd_confirm = self.txt_password_confirm.text;
    
    if ([UtilitiesHelper IsNullOrEmptyString:full_name]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please enter full name" forDelegate:nil];
        return;
    }

    if ([UtilitiesHelper IsNullOrEmptyString:phone]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please enter phone number" forDelegate:nil];
        return;
    }

    if ([UtilitiesHelper IsNullOrEmptyString:email]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please enter email" forDelegate:nil];
        return;
    }

    if ([UtilitiesHelper IsNullOrEmptyString:pwd]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Please enter password" forDelegate:nil];
        return;
    }
    
    if (![pwd isEqualToString:pwd_confirm]) {
        [UIHelper showPromptAlertforTitle:@"Warning" withMessage:@"Password does not match" forDelegate:nil];
        return;
    }
    
    NSMutableDictionary * dict_category = [[NSMutableDictionary alloc] init];
    
    for(NSString * ct_id in self.category){
        [dict_category setValue:@"" forKey:ct_id];
    }
    
    if ([UtilitiesHelper IsNullOrEmptyString:self.other_content]) {
        [dict_category setValue:self.other_content forKey:[NSString stringWithFormat:@"%ld", self.other_id]];
    }
    
    NSString * jsonString = @"";
    NSError * error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict_category options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!jsonData) {
        NSLog(@"Got an error : %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSDictionary * dict;
    dict = @{@"name" : full_name,
             @"phone" : phone,
             @"device_token" : [GVUserDefaults standardUserDefaults].device_token,
             @"password" : pwd,
             @"email" : email,
             @"business_name" : self.business_name,
             @"business_address" : self.business_address,
             @"postal_code" : self.postal_code,
             @"website" : self.website,
             @"fb_page" : self.fb_page,
             @"uen" : self.business_reg_number,
             @"overview" : @"",
             @"device_type":  @"ios",
             @"category_id" : jsonString};
    
    if (img == nil) {
        [Provider registerWithParameters:dict withSuccessBlock:^(NSDictionary *response) {
            [GVUserDefaults standardUserDefaults].pvId = [response objectForKey:@"pv_id"];
            [GVUserDefaults standardUserDefaults].pvName = [response objectForKey:@"pv_name"];
            [GVUserDefaults standardUserDefaults].pvBusinessName = [response objectForKey:@"pv_business_name"];
            [GVUserDefaults standardUserDefaults].pvBusinessAddress = [response objectForKey:@"pv_business_address"];
            [GVUserDefaults standardUserDefaults].pvPostalCode = [response objectForKey:@"pv_postal_code"];
            [GVUserDefaults standardUserDefaults].pvWebSite = [response objectForKey:@"pv_website"];
            [GVUserDefaults standardUserDefaults].pvFbPage = [response objectForKey:@"pv_fb_page"];
            [GVUserDefaults standardUserDefaults].pvUen = [response objectForKey:@"pv_uen"];
            [GVUserDefaults standardUserDefaults].pvImage = [response objectForKey:@"pv_image"];
            
            //[UIHelper showPromptAlertforTitle:@"Success" withMessage:@"Registered Successfully!" forDelegate:nil];
            [UIAlertView showMessage:@"Registered Successfully!" complete:^(NSInteger buttonIndex) {
                [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
            }];
            
        } failure:^(NSError *error) {
            [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
        } view:self.view];
    } else {
        NSData * photoData = UIImageJPEGRepresentation(img, 1.0f);
        
        [Provider registerWithParametersWithImage:dict imageData:photoData imageDataParam:@"image" withSuccessBlock:^(NSDictionary *response) {
            [GVUserDefaults standardUserDefaults].pvId = [response objectForKey:@"pv_id"];
            [GVUserDefaults standardUserDefaults].pvName = [response objectForKey:@"pv_name"];
            [GVUserDefaults standardUserDefaults].pvBusinessName = [response objectForKey:@"pv_business_name"];
            [GVUserDefaults standardUserDefaults].pvBusinessAddress = [response objectForKey:@"pv_business_address"];
            [GVUserDefaults standardUserDefaults].pvPostalCode = [response objectForKey:@"pv_postal_code"];
            [GVUserDefaults standardUserDefaults].pvWebSite = [response objectForKey:@"pv_website"];
            [GVUserDefaults standardUserDefaults].pvFbPage = [response objectForKey:@"pv_fb_page"];
            [GVUserDefaults standardUserDefaults].pvUen = [response objectForKey:@"pv_uen"];
            [GVUserDefaults standardUserDefaults].pvImage = [response objectForKey:@"pv_image"];
            [GVUserDefaults standardUserDefaults].pvPhone = [response objectForKey:@"pv_phone"];
            
            [UIAlertView showMessage:@"Registered Successfully!" complete:^(NSInteger buttonIndex) {
                [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
            }];
            
//            [UIHelper showPromptAlertforTitle:@"Success" withMessage:@"Registered Successfully!" forDelegate:nil];
        } failure:^(NSError *error) {
            [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
        } view:self.view];
    }
}

#pragma UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        if ([alertView.title isEqualToString:@"Success"]) {
            
        }
        
    } else if (buttonIndex == 2){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setMediaTypes:[NSArray arrayWithObject:(NSString*)kUTTypeImage]];
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setAllowsEditing:YES];
        [picker setDelegate:self];
        
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    } else if (buttonIndex == 1){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setMediaTypes:[NSArray arrayWithObject:(NSString*)kUTTypeImage]];
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [picker setAllowsEditing:YES];
        [picker setDelegate:self];
        
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

#pragma mark - UIImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        img = [UtilitiesHelper imageWithImage:img scaledToSize:CGSizeMake(200, 200)];
        self.img_avatar.image = img;
    }];
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
