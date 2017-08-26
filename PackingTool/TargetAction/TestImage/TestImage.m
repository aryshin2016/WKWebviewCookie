//
//  TestImage.m
//  Pods
//
//  Created by zhouhavey on 2017/5/3.
//
//

#import "TestImage.h"

@implementation TestImage

-(UIImage *)loadPic{
    Class cla = NSClassFromString(@"aryshinKit");
    if (cla ==nil) {
        return nil;
    }else {
        NSBundle *bundle = [NSBundle bundleForClass:cla];
        NSString *file = [bundle pathForResource:@"con60.png" ofType:nil inDirectory:@"aryshinKit.bundle"];
        return [UIImage imageWithContentsOfFile:file];
    }
}

+ (UIImage *)ar_imageNamed:(NSString *)name {
    NSLog(@"%@",name);
    Class cla = NSClassFromString(@"aryshinKit");
    if (cla ==nil) {
        return nil;
    }else {
        NSBundle *bundle = [NSBundle bundleForClass:cla];
        NSString *file = [bundle pathForResource:@"con60.png" ofType:nil inDirectory:@"aryshinKit.bundle"];
        return [UIImage imageWithContentsOfFile:file];
    }
}

@end
