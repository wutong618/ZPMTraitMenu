//
//  UIColor+Extension.h
//

#import <UIKit/UIKit.h>

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface UIColor (Extension)

+ (UIColor *)color28;
+ (UIColor *)color66;
+ (UIColor *)color88;
+ (UIColor *)color9E;
+ (UIColor *)colorFF;
+ (UIColor *)colorYELLOW;
+ (UIColor *)colorBLue;
+ (UIColor *)colorRED;
+ (UIColor *)color7C;
+ (UIColor *)colorCC;
+ (UIColor *)color_TABLE_BG;
+ (UIColor *)colorE6;
+ (UIColor *)colorF0;

+ (UIColor *) colorWithHexString: (NSString *) hexString;
+ (UIColor *) colorWithHexString: (NSString *) hexString andAlpha:(CGFloat) alpha;
+ (NSString*) stringWithColor:(UIColor*)color;
@end
