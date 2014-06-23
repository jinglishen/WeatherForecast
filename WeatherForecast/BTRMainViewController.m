//
//  BTRMainViewController.m
//  WeatherForecast
//
//  Created by geek-group on 14-6-21.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import "BTRMainViewController.h"
#import "CityXML.h"
#import "City.h"

@interface BTRMainViewController ()

@end

@implementation BTRMainViewController
@synthesize cities, movieController, cityXML, tempCities;
@synthesize cityWeatherIDLB,seachCityWeatherIDBTN;

- (void)loadView
{
    //实例化一个子线程加载全国城市信息
   // [NSThread detachNewThreadSelector:@selector(loadCityData) toTarget:self withObject:nil];
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
        [self loadCityData];
    });
    [super loadView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@", self.view.subviews);
    [self initVideo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark 加载全国城市信息
- (void)loadCityData
{
    //加载全国的城市XML
    cityXML = [[CityXML alloc]init];
    //查找出来的城市数组
    tempCities = [NSMutableArray array];
    cities = cityXML.loadXML;
}

#pragma mark 初始化主界面
#pragma mark -加载背景视频
- (void)initVideo
{
    NSString *weather = @"rain";
    //视频路径
    NSURL *vedioUrl = [[NSBundle mainBundle] URLForResource:weather withExtension:@"mp4"];
    movieController = [[MPMoviePlayerController alloc] initWithContentURL:vedioUrl];
    //隐藏视频控制栏
    [movieController setControlStyle:MPMovieControlModeDefault];
    //设置播放模式（循环播放）
    [movieController setRepeatMode:MPMovieRepeatModeOne];
    [movieController setScalingMode:MPMovieScalingModeAspectFill];
    [movieController.view setFrame:self.view.bounds];
    //[self.view addSubview:movieController.view];
    [self.view insertSubview:movieController.view atIndex:0];
    [movieController performSelectorInBackground:@selector(play) withObject:nil];
}

//#pragma mark 创建登录按钮
//- (void)creatloginBtn
//{
//    seach = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    //设置按钮位
//    //[_mLogin setFrame:CGRectMake(45, 300, 230, 30)];
//    [seach setFrame:CGRectMake(45, 60, 230, 30)];
//    //设置按钮颜色
//    [seach setBackgroundColor:[UIColor colorWithRed:19.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:100]];
//    //设置默认title，和按钮当前状态
//    [seach setTitle:@"搜索" forState:UIControlStateNormal];
//    [seach setTitleColor:[UIColor whiteColor] forState:0];
//    //设置为圆角按钮
//    seach.layer.masksToBounds = YES;
//    //设置圆角弧度
//    seach.layer.cornerRadius = 5.0;
////    [seach addTarget:self action:@selector(enterLoginBtn) forControlEvents:UIControlEventTouchUpInside];
//    //添加当前控件到moveDownGroup视图
//    [self.view addSubview:seach];
//    //_mLogin = nil;
//}

- (IBAction)seachCityWID:(id)sender {
    //[seachCityWeatherIDBTN performSelector:@selector(seachCity) withObject:nil];
//    NSThread* myThread = [[NSThread alloc] initWithTarget:self
//                                                 selector:@selector(seachCity:)
//                                                   object:nil];
//    [myThread start];
    [NSThread detachNewThreadSelector:@selector(seachCity) toTarget:self withObject:nil];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // something
//        [self seachCity];
//    });
    seachCityWeatherIDBTN.enabled = NO;
}

- (void)seachCity
{
//    for (City *item in cities) {
//        NSLog(@"cityLetter = %@", );
//    }
    NSLog(@"========");
    cities = cityXML.getCities;
//    for (int i = 0; i < 3; i ++) {
//        NSLog(@"letter = %@", ((City *)cities[i]).cityLetter);
//    }
    //NSLog(@"McititesCout = %i", cities.count);
    [tempCities removeAllObjects];
    for (City * item in cities[0]) {
        NSRange chinese = [item.cityName rangeOfString:@"a" options:NSCaseInsensitiveSearch];
        NSRange  letters = [item.cityLetter rangeOfString:@"gz" options:NSCaseInsensitiveSearch];
        if (chinese.location != NSNotFound) {
            [tempCities addObject:item];
        }else if (letters.location != NSNotFound){
            [tempCities addObject:item];
        }
    }
    for (City * item in cities[1]) {
        NSRange chinese = [item.cityName rangeOfString:@"a" options:NSCaseInsensitiveSearch];
        NSRange  letters = [item.cityLetter rangeOfString:@"gz" options:NSCaseInsensitiveSearch];
        if (chinese.location != NSNotFound) {
            [tempCities addObject:item];
        }else if (letters.location != NSNotFound){
            [tempCities addObject:item];
        }
    }
    NSLog(@"========tempCitiesCount = %i", tempCities.count);
    for (int i = 0; i < tempCities.count; i ++) {
//        if (i < tempCities.count) {
            NSLog(@"%@", ((City *)tempCities[i]).cityName);
//        }
    }
    seachCityWeatherIDBTN.enabled = YES;
}


@end
