//
//  UIButton+CustomStyle.m
//

#import "UIButton+CustomStyle.h"

static NSString *UIButton_highlightedBackgroundColor = @"UIButton_highlightedBackgroundColor";
static NSString *UIButton_enableUnderline = @"UIButton_enableUnderline";

@implementation UIButton(CustomStyle)

@dynamic normalTitle;
@dynamic normalTitleColor;
@dynamic highlightedTitleColor;
@dynamic normalBackgroundImage;
@dynamic highlightedBackgroundImage;
@dynamic fontSize;
@dynamic normalImage;
@dynamic selectedImage;
@dynamic highlightedBackgroundColor;
@dynamic selectedBackgroundImage;

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
     
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    
    self.layer.cornerRadius = COMMON_RADIUS_CORNER;
    self.normalTitleColor = COMMON_COLOR_TEXT;
    self.titleLabel.font = COMMON_FONT_LARGE;
    self.backgroundColor = COMMON_COLOR_BACKGROUND_BUTTON_NORMAL;
    self.highlightedBackgroundColor = COMMON_COLOR_BACKGROUND_BUTTON_HIGHLIGHTED;
    self.clipsToBounds = YES;
}

- (UIColor *)highlightedBackgroundColor {
    
    return objc_getAssociatedObject(self, &UIButton_highlightedBackgroundColor);
}

- (void)setHighlightedBackgroundColor:(UIColor *)highlightedBackgroundColor {

    objc_setAssociatedObject(self, &UIButton_highlightedBackgroundColor, highlightedBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (bounds.size.width !=0 && bounds.size.height !=0 && self.highlightedBackgroundColor) {} else {
        
        return;
    }
    
    [self setBackgroundImage:[UIImage imageFromColor:self.highlightedBackgroundColor withSize:self.bounds.size] forState:UIControlStateHighlighted];
}

- (void)setNormalTitle:(NSString *)normalTitle {
    
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor {
    
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage {
    
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
}

- (void)setHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage {
    
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage {
    
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}

- (void)setNormalImage:(UIImage *)normalImage {
    
    [self setImage:normalImage forState:UIControlStateNormal];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    
    [self setImage:selectedImage forState:UIControlStateSelected];
}

- (void)setFontSize:(CGFloat)fontSize {
    
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)addTarget:(nullable id)target withAction:(SEL)action {
    
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setEnableUnderline:(BOOL)enableUnderline {
    
    objc_setAssociatedObject(self, &UIButton_enableUnderline, @(enableUnderline), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enableUnderline {
    
    return ((NSNumber *)objc_getAssociatedObject(self, &UIButton_enableUnderline)).boolValue;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef Context = UIGraphicsGetCurrentContext();
    
    if (self.enableUnderline) {
        
        SQLog(@"%@", self.titleLabel.text);
        SQLog(@"%@", NSStringFromCGRect(rect));
        
        CGFloat width = [self.titleLabel.text realWidth:self.titleLabel.font];
        CGFloat height = [self.titleLabel.text realHeight:self.titleLabel.font];
        
        CGFloat originX = (rect.size.width - width)/2.0;
        CGFloat originY = (rect.size.height + height)/2.0 + 1;
        
        CGContextSetLineWidth(Context, 1);
        CGContextSetStrokeColorWithColor(Context, self.titleLabel.textColor.CGColor);
        
        if (self.titleLabel.textAlignment == NSTextAlignmentLeft) {
            
            originX = 0;
        }else if (self.titleLabel.textAlignment == NSTextAlignmentRight) {
            
            originX = rect.size.width - width;
        }
        
        CGContextMoveToPoint(Context, originX, originY);
        CGContextAddLineToPoint(Context, originX+width, originY);
        CGContextStrokePath(Context);
    }
}

@end
