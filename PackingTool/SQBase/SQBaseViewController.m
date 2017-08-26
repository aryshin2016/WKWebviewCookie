//
//  SQBaseViewController.m
//  SQPackingTool
//
//  Created by if you on 2017/5/4.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "SQBaseViewController.h"

@interface SQBaseViewController ()

@end

@implementation SQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
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

@end
