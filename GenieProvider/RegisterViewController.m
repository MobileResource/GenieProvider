//
//  RegisterViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/21/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterNavigationController.h"

@interface RegisterViewController ()
@property(nonatomic, strong) RegisterNavigationController * navController;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"regSegue"]) {
        self.navController = [segue destinationViewController];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

- (IBAction)onClickBack:(id)sender {
    
    if ([self.navController popViewControllerAnimated:YES] == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
