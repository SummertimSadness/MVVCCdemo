//
//  UserControl.h
//  MVVCCdemo
//
//  Created by Yasin on 16/2/19.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserControlDelegate <NSObject>
//VC需要实现的协议
- (void)paramUserInfo:(NSDictionary *)resultDict;
- (void)userInfoViewFullInfo;
- (void)userInfoViewNameLabelAnimation;
@end
@interface UserControl : NSObject
@property (nonatomic,weak)id<UserControlDelegate> delegate;
- (void)getUsserInfoFromNet;
- (void)readyForUserInfo;
- (NSString *)paramAge:(NSUInteger)age;
@end
