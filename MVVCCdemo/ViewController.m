//
//  ViewController.m
//  MVVCCdemo
//
//  Created by Yasin on 16/2/19.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "ViewController.h"
#import "UserControl.h"
#import "UserModel.h"
#import "UserInfoView.h"
@interface ViewController ()<UserControlDelegate>
@property (nonatomic) UserModel *user;
@property (nonatomic) UserInfoView *userInfoView;
@property (nonatomic) UserControl *userControl;
@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.userInfoView.backgroundColor = [UIColor grayColor];    //初始化View
    [self.userControl getUsserInfoFromNet];     //网络请求用户信息，Control业务处理开始
    
}

#pragma mark - UserControlDelegate
- (void)paramUserInfo:(NSDictionary *)resultDict{
    self.user = [[UserModel alloc]initWithDict:resultDict];
    
    [self.userControl readyForUserInfo];
}

- (void)userInfoViewFullInfo{
    self.userInfoView.nameLabel.text = self.user.name;
    self.userInfoView.ageLabel.text = [self.userControl paramAge:self.user.age];
    self.userInfoView.sexLabel.text = self.user.sexChinese;
}

- (void)userInfoViewNameLabelAnimation{
    [UIView animateWithDuration:2 animations:^{
        self.userInfoView.nameLabel.textColor = [UIColor redColor];
    }];
}

#pragma mark - private methods
#pragma mark - getters and setters
- (UserInfoView *)userInfoView{
    if (_userInfoView == nil) {
        _userInfoView = [[UserInfoView alloc]initWithFrame:CGRectMake(50, 50, 150, 90)];
        [self.view addSubview:_userInfoView];
    }
    return _userInfoView;
}
- (UserControl *)userControl{
    if (_userControl == nil) {
        _userControl = [[UserControl alloc]init];
        _userControl.delegate = self;
    }
    return _userControl;
}
@end
