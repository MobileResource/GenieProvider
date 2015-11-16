//
//  ProfileViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/23/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "ProfileViewController.h"
#import <UIViewController+ECSlidingViewController.h>
#import "GVUserDefaults+Properties.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UtilitiesHelper.h"
#import "UIHelper.h"
#import "Provider.h"
#import "Constants.h"


@interface ProfileViewController ()<UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidShowNotification object:nil];
    
    [self.txt_name setText:[GVUserDefaults standardUserDefaults].pvName];
    [self.txt_number setText:[GVUserDefaults standardUserDefaults].pvPhone];
    [self.txt_overview setText:[GVUserDefaults standardUserDefaults].pvOverview];
    [self.txt_address setText:[GVUserDefaults standardUserDefaults].pvBusinessAddress];
    
    if (![UtilitiesHelper IsNullOrEmptyString:[GVUserDefaults standardUserDefaults].pvImage]) {
        [self.img_avatar sd_setImageWithURL:[NSURL URLWithString:[UtilitiesHelper getFullImageURL:[GVUserDefaults standardUserDefaults].pvImage]] placeholderImage:[UIImage imageNamed:@"empty_photo.png"]];
    }
    
    [UIHelper buildCircleImageView:self.img_avatar];
    
    [UIHelper buildRoundedViewWithRadius:self.btn_update withRadius:3.0f];
    
    self.img = nil;
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped)];
    singleTap.numberOfTapsRequired = 1;
    [self.img_avatar setUserInteractionEnabled:YES];
    [self.img_avatar addGestureRecognizer:singleTap];
}

-(void)singleTapped{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Select image" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Album", nil];
    [alert show];
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
        self.img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        self.img = [UtilitiesHelper imageWithImage:self.img scaledToSize:CGSizeMake(200, 200)];
        self.img_avatar.image = self.img;
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


/*
-(void)keyboardDidShow:(NSNotification*)notification{
    _overview_container.frame = CGRectMake(_overview_container.frame.origin.x, _overview_container.frame.origin.y - 216.0, _overview_container.frame.size.width, _overview_container.frame.size.height);
}

-(void)keyboardDidHide:(NSNotification*)notification{
    _overview_container.frame = CGRectMake(_overview_container.frame.origin.x, _overview_container.frame.origin.y + 216.0, _overview_container.frame.size.width, _overview_container.frame.size.height);
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickMenu:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
- (IBAction)onClickUpdate:(id)sender {
    
    NSString * address = self.txt_address.text;
    NSString * phone = self.txt_number.text;
    NSString * overview = self.txt_overview.text;
    
    if ([UtilitiesHelper IsNullOrEmptyString:address]) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Please enter address" forDelegate:nil];
        return;
    }
    
    if ([UtilitiesHelper IsNullOrEmptyString:phone]) {
        [UIHelper showPromptAlertforTitle:@"Error" withMessage:@"Please enter phone number" forDelegate:nil];
        return;
    }
    
    NSDictionary * dict = @{@"pv_id" : [GVUserDefaults standardUserDefaults].pvId,
                            @"address" : address,
                            @"phone" : phone,
                            @"overview" : overview};
    
    if (self.img == nil) {
        [Provider updateProfileParameters:dict withSuccessBlock:^(NSDictionary *response) {
            
            [GVUserDefaults standardUserDefaults].pvBusinessAddress = address;
            [GVUserDefaults standardUserDefaults].pvPhone = phone;
            [GVUserDefaults standardUserDefaults].pvOverview = overview;

            [UIHelper showPromptAlertforTitle:@"Success" withMessage:@"Updated successfully!" forDelegate:nil];
        } failure:^(NSError *error) {
            [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
        } view:self.view];
    } else{
        NSData * photoData = UIImageJPEGRepresentation(self.img, 1.0f);
        
        [Provider updateProfileParametersWithImageData:dict imageData:photoData imageDataParam:@"image" withSuccessBlock:^(NSDictionary *response) {
            [GVUserDefaults standardUserDefaults].pvBusinessAddress = address;
            [GVUserDefaults standardUserDefaults].pvPhone = phone;
            [GVUserDefaults standardUserDefaults].pvOverview = overview;
            [GVUserDefaults standardUserDefaults].pvImage = [response objectForKey:@"pv_image"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:GPNotificationAvatarChanged object:nil];
            
            [UIHelper showPromptAlertforTitle:@"Success" withMessage:@"Updated successfully!" forDelegate:nil];
        } failure:^(NSError *error) {
            [UIHelper showPromptAlertforTitle:@"Error" withMessage:[error localizedDescription] forDelegate:nil];
        } view:self.view];
    }
}
@end
