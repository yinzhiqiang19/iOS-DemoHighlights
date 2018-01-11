//
//  PublicFunction.m
//  DemoHighlights
//
//  Created by yinzhiqiang on 2018/1/10.
//  Copyright © 2018年 yinzhiqiang. All rights reserved.
//

#import "PublicFunction.h"

@implementation PublicFunction

+(NSString*)printTime:(NSInteger)startOrEnd
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss SSS"];
    NSString *timeString = [formatter stringFromDate:date];
    if (startOrEnd == 1) {
        NSLog(@"start Time: %@",timeString);
        [[NSUserDefaults standardUserDefaults] setObject:timeString forKey:@"StartTimeString"];
    }else{
        NSLog(@"end   Time: %@",timeString);
        NSString *startString = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartTimeString"];
        timeString = [NSString stringWithFormat:@"起止时间：\n%@\n%@",startString,timeString];
    }
    return timeString;
}

@end
