//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UITextField *tfSender;
@property(nonatomic, retain) NSMutableArray *list;
@property(nonatomic, retain) NSArray *imageList;
@end

@implementation NIDropDown
@synthesize table;
@synthesize tfSender;
@synthesize list;
@synthesize imageList;
@synthesize delegate;
@synthesize animationDirection;

- (id)showDropDown:(UITextField *)b :(CGFloat *)height :(NSArray *)arr :(NSArray *)imgArr :(NSString *)direction {
    tfSender = b;
    animationDirection = direction;
    self.table = (UITableView *)[super init];
    if (self) {
        // Initialization code
        CGRect btn = b.frame;
        self.list = [NSMutableArray arrayWithArray:arr];
        self.imageList = [NSArray arrayWithArray:imgArr];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, -5);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0);
            self.layer.shadowOffset = CGSizeMake(-5, 5);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
//        table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        table.backgroundColor = [UIColor whiteColor];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y-*height, btn.size.width, *height);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, *height);
        }
        table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        [b.superview addSubview:self];
        [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown{
    [self removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [UIColor orangeColor];
    
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown];
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
//    [btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    tfSender.text = c.textLabel.text;
    

    if ([self.delegate respondsToSelector:@selector(niDropDownDelegateMethod:selectIndexPath:)]) {
        [self.delegate niDropDownDelegateMethod:self selectIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        if ([self.delegate respondsToSelector:@selector(tableViewDeletePath:deleteIndexPath:)])
        {
            // 删除操作
            [tableView beginUpdates];
            [self.delegate tableViewDeletePath:self deleteIndexPath:indexPath];
           [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.list removeObjectAtIndex:indexPath.row];
            [tableView endUpdates];

        }
    }
    
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return@"删除";
    
}



@end
