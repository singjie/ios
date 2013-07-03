//
//  UIColor+SJAdditions.m
//  singjie.com
//
//  Created by Lee Sing Jie on 8/6/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "UIColor+SJAdditions.h"

@implementation UIColor (SJAdditions)

+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:(float)(arc4random()%255)/255
                           green:(float)(arc4random()%255)/255
                            blue:(float)(arc4random()%255)/255 alpha:1];
}

+ (UIColor *)colorWithRGB:(NSString *)rgb
{
    NSArray *results = [rgb componentsSeparatedByString:@","];
    
    NSParameterAssert(results.count == 3);
		
    return [UIColor colorWithRed:[results[0] floatValue]/255
                           green:[results[1] floatValue]/255
                            blue:[results[2] floatValue]/255
                           alpha:1];
}
@end
