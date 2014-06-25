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
#import "Weather.h"
#import "WeatherCommand.h"
#import "BTRWeatherPage.h"

@interface BTRMainViewController ()

@end

@implementation BTRMainViewController
@synthesize cities, cityXML, tempCities, weatherInfoARR, showCities;
@synthesize weatherComm;
@synthesize movieController;
@synthesize weatherImg, lbPlace, lbTemp, lbWeatherInfo, lbWind, lbWindSpeed;
@synthesize lbFutureWeatherFirst, firstImgView, lblFutureWeatherTempFirst, lbFutureWeatherSecond, secondImgView, lblFutureWeatherTempSecond, lbFutureWeatherThird, thirdImgView, lblFutureWeatherTempThird, lbFutureWeatherFourth, fourthImgView, lblFutureWeatherTempFourth;

- (void)loadView
{
    //实例化一个子线程初始化话全局对象并获取全国城市信息：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self loadCityData];
    });
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //加载当前天气视频到主界面
    [self initVideo:@"rain"];
    
    //从网络获取天气信息和当前城市weatherID
    [self loadWeatherInfo];
    
//    BTRWeatherPage *tmpView=[[BTRWeatherPage alloc] initWithFrame:CGRectMake(0, 22, 320, 458)];
//    [self.view addSubview:tmpView];
    [self initWeather];
    [self initFutureWeather];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark 初始化话全局对象并获取全国城市信息
- (void)loadCityData
{
    //初始化天气控制对象
    weatherComm    = [WeatherCommand sharedInstaced];
    //初始化需要显示的城市weatherID数组
    weatherInfoARR = [NSMutableArray array];
    //初始化需要显示的城市的天气详情数组
    showCities     = [[NSMutableArray alloc]initWithObjects:@"101250101", @"101010100", @"101020100", nil];
    //初始化全国的城市XML
    cityXML        = [CityXML sharedInstaced];
    //初始化查找出来的城市数组
    tempCities     = [NSMutableArray array];
    cities         = cityXML.loadXML;
}

- (void)loadWeatherInfo
{
    //创建一个线程加载当前城市weatherID和天气详情
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //获取到当前城市天气ID
        [showCities replaceObjectAtIndex:0 withObject:[weatherComm autoGetCityWeatherID]];
        //获取到天气当前天气详情
        [weatherComm getWeatherInfo:showCities[0]];
        //获取天气数据
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            while (0 == weatherComm.weatherInfoList.count){sleep(1);};
            //[weatherInfoARR replaceObjectAtIndex:0 withObject:weatherComm.weatherInfoList];
            [weatherInfoARR insertObject:weatherComm.weatherInfoList[0] atIndex:0];
            NSLog(@"------%@", weatherInfoARR[0]);
            [self updateMainInThread:weatherInfoARR[0]];
        });
        //[weatherComm getWeatherInfo:showCities[0]];
        //[weatherInfoARR insertObject:[weatherComm getWeatherInfo:showCities[0]] atIndex:0];
    });
}

