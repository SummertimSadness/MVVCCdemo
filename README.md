# 我对MVVM框架的理解：MVVCC框架思路

MVVM是Medel-View-ViewModel。我把ViewModel当做Control来理解于是就成了Model-View-ViewControl-Control的MVVCC框架。
MVVCC框架设想
iOS中viewcontrol中包含一个view，导致viewcontrol的含义有点模糊：既含有viewmodel，又有control。
以下M代表Model，V代表各种View，VC代表ViewController(iOS组件中viewcontrol)，C代表Control。
MVC经典的架构，但是在一些大的项目中导致VC越来越臃肿，所以我考虑使用M-V-VC-C架构。相互引用关系：
VC->(引用)M,
VC->(引用)V,
VC->(引用)C,
C->(引用)VC(弱引用),
C和M没有通信，C和V没有通信。

####M
M就是数据实体,包括做Json解析和一下简单的转换，比如UserModel：
```
@interface User : NSObject
@property (nonatomic)NSString *uid;
@property (nonatomic)NSString *name;
@property (nonatomic)NSString *sexChinese;
@property (nonatomic)NSUInteger age;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
```
.m
```
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
```
####V
V就是各种View，VC的view也属于V。用于信息的展示，不做任何业务逻辑处理。
```
@interface UserInfoView : UIView
@property (nonatomic)UILabel *nameLabel;
@property (nonatomic)UILabel *ageLabel;
@property (nonatomic)UILabel *sexLabel;
@end
```
####VC
VC就是要做和C的通信和相应的一些实现，比如动画的实现、页面跳转实现、引导C和业务逻辑开始等等。
```
#import "UserControl.h"
#import "UserModel.h"
#import "UserInfoView.h"
@interface ViewController ()<UserControlDelegate>
@property (nonatomic) UserModel *user;
@property (nonatomic) UserInfoView *userInfoView;
@property (nonatomic) UserControl *userControl;
@end
```
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.userInfoView.backgroundColor = [UIColor grayColor];    //初始化View
    [self.userControl getUsserInfoFromNet];     //网络请求用户信息
    
}
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
```
####C
C主要做网络请求的实现，action逻辑处理和各种业务逻辑
```
@interface UserControl : NSObject
@property (nonatomic,weak)id<UserControlDelegate> delegate;
- (void)getUsserInfoFromNet;
- (void)readyForUserInfo;
- (NSString *)paramAge:(NSUInteger)age;
@end
```
####VC和C的通信
```
@protocol UserControlDelegate <NSObject>
//VC需要实现的协议
- (void)paramUserInfo:(NSDictionary *)resultDict;
- (void)userInfoViewFullInfo;
- (void)userInfoViewNameLabelAnimation;
@end
```
```
//VC协议的实现
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
```

![MVVCC框架.png](http://upload-images.jianshu.io/upload_images/1024259-21a1313465029f79.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
