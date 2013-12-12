//
//  NSString+ForJava.m
//  
//
//  Created by Ryan Tang on 12-10-18.
//  Copyright (c) 2012年 Ericsson Labs. All rights reserved.
//

#import "NSString+ForJava.h"

@implementation NSString (ForJava)

//对比两个字符串内容是否一致
- (BOOL) equals:(NSString*) string
{
    return [self isEqualToString:string];
}

//判断字符串是否以指定的前缀开头
- (BOOL) startsWith:(NSString*)prefix
{
    return [self hasPrefix:prefix];
}

//判断字符串是否以指定的后缀结束
- (BOOL) endsWith:(NSString*)suffix
{
    return [self hasSuffix:suffix];
}

//转换成大写
- (NSString *) toLowerCase
{
    return [self lowercaseString];
}

//转换成小写
- (NSString *) toUpperCase
{
    return [self uppercaseString];
}

//截取字符串前后空格
- (NSString *) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//用指定分隔符将字符串分割成数组
- (NSArray *) split:(NSString*) separator
{
    return [self componentsSeparatedByString:separator];
}

//用指定字符串替换原字符串
- (NSString *) replaceAll:(NSString*)oldStr with:(NSString*)newStr
{
    return [self stringByReplacingOccurrencesOfString:oldStr withString:newStr];
}

//从指定的开始位置和结束位置开始截取字符串
- (NSString *) substringFromIndex:(int)begin toIndex:(int)end
{
    if (end <= begin) {
        return @"";
    }
    NSRange range = NSMakeRange(begin, end - begin);
    return [self substringWithRange:range];
}

// 是否包含子串
- (BOOL)contain:(NSString *)subString {
    return [self rangeOfString:subString].length > 0;
}

@end
