//
//  UserModel.m
//  MVVCCdemo
//
//  Created by Yasin on 16/2/19.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.uid = dict[@"uid"];
        self.name = dict[@"name"];
        self.age = [dict[@"age"] integerValue];
        NSString *sex = dict[@"sex"];//0或1
        self.sexChinese = [sex isEqualToString:@"0"] ? @"男" : @"女";
    }
    return self;
}
@end
