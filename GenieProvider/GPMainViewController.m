//
//  GPMainViewController.m
//  GenieProvider
//
//  Created by Goldman on 3/22/15.
//  Copyright (c) 2015 genie. All rights reserved.
//

#import "GPMainViewController.h"
#import <UIViewController+ECSlidingViewController.h>

@interface GPMainViewController ()

@end

@implementation GPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation UIViewController (GPMainViewController)
- (void)setMenuNavigationItem{
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem * menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(gotoMenu:)];
    /*
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_menu"] style:UIBarButtonItemStyleDone target:self action:@selector(gotoMenu:)];
    menuButton.tintColor = [UIColor whiteColor];*/
    
    self.navigationItem.leftBarButtonItem = menuButton;
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
}

-(void)gotoMenu:(id)sender{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
