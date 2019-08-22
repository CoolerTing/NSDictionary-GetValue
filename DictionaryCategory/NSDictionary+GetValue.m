//
//  NSDictionary+GetValue.m
//  DictionaryCategory
//
//  Created by 丁强 on 2019/8/21.
//  Copyright © 2019 丁强. All rights reserved.
//

#import "NSDictionary+GetValue.h"

@implementation NSDictionary (GetValue)
- (id)getValueWithProperty:(NSString *)property {
    NSMutableArray *propertyArr = [property componentsSeparatedByString:@"."].mutableCopy;
    // 第一个属性值
    NSString *firstProperty = propertyArr.firstObject;
    // 原始属性值
    NSString *originalProperty = firstProperty;
    // 是否需要取数组某个值
    BOOL haveIndex = NO;
    // 数组取值下标
    NSString *subProperty;
    // 判断数组是否需要取值
    if ([firstProperty containsString:@"["] && [firstProperty containsString:@"]"]) {
        haveIndex = YES;
        NSRange start = [firstProperty rangeOfString:@"["];
        NSRange end = [firstProperty rangeOfString:@"]"];
        subProperty = [firstProperty substringWithRange:NSMakeRange(start.location + 1, end.location - start.location - 1)];
        firstProperty = [firstProperty substringToIndex:start.location];
    }
    id value = [self valueForKey:firstProperty];
    [propertyArr removeObjectAtIndex:0];
    NSString *lastProperty = [propertyArr componentsJoinedByString:@"."];
    if ([value isKindOfClass:NSDictionary.class]) {
        return [value getValueWithProperty:lastProperty];
    } else if ([value isKindOfClass:NSArray.class]) {
        if (haveIndex) {
            NSArray *valueArray = (NSArray *)value;
            if ([self validateNumber:subProperty]) {
                NSInteger index = [subProperty integerValue];
                if (index > valueArray.count - 1) {
                    NSLog(@"取值下标超出数组范围: %@", originalProperty);
                    return nil;
                } else {
                    id arrayValue = valueArray[index];
                    if ([arrayValue isKindOfClass:NSDictionary.class]) {
                        return [arrayValue getValueWithProperty:lastProperty];
                    } else {
                        if ([lastProperty isEqualToString:@""]) {
                            return arrayValue;
                        } else {
                            NSLog(@"数组取值非NSDictionary，请检查");
                            return nil;
                        }
                    }
                }
            } else if ([subProperty isEqualToString:@"last"]) {
                id arrayValue = valueArray.lastObject;
                if ([arrayValue isKindOfClass:NSDictionary.class]) {
                    return [arrayValue getValueWithProperty:lastProperty];
                } else {
                    if ([lastProperty isEqualToString:@""]) {
                        return arrayValue;
                    } else {
                        NSLog(@"数组取值非NSDictionary，请检查");
                        return nil;
                    }
                }
            } else {
                NSLog(@"数组下标取值书写错误，请检查属性值: %@", originalProperty);
                return nil;
            }
        } else {
            return value;
        }
    } else if ([value isKindOfClass:NSNull.class] || value == NULL || value == nil) {
        NSLog(@"属性值取值错误，请检查属性值: %@（如该值确实为空属性，请忽略该提示）", originalProperty);
        return nil;
    } else {
        return value;
    }
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    if (number.length == 0) {
        res = NO;
    }
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
@end
