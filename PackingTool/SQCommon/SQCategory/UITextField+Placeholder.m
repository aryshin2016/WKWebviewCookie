//
//  UITextField+Placeholder.m
//

#import "UITextField+Placeholder.h"
#import "JRSwizzle.h"

static NSString *UITextField_textMargin = @"UITextField_contentLeftMargin";

@implementation UITextField(Placeholder)

@dynamic placeholderTextColor;
@dynamic placeholderFontSize;
@dynamic placeholderTextAlignment;
@dynamic placeholderFrame;
@dynamic placeholderFont;
@dynamic textMargin;
@dynamic leftImageName;

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    self.layer.borderWidth = COMMON_WIDTH_BORDER;
    self.layer.borderColor = COMMON_COLOR_BORDER.CGColor;
    self.layer.cornerRadius = COMMON_RADIUS_CORNER;
    self.font = COMMON_FONT_SMALL;
    self.textColor = COMMON_COLOR_TEXT_INPUT;
    self.placeholderTextColor = COMMON_COLOR_PLACEHOLDER;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
}

- (void)setLeftImageName:(NSString *)leftImageName {
    
    if (leftImageName.length > 0) { }  else {
        
        return;
    }
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.image = leftImageName.toImage;
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(leftImageView.image.width);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.leading.mas_equalTo(self.mas_leading).offset(10);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.image = @"common_line_1".toImage;
    line.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.leading.mas_equalTo(leftImageView.mas_trailing).offset(10);
    }];
    
}

- (void)setTextMargin:(CGFloat)textMargin {
    
    objc_setAssociatedObject(self, &UITextField_textMargin, @(textMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)textMargin {
    
    CGFloat value = ((NSNumber *)objc_getAssociatedObject(self, &UITextField_textMargin)).floatValue;
    if (value == 0.0) { value = 5.0; }
    
    return value;
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    
    [self setValue: placeholderTextColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholder: (NSString * _Nullable)placeholder withColor: (UIColor * _Nonnull)color {
    
    self.placeholder = placeholder;
    self.placeholderTextColor = color;
}

- (void)setPlaceholderFontSize:(CGFloat)placeholderFontSize {
    
     [self setValue: [UIFont systemFontOfSize:placeholderFontSize] forKeyPath:@"_placeholderLabel.font"];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    
    [self setValue: placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

- (void)setPlaceholderTextAlignment:(NSTextAlignment)placeholderTextAlignment {
    
    [self setValue: @(placeholderTextAlignment) forKeyPath:@"_placeholderLabel.textAlignment"];
}

- (void)setPlaceholderFrame:(CGRect)placeholderFrame {
    
     [self setValue:[NSValue valueWithCGRect:placeholderFrame] forKeyPath:@"_placeholderLabel.frame"];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutIfNeeded];
    [super layoutSublayersOfLayer:layer];
}

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self jr_swizzleMethod:@selector(textRectForBounds:) withMethod:@selector(swizzleTextRectForBounds:) error:nil];
        [self jr_swizzleMethod:@selector(editingRectForBounds:) withMethod:@selector(swizzleEditingRectForBounds:) error:nil];
    });
}

//指定文本显示边界
-(CGRect)swizzleTextRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.textMargin, bounds.origin.y, bounds.size.width - self.textMargin*2, bounds.size.height);
}

//定义编辑框位置，右移，缩小编辑区域,与背景图匹配
-(CGRect)swizzleEditingRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.textMargin, bounds.origin.y, bounds.size.width - self.textMargin*2, bounds.size.height);
}

@end
