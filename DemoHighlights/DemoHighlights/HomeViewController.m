//
//  HomeViewController.m
//  CustomTarBar
//
//  Created by yinzhiqiang on 2017/11/18.
//  Copyright © 2017年 yinzhiqiang. All rights reserved.
//

#import "HomeViewController.h"
#import "UIView+QKExtension.h"
#import "ButtonModel.h"
#import "CLRotationView.h"
#import "CLOneViewController.h"
#import "SettingViewController.h"
#import "DemoHighlightViewController.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface HomeViewController ()

@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) CLRotationView *rotateView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 首页导航栏导航条隐藏
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
    
    [self initCircleView];
    
    [self initCenterButton];
    
    [self initOtherView];
}

-(void)initCircleView
{
    // 自定义的转盘视图
    CLRotationView *rotateView = [[CLRotationView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    rotateView.center = self.view.center;
    self.rotateView = rotateView;
    _rotateView.layer.contents = (__bridge id)[UIImage imageNamed:@"home_center_bg"].CGImage;
    
    // 获取按钮模型数据
    _datasource = [NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ButtonList.plist" ofType:nil];
    NSArray *contentArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *item  in contentArray) {
        ButtonModel *model = [[ButtonModel alloc]init];
        [model setValuesForKeysWithDictionary:item];
        [_datasource addObject:model];
    }
    NSMutableArray *titleArray = [NSMutableArray new];
    NSMutableArray *imageArray = [NSMutableArray new];
    for (ButtonModel *model  in _datasource) {
        [titleArray addObject:model.title];
        [imageArray addObject:model.Image];
    }
    
    [_rotateView BtnType:CL_RoundviewTypeCustom BtnWidth:80 adjustsFontSizesTowidth:YES masksToBounds:YES conrenrRadius:40 image:imageArray TitileArray:titleArray titileColor:[UIColor blackColor]];
    __weak  typeof(self) weakself = self;
    _rotateView.back = ^(NSInteger num ,NSString *name ) {
        [weakself pushView:num name:name];
    };
    [self.view addSubview:_rotateView];
}

-(void)initCenterButton
{
    // 自定义的中间按钮
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerButton.frame = CGRectMake(0, 0, 80, 80);
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [[UIImage imageNamed:@"home_center_img"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.userInteractionEnabled = NO;
    // 设置的按钮的图片的大小
    imageview.frame = CGRectMake(_centerButton.center.x - 15, _centerButton.center.y - 20, 30, 30);
    
    [_centerButton addSubview:imageview];
    UILabel *lable = [[UILabel alloc] init];
    
    CGFloat BtnWidth = _centerButton.frame.size.width;
    lable.frame = CGRectMake(imageview.center.x - (BtnWidth - 20)*0.5, CGRectGetMaxY(imageview.frame), BtnWidth - 20, 20);
    
    lable.text = @"视 觉";
    // 设置字体颜色为应用程序的主题色 通过取色笔获取的 RGB颜色
    lable.textColor = [UIColor colorWithRed:255.0/ 255.0 green:96/255.0 blue:52/255.0 alpha:1.0];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:11];
    [_centerButton addSubview:lable];
    
    _centerButton.backgroundColor = [UIColor whiteColor];
    _centerButton.center = self.view.center;
    
    _centerButton.layer.cornerRadius = 40;
    [_centerButton addTarget:self action:@selector(showItems:) forControlEvents:UIControlEventTouchUpInside];
    
    // 按钮是添加到控制器的view上，所以转盘转动的时候不会跟着转盘一同旋转
    [self.view addSubview:_centerButton];
}

-(void)initOtherView
{
    NSInteger width = [[UIScreen mainScreen] bounds].size.width;
    // 加载logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-30, 30, 60, 60)];
    logo.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logo];
    
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-30, 30, 20, 20)];
    [settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
}

- (void)showItems:(UIButton *)sender
{
    DemoHighlightViewController *vc = [[DemoHighlightViewController alloc]init];
    for (UILabel *label in sender.subviews) {
        if ( [label isKindOfClass:[UILabel class]]  &&  label.text  ) {
            // 根据按钮的标题给控制器的title赋值
            vc.title = label.text;
            NSLog(@"----%@",label.text);
        } else {
            vc.title =  @"视觉";
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
}

// 跳转界面
- (void)pushView:(NSInteger)num name:(NSString *)name
{
    NSMutableArray *classArray = [NSMutableArray new];
    for (ButtonModel *model  in _datasource) {
        [classArray addObject:model.className];
    }
    Class class = NSClassFromString(classArray[num]);
    CLOneViewController *vc = [[class alloc]init];
    vc.title = name;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)settingBtnClick
{
    SettingViewController *setting = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

@end
