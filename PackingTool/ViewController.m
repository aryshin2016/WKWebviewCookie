//
//  ViewController.m
//  SQPackingTool
//
//  Created by if you on 2017/5/4.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIAlertController *alert;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)showMsg:(NSString *)msg delegate: (id)delegate {
    _alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", action);
        [_alert dismissViewControllerAnimated:NO completion:nil];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"no" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@", action);
        [_alert dismissViewControllerAnimated:NO completion:nil];
    }];
    [_alert addAction:action];
    [_alert addAction:action1];
    [self presentViewController:_alert animated:NO completion:^{
        
    }];
    
}


@end