#pragma mark 初始化主界面
#pragma mark -加载背景视频
- (void)initVideo:(NSString *)videoName
{
    NSString *weather = videoName;
    //视频路径
    NSURL *vedioUrl   = [[NSBundle mainBundle] URLForResource:weather withExtension:@"mp4"];
    movieController   = [[MPMoviePlayerController alloc] initWithContentURL:vedioUrl];
    //隐藏视频控制栏
    [movieController setControlStyle:MPMovieControlModeDefault];
    //设置播放模式（循环播放）
    [movieController setRepeatMode:MPMovieRepeatModeOne];
    [movieController setScalingMode:MPMovieScalingModeAspectFill];
    [movieController.view setFrame:CGRectMake(0, 22, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view insertSubview:movieController.view atIndex:0];
    [movieController performSelectorInBackground:@selector(play) withObject:nil];
}

#pragma mark 初始化天气信息
#pragma mark -初始化当前天气信息
- (void)initWeather
{
    //正中间的天气图像
    weatherImg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clear.png"]];
    //[weatherImg setFrame:CGRectMake(70, 80, 180, 180)];
    [weatherImg setFrame:CGRectMake(30, 130, 180, 180)];
    [self.view addSubview:weatherImg];
    
    //地点标签
    lbPlace=[[UILabel alloc] init];
    [lbPlace setBackgroundColor:[UIColor clearColor]];
    [lbPlace setTextColor:[UIColor whiteColor]];
    //[lbPlace setFont:[UIFont fontWithName:@"Helvetica" size:23]];
    [lbPlace setFont:[UIFont fontWithName:@"Helvetica-Bold" size:23]];
    [lbPlace setFrame:CGRectMake(20, 80, 150, 22)];
    [lbPlace setText:@"北京"];
    [self.view addSubview:lbPlace];
    
    //温度标签
    lbTemp=[[UILabel alloc] init];
    [lbTemp setBackgroundColor:[UIColor clearColor]];
    [lbTemp setTextColor:[UIColor whiteColor]];
    [lbTemp setFont:[UIFont fontWithName:@"Helvetica" size:19]];
    [lbTemp setTextAlignment:NSTextAlignmentCenter];
    [lbTemp setFrame:CGRectMake(210, 255, 100, 19)];
    [lbTemp setText:@"30℃~37℃"];
    [self.view addSubview:lbTemp];
    
    //添加天气信息标签
    lbWeatherInfo=[[UILabel alloc] init];
    [lbWeatherInfo setBackgroundColor:[UIColor clearColor]];
    [lbWeatherInfo setTextColor:[UIColor whiteColor]];
    [lbWeatherInfo setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [lbWeatherInfo setFrame:CGRectMake(lbPlace.frame.origin.x, lbPlace.frame.origin.y+lbPlace.frame.size.height+10, 100, 16)];
    [lbWeatherInfo setText:@"小雨转中雨"];
    [self.view addSubview:lbWeatherInfo];
    
    //风类标签
    lbWind=[[UILabel alloc] init];
    [lbWind setBackgroundColor:[UIColor clearColor]];
    [lbWind setTextColor:[UIColor whiteColor]];
    [lbWind setTextAlignment:NSTextAlignmentCenter];
    [lbWind setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [lbWind setFrame:CGRectMake(190, lbTemp.frame.origin.y+lbTemp.frame.size.height+5, 135, 13)];
    [lbWind setText:@"微风"];
    [self.view addSubview:lbWind];
    
    //风类级别标签
    lbWindSpeed=[[UILabel alloc] init];
    [lbWindSpeed setBackgroundColor:[UIColor clearColor]];
    [lbWindSpeed setTextColor:[UIColor whiteColor]];
    [lbWindSpeed setTextAlignment:NSTextAlignmentCenter];
    [lbWindSpeed setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [lbWindSpeed setFrame:CGRectMake(190, lbWind.frame.origin.y+lbWind.frame.size.height+5, lbWind.frame.size.width, 13)];
    [lbWindSpeed setText:@"小于3级"];
    [self.view addSubview:lbWindSpeed];
}

#pragma mark -初始化未来四天天气信息
- (void)initFutureWeather
{
    //图片宽度
    CGFloat imgWidth=45;
    //图片高度
    CGFloat imgHeight=imgWidth;
    CGFloat offsetGap=5;
    
    lbFutureWeatherFirst = [[UILabel alloc] init];
    [lbFutureWeatherFirst setBackgroundColor:[UIColor clearColor]];
    [lbFutureWeatherFirst setTextColor:[UIColor whiteColor]];
    [lbFutureWeatherFirst setTextAlignment:NSTextAlignmentCenter];
    [lbFutureWeatherFirst setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [lbFutureWeatherFirst setFrame:CGRectMake(20, 350, 70, 11)];
    [lbFutureWeatherFirst setText:@"星期四"];
    [self.view addSubview:lbFutureWeatherFirst];
    
    //图片
    firstImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scatteredsnow.png"]];
    [firstImgView setFrame:CGRectMake(lbFutureWeatherFirst.frame.origin.x+15, lbFutureWeatherFirst.frame.origin.y+lbFutureWeatherFirst.frame.size.height+offsetGap, imgWidth, imgHeight)];
    [self.view addSubview:firstImgView];
    
    //温度
    lblFutureWeatherTempFirst = [[UILabel alloc] init];
    [lblFutureWeatherTempFirst setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempFirst setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempFirst setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempFirst setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempFirst setFrame:CGRectMake(20, firstImgView.frame.origin.y+firstImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempFirst setText:@"35℃"];
    [self.view addSubview:lblFutureWeatherTempFirst];
    
    
    //第2个天气信息
    lbFutureWeatherSecond = [[UILabel alloc] init];
    [lbFutureWeatherSecond setBackgroundColor:[UIColor clearColor]];
    [lbFutureWeatherSecond setTextColor:[UIColor whiteColor]];
    [lbFutureWeatherSecond setTextAlignment:NSTextAlignmentCenter];
    [lbFutureWeatherSecond setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [lbFutureWeatherSecond setFrame:CGRectMake(90, lbFutureWeatherFirst.frame.origin.y, lbFutureWeatherFirst.frame.size.width, lbFutureWeatherFirst.frame.size.height)];
    [lbFutureWeatherSecond setText:@"星期五"];
    [self.view addSubview:lbFutureWeatherSecond];
    
    //图片
    secondImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rainandsnow.png"]];
    [secondImgView setFrame:CGRectMake(lbFutureWeatherSecond.frame.origin.x+10, lbFutureWeatherSecond.frame.origin.y+lbFutureWeatherSecond.frame.size.height+offsetGap, imgWidth, imgHeight)];
    [self.view addSubview:secondImgView];
    
    //温度
    lblFutureWeatherTempSecond = [[UILabel alloc] init];
    [lblFutureWeatherTempSecond setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempSecond setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempSecond setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempSecond setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempSecond setFrame:CGRectMake(20+lbFutureWeatherFirst.frame.size.width, secondImgView.frame.origin.y+secondImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempSecond setText:@"32℃"];
    [self.view addSubview:lblFutureWeatherTempSecond];
    
    
    //第3个天气信息
    lbFutureWeatherThird = [[UILabel alloc] init];
    [lbFutureWeatherThird setBackgroundColor:[UIColor clearColor]];
    [lbFutureWeatherThird setTextColor:[UIColor whiteColor]];
    [lbFutureWeatherThird setTextAlignment:NSTextAlignmentCenter];
    [lbFutureWeatherThird setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [lbFutureWeatherThird setFrame:CGRectMake(160, lbFutureWeatherFirst.frame.origin.y, lbFutureWeatherFirst.frame.size.width, lbFutureWeatherFirst.frame.size.height)];
    [lbFutureWeatherThird setText:@"星期六"];
    [self.view addSubview:lbFutureWeatherThird];
    
    //图片
    thirdImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wind.png"]];
    [thirdImgView setFrame:CGRectMake(lbFutureWeatherThird.frame.origin.x+10, lbFutureWeatherThird.frame.origin.y+lbFutureWeatherThird.frame.size.height+offsetGap, imgWidth, imgHeight)];
    [self.view addSubview:thirdImgView];
    
    //温度
    lblFutureWeatherTempThird = [[UILabel alloc] init];
    [lblFutureWeatherTempThird setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempThird setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempThird setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempThird setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempThird setFrame:CGRectMake(20+lblFutureWeatherTempFirst.frame.size.width+lblFutureWeatherTempSecond.frame.size.width, secondImgView.frame.origin.y+secondImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempThird setText:@"32℃"];
    [self.view addSubview:lblFutureWeatherTempThird];
    
    
    //第4个天气信息
    lbFutureWeatherFourth = [[UILabel alloc] init];
    [lbFutureWeatherFourth setBackgroundColor:[UIColor clearColor]];
    [lbFutureWeatherFourth setTextColor:[UIColor whiteColor]];
    [lbFutureWeatherFourth setTextAlignment:NSTextAlignmentCenter];
    [lbFutureWeatherFourth setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [lbFutureWeatherFourth setFrame:CGRectMake(230, lbFutureWeatherFirst.frame.origin.y, lbFutureWeatherFirst.frame.size.width, lbFutureWeatherFirst.frame.size.height)];
    [lbFutureWeatherFourth setText:@"星期日"];
    [self.view addSubview:lbFutureWeatherFourth];
    
    //图片
    fourthImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"storm.png"]];
    [fourthImgView setFrame:CGRectMake(lbFutureWeatherFourth.frame.origin.x+10, lbFutureWeatherFourth.frame.origin.y+lbFutureWeatherFourth.frame.size.height+offsetGap,imgWidth, imgHeight)];
    [self.view addSubview:fourthImgView];
    
    //温度
    lblFutureWeatherTempFourth = [[UILabel alloc] init];
    [lblFutureWeatherTempFourth setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempFourth setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempFourth setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempFourth setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempFourth setFrame:CGRectMake(20+lblFutureWeatherTempFirst.frame.size.width+lblFutureWeatherTempSecond.frame.size.width+lblFutureWeatherTempThird.frame.size.width, secondImgView.frame.origin.y+secondImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempFourth setText:@"33℃"];
    [self.view addSubview:lblFutureWeatherTempFourth];
}

#pragma mark -更新当前天气
-(void)updateMainInThread:(Weather *)city
{
//    [movieController.view removeFromSuperview];
//    [self initVideo:@"clear"];
    //lblDate.text=city.date_y;
    weatherImg.image=city.weatherImage;
    lbPlace.text=city.cityName;
    lbWeatherInfo.text=city.weather;
    lbWind.text=city.wind;
    lbWindSpeed.text=city.windSpeed;
    lbTemp.text=city.temp;
    
    NSLog(@"%@",[NSString stringWithFormat:@"effect_%@.png",city.effectImg]);
    //[effectBgImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"effect_%@.png",city.effectImg]]];
    
    //更新未来四天的天气情况
    firstImgView.image=city.weatherImage;
    lblFutureWeatherTempFirst.text=city.temp;
    lbFutureWeatherFirst.text=city.week;
    
    secondImgView.image=city.weatherImage;
    lblFutureWeatherTempSecond.text=city.temp;
    lbFutureWeatherFourth.text=city.week;
    
    thirdImgView.image=city.weatherImage;
    lblFutureWeatherTempThird.text=city.temp;
    lbFutureWeatherThird.text=city.week;
    
    fourthImgView.image=city.weatherImage;
    lblFutureWeatherTempFourth.text=city.temp;
    lbFutureWeatherFourth.text=city.week;
}

- (IBAction)seachCityWID:(id)sender {
    //启动一个线程去搜索城市
//    [NSThread detachNewThreadSelector:@selector(seachCity) toTarget:self withObject:nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //[self seachCity];
    });
}

- (void)seachCity
{
    NSLog(@"========");
    cities = cityXML.getCities;
    [tempCities removeAllObjects];
    //查找热门城市
    for (City * item in cities[0]) {
        NSRange chinese  = [item.cityName rangeOfString:@"a" options:NSCaseInsensitiveSearch];
        NSRange  letters = [item.cityLetter rangeOfString:@"gz" options:NSCaseInsensitiveSearch];
        if (chinese.location != NSNotFound) {
            [tempCities addObject:item];
        }else if (letters.location != NSNotFound){
            [tempCities addObject:item];
        }
    }
    //查找普通城市
    for (City * item in cities[1]) {
        NSRange chinese  = [item.cityName rangeOfString:@"a" options:NSCaseInsensitiveSearch];
        NSRange  letters = [item.cityLetter rangeOfString:@"gz" options:NSCaseInsensitiveSearch];
        if (chinese.location != NSNotFound) {
            [tempCities addObject:item];
        }else if (letters.location != NSNotFound){
            [tempCities addObject:item];
        }
    }
    NSLog(@"========tempCitiesCount = %i", tempCities.count);
    for (int i = 0; i < tempCities.count; i ++) {
        NSLog(@"%@", ((City *)tempCities[i]).cityName);
    }
}


@end
