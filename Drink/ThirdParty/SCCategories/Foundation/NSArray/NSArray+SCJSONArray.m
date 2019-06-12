//
//  NSArray+SCJSONArray.m
//  Pods
//
//  Created by Solo on 17/2/9.
//
//

#import "NSArray+SCJSONArray.h"

@implementation NSArray (SCJSONArray)

#pragma mark - JSON Array
- (NSString *)sc_JSONStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *JSONData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        if (!error) return JSONString;
    }
    return nil;
}

- (NSString *)sc_JSONPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *JSONData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        if (!error) return JSONString;
    }
    return nil;
}

+ (NSArray *)sc_arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}

@end
