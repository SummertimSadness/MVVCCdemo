//
//  UserInfoView.m
//  MVVCCdemo
//
//  Created by Yasin on 16/2/19.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "UserInfoView.h"

@implementation UserInfoView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat x = 10;
    CGFloat width = rect.size.width-10;
    CGFloat height = rect.size.height/3.0;
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, height*0, width, height)];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nameLabel];
    _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, height*1, width, height)];
    _ageLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_ageLabel];
    _sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, height*2, width, height)];
    _sexLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_sexLabel];
}


@end
