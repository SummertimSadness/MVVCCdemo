//
//  UserModel.h
//  MVVCCdemo
//
//  Created by Yasin on 16/2/19.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic)NSString *uid;
@property (nonatomic)NSString *name;
@property (nonatomic)NSString *sexChinese;
@property (nonatomic)NSUInteger age;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
