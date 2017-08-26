//
//  NSURL+Common.m
//

#import "NSURL+Common.h"

@implementation NSURL(Common)

- (NSURLRequest *)toRequest {
    
    return [NSURLRequest requestWithURL:self];
}

@end
