//
//  UIColor+Extension.m
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)color28{
    return  [self colorWithHexString:@"282828"];
}
+ (UIColor *)color66{
return  [self colorWithHexString:@"666666"];

}
+ (UIColor *)color88{

   return  [self colorWithHexString:@"888888"];
}
+ (UIColor *)color9E{
   return  [self colorWithHexString:@"9E9E9E"];
}
+ (UIColor *)colorFF{
   return  [self colorWithHexString:@"FFFFFF"];
}
+ (UIColor *)colorYELLOW{
     return  [self colorWithHexString:@"FFB433"];

}
+ (UIColor *)colorBLue{
     return  [self colorWithHexString:@"1A8AFA"];
}
+ (UIColor *)colorRED{

     return  [self colorWithHexString:@"FF5C56"];
}
+ (UIColor *)color7C{

     return  [self colorWithHexString:@"7C88A4"];
}
+ (UIColor *)colorCC{
     return  [self colorWithHexString:@"CCCCCC"];
}
+ (UIColor *)color_TABLE_BG{

       return  [self colorWithHexString:@"F8F8FA"];
}

+ (UIColor *)colorE6{
    return  [self colorWithHexString:@"E6E6E6"];
}

+ (UIColor *)colorF0
{
    return [self colorWithHexString:@"#F0F0F0"];
}


+ (UIColor *) colorWithHexString: (NSString *) hexString {

    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1 Case:1];
            green = [self colorComponentFrom: colorString start: 1 length: 1 Case:2];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1 Case:3];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1 Case:0];
            red   = [self colorComponentFrom: colorString start: 1 length: 1 Case:1];
            green = [self colorComponentFrom: colorString start: 2 length: 1 Case:2];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1 Case:3];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2 Case:1];
            green = [self colorComponentFrom: colorString start: 2 length: 2 Case:2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2 Case:3];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2 Case:0];
            red   = [self colorComponentFrom: colorString start: 2 length: 2 Case:1];
            green = [self colorComponentFrom: colorString start: 4 length: 2 Case:2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2 Case:3];
            break;
        default:
            return nil;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (UIColor *) colorWithHexString: (NSString *) hexString
                        andAlpha:(CGFloat) alpha{
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            red   = [self colorComponentFrom: colorString start: 0 length: 1 Case:1];
            green = [self colorComponentFrom: colorString start: 1 length: 1 Case:2];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1 Case:3];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1 Case:0];
            red   = [self colorComponentFrom: colorString start: 1 length: 1 Case:1];
            green = [self colorComponentFrom: colorString start: 2 length: 1 Case:2];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1 Case:3];
            break;
        case 6: // #RRGGBB
            red   = [self colorComponentFrom: colorString start: 0 length: 2 Case:1];
            green = [self colorComponentFrom: colorString start: 2 length: 2 Case:2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2 Case:3];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2 Case:0];
            red   = [self colorComponentFrom: colorString start: 2 length: 2 Case:1];
            green = [self colorComponentFrom: colorString start: 4 length: 2 Case:2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2 Case:3];
            break;
        default:
            return nil;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+(NSString*)stringWithColor:(UIColor *)color
{
    if (color==nil) {
        return @"";
    }
    
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    //rgba
    return [NSString stringWithFormat:@"[%d,%d,%d,%f]",(int)(r*255),(int)(g*255),(int)(b*255),a];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length Case:(int) ARGB{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    switch (ARGB) {
        case 0://alpha
            return hexComponent / 255.0;

            break;
        case 1://red
           
            return ( hexComponent )/ 255.0;

            break;
        case 2://green
            return (hexComponent)/ 255.0;
 
            break;
        case 3://blue
            return (hexComponent) / 255.0;
 
            break;
        default:
            break;
    }
    return 0;
}
@end
