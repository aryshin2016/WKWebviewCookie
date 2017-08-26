//
//  UIButton+CustomStyle.h
//

#import <Foundation/Foundation.h>

@interface UIButton(CustomStyle)

// for UIControlStateNormal
@property (nonatomic, strong, nullable) NSString *normalTitle;
@property (nonatomic, strong, nullable) UIColor *normalTitleColor;
@property (nonatomic, strong, nullable) UIImage *normalBackgroundImage;
@property (nonatomic, strong, nullable) UIImage *normalImage;

// for UIControlStateHighlighted
@property (nonatomic, strong, nullable) UIColor *highlightedTitleColor;
@property (nonatomic, strong, nullable) UIImage *highlightedBackgroundImage;
@property (nonatomic, strong, nullable) UIColor *highlightedBackgroundColor;

// for UIControlStateSelected
@property (nonatomic, strong, nullable) UIImage *selectedBackgroundImage;
@property (nonatomic, strong, nullable) UIImage *selectedImage;

// 设置titleLabel字体. [UIFont systemFontOfSize: fontSize]
@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) BOOL enableUnderline;

- (void)addTarget:(nullable id)target withAction:(nullable SEL)action;

@end
