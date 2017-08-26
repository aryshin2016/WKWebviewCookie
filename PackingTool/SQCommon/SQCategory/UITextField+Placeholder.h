//
//  UITextField+Placeholder.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField(Placeholder)

@property (nonatomic, strong, nullable) UIColor *placeholderTextColor;

// [UIFont systemFontOfSize:]
@property (nonatomic, assign) CGFloat placeholderFontSize;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, assign) NSTextAlignment placeholderTextAlignment;
@property (nonatomic, assign) CGRect placeholderFrame;

// defualt is 5.0
@property (nonatomic, assign) CGFloat textMargin;
@property (nonatomic, copy) NSString *leftImageName;


- (void)setPlaceholder: (NSString * _Nullable)placeholder withColor: (UIColor * _Nonnull)color;

@end

NS_ASSUME_NONNULL_END
