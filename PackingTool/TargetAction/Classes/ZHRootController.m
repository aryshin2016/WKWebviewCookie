//
//  ZHRootController.m
//  BaiSiJie
//
//  Created by aryshin2016 on 16/9/17.
//  Copyright © 2016年 aryshin2016. All rights reserved.
//

#import "ZHRootController.h"

#import "ZHBSNavController.h"

#import "ZHEssenceViewController.h"
#import "ZHMeViewController.h"
#import "ZHFriendTrendController.h"
#import "ZHNewViewController.h"

#import "UIImage+ZH.h"

@interface ZHRootController ()

@end

@implementation ZHRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.设置tabbarItem的统一外观
    UITabBarItem *item = [UITabBarItem appearance];
    //
    NSMutableDictionary *norAtt = [NSMutableDictionary dictionary];
    norAtt[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    norAtt[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:norAtt forState:UIControlStateNormal];
    //
    NSMutableDictionary *selAtt = [NSMutableDictionary dictionary];
    selAtt[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    selAtt[NSForegroundColorAttributeName] = [UIColor darkTextColor];
    [item setTitleTextAttributes:selAtt forState:UIControlStateSelected];
    
    // 2.添加子控制器
    ZHEssenceViewController *essense = [[ZHEssenceViewController alloc] initWithStyle:UITableViewStylePlain];
    [self setUpOneChildController:essense withImageName:@"tabBar_essence_icon" andSelName:@"tabBar_essence_click_icon" andTitle:@"精华"];
    
    ZHNewViewController *new = [[ZHNewViewController alloc] initWithStyle:UITableViewStylePlain];
    [self setUpOneChildController:new withImageName:@"tabBar_new_icon" andSelName:@"tabBar_new_click_icon" andTitle:@"新帖"];
    
    ZHFriendTrendController *friend = [[ZHFriendTrendController alloc] initWithStyle:UITableViewStylePlain];
    [self setUpOneChildController:friend withImageName:@"tabBar_friendTrends_icon" andSelName:@"tabBar_friendTrends_click_icon" andTitle:@"关注"];
    
    ZHMeViewController *me = [[ZHMeViewController alloc] initWithStyle:UITableViewStylePlain];
    [self setUpOneChildController:me withImageName:@"tabBar_me_icon" andSelName:@"tabBar_me_click_icon" andTitle:@"我"];
}

#pragma mark - 内部控制方法
- (void)setUpOneChildController:(UIViewController *)viewContro withImageName:(NSString *)norName andSelName:(NSString *)selName andTitle:(NSString *)title {
    //
    ZHBSNavController *nav = [[ZHBSNavController alloc]initWithRootViewController:viewContro];
    nav.tabBarItem.title = title;
    [nav.tabBarItem setImage:[UIImage imageNamed:norName]];
    [nav.tabBarItem setSelectedImage:[UIImage zh_originalImageWithName:selName]];
    [self addChildViewController:nav];
}

/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
