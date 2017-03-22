//
//  DataConvert.m
//  LuggageForFree
//
//  Created by kequ on 2017/2/8.
//  Copyright © 2017年 ke. All rights reserved.
//

#import "DataConvert.h"

@implementation DataConvert

+ (instancetype)shareInstance
{
    static DataConvert * convert;
    if (!convert) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            convert = [[DataConvert alloc] init];
        });
    }
    return convert;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _dateFormatter.timeZone = [NSTimeZone systemTimeZone];
        _dateFormatter.dateFormat = @"yyyy-MM-dd HH:m";
        
    }
    return _dateFormatter;

}
@end
