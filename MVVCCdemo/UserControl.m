//
//  UserControl.m
//  MVVCCdemo
//
//  Created by Yasin on 16/2/19.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UserControl.h"

@implementation UserControl
- (void)getUsserInfoFromNet{
    //在这里调用网络请求
    NSDictionary *result = @{@"uid":@"1205",@"name":@"小明",@"sex":@"0",@"age":@"19"};
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(paramUserInfo:)]) {
            [self.delegate paramUserInfo:result];
        }
    });
}
- (void)readyForUserInfo{
    if ([self.delegate respondsToSelector:@selector(userInfoViewFullInfo)]) {
        [self.delegate userInfoViewFullInfo];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(paramUserInfo:)]) {
            [self.delegate userInfoViewNameLabelAnimation];
        }
    });
}
- (NSString *)paramAge:(NSUInteger)age{
    if (age<16) {
        return @"少年";
    }else if (age<30) {
        return @"青年";
    }else if (age<50) {
        return @"中年";
    }else {
        return @"老年";
    }
}
@end
