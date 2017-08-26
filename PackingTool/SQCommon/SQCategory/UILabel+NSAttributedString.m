//
//  UILabel+NSAttributedString.m
//

#import "UILabel+NSAttributedString.h"

@implementation UILabel(NSAttributedString)

- (void)conspicuousWithColor: (UIColor *)color font: (UIFont *)font from:(NSInteger)index {
    
    if (!self.text || self.text.length < index) {
        
        return;
    }
    
    NSRange range = NSMakeRange(index, self.text.length-index);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttribute: NSFontAttributeName value:font range:range];
    [attributedString addAttribute: NSForegroundColorAttributeName value:color range:range];
    
    self.attributedText = attributedString;
}

- (void)addUnderlineWithColor: (UIColor *)color font: (UIFont *)font from:(NSInteger)index {
    
    NSRange range = NSMakeRange(index, self.text.length-index);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [attributedString addAttribute: NSFontAttributeName value: font range: range];
    [attributedString addAttribute: NSForegroundColorAttributeName value: color range: range];
    [attributedString addAttribute: NSUnderlineColorAttributeName value: color range: range];
    [attributedString addAttribute: NSUnderlineStyleAttributeName value: @(NSUnderlineStyleSingle) range: range];
    //[attributedString addAttribute: NSBaselineOffsetAttributeName value: @(2) range:range];
    
    self.attributedText = attributedString;
}

@end
