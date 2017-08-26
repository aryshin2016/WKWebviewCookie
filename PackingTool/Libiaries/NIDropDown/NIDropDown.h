//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIDropDown;
@protocol NIDropDownDelegate<NSObject>
@optional
//- (void) niDropDownDelegateMethod: (NIDropDown *) sender;
- (void)niDropDownDelegateMethod:(NIDropDown *)sender selectIndexPath:(NSIndexPath *)indexPath;
- (void)tableViewDeletePath:(NIDropDown *)sender deleteIndexPath:(NSIndexPath *)indexPath;
@end

@interface NIDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    UIImageView *imgView;
}
@property (nonatomic, weak) id <NIDropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideDropDown;
- (id)showDropDown:(UITextField *)b :(CGFloat *)height :(NSArray *)arr :(NSArray *)imgArr :(NSString *)direction;
@end
