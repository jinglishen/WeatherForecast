//
//  BTRWeatherPage.m
//  WeatherForecast
//
//  Created by geek-group on 14-6-25.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import "BTRWeatherPage.h"
#import "City.h"

@interface BTRWeatherPage ()

@end

@implementation BTRWeatherPage
@synthesize weatherImg, lbPlace, lbTemp, lbWeatherInfo, lbWind, lbWindSpeed;
@synthesize lbFutureWeatherFirst, firstImgView, lblFutureWeatherTempFirst, lbFutureWeatherSecond, secondImgView, lblFutureWeatherTempSecond, lbFutureWeatherThird, thirdImgView, lblFutureWeatherTempThird, lbFutureWeatherFourth, fourthImgView, lblFutureWeatherTempFourth;

- (id)initWithFrame:(CGRect)frame
{
    self=[self initWithFrame:frame];
    if (self) {
        //加载当前天气信息到界面
//        [self initWeather:self];
//        [self initFutureWeather:self];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withCity:(City *)city
{
    self=[self initWithFrame:frame];
    if(self)
    {
        //self.currentCity=city;
        //NSString *weatherUrl=[[WeatherDAL sharedInstaced] urlWeatherByCityID:currentCity.cityID];
        //[[DownloadHelper sharedInstance] startRequest:weatherUrl delegate:self tag:1 userInfo:nil];
    }
    return self;
}

#pragma mark 初始化天气信息
#pragma mark -初始化当前天气信息
- (void)initWeather:(id)obj
{
    //正中间的天气图像
    weatherImg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clear.png"]];
    [weatherImg setFrame:CGRectMake(70, 80, 180, 180)];
    [obj addSubview:weatherImg];
    
    //地点标签
    lbPlace=[[UILabel alloc] init];
    [lbPlace setBackgroundColor:[UIColor clearColor]];
    [lbPlace setTextColor:[UIColor whiteColor]];
    [lbPlace setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    [lbPlace setFrame:CGRectMake(20, 225, 150, 22)];
    [lbPlace setText:@"北京"];
    [obj addSubview:lbPlace];
    
    //温度标签
    lbTemp=[[UILabel alloc] init];
    [lbTemp setBackgroundColor:[UIColor clearColor]];
    [lbTemp setTextColor:[UIColor whiteColor]];
    [lbTemp setFont:[UIFont fontWithName:@"Helvetica" size:19]];
    [lbTemp setTextAlignment:NSTextAlignmentCenter];
    [lbTemp setFrame:CGRectMake(200, 220, 100, 19)];
    [lbTemp setText:@"30℃~84℃"];
    [obj addSubview:lbTemp];
    
    //添加天气信息标签
    lbWeatherInfo=[[UILabel alloc] init];
    [lbWeatherInfo setBackgroundColor:[UIColor clearColor]];
    [lbWeatherInfo setTextColor:[UIColor whiteColor]];
    [lbWeatherInfo setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [lbWeatherInfo setFrame:CGRectMake(lbPlace.frame.origin.x, lbPlace.frame.origin.y+lbPlace.frame.size.height+10, 100, 16)];
    [lbWeatherInfo setText:@"小雨转中雨"];
    [obj addSubview:lbWeatherInfo];
    
    //风类标签
    lbWind=[[UILabel alloc] init];
    [lbWind setBackgroundColor:[UIColor clearColor]];
    [lbWind setTextColor:[UIColor whiteColor]];
    [lbWind setTextAlignment:NSTextAlignmentCenter];
    [lbWind setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [lbWind setFrame:CGRectMake(160, lbTemp.frame.origin.y+lbTemp.frame.size.height+5, 135, 13)];
    [lbWind setText:@"微风"];
    [obj addSubview:lbWind];
    
    //风类级别标签
    lbWindSpeed=[[UILabel alloc] init];
    [lbWindSpeed setBackgroundColor:[UIColor clearColor]];
    [lbWindSpeed setTextColor:[UIColor whiteColor]];
    [lbWindSpeed setTextAlignment:NSTextAlignmentCenter];
    [lbWindSpeed setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [lbWindSpeed setFrame:CGRectMake(160, lbWind.frame.origin.y+lbWind.frame.size.height+5, lbWind.frame.size.width, 13)];
    [lbWindSpeed setText:@"小于3级"];
    [obj addSubview:lbWindSpeed];
}

#pragma mark -初始化未来四天天气信息
- (void)initFutureWeather:(id)obj
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
    [lbFutureWeatherFirst setFrame:CGRectMake(20, 290, 70, 11)];
    [lbFutureWeatherFirst setText:@"星期六"];
    [obj addSubview:lbFutureWeatherFirst];
    
    //图片
    firstImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scatteredsnow.png"]];
    [firstImgView setFrame:CGRectMake(lbFutureWeatherFirst.frame.origin.x+15, lbFutureWeatherFirst.frame.origin.y+lbFutureWeatherFirst.frame.size.height+offsetGap, imgWidth, imgHeight)];
    [obj addSubview:firstImgView];
    
    //温度
    lblFutureWeatherTempFirst = [[UILabel alloc] init];
    [lblFutureWeatherTempFirst setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempFirst setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempFirst setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempFirst setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempFirst setFrame:CGRectMake(20, firstImgView.frame.origin.y+firstImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempFirst setText:@"23℃"];
    [obj addSubview:lblFutureWeatherTempFirst];
    
    
    //第2个天气信息
    lbFutureWeatherSecond = [[UILabel alloc] init];
    [lbFutureWeatherSecond setBackgroundColor:[UIColor clearColor]];
    [lbFutureWeatherSecond setTextColor:[UIColor whiteColor]];
    [lbFutureWeatherSecond setTextAlignment:NSTextAlignmentCenter];
    [lbFutureWeatherSecond setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [lbFutureWeatherSecond setFrame:CGRectMake(90, lbFutureWeatherFirst.frame.origin.y, lbFutureWeatherFirst.frame.size.width, lbFutureWeatherFirst.frame.size.height)];
    [lbFutureWeatherSecond setText:@"星期日"];
    [obj addSubview:lbFutureWeatherSecond];
    
    //图片
    secondImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rainandsnow.png"]];
    [secondImgView setFrame:CGRectMake(lbFutureWeatherSecond.frame.origin.x+10, lbFutureWeatherSecond.frame.origin.y+lbFutureWeatherSecond.frame.size.height+offsetGap, imgWidth, imgHeight)];
    [obj addSubview:secondImgView];
    
    //温度
    lblFutureWeatherTempSecond = [[UILabel alloc] init];
    [lblFutureWeatherTempSecond setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempSecond setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempSecond setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempSecond setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempSecond setFrame:CGRectMake(20+lbFutureWeatherFirst.frame.size.width, secondImgView.frame.origin.y+secondImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempSecond setText:@"18℃"];
    [obj addSubview:lblFutureWeatherTempSecond];
    
    
    //第3个天气信息
    lbFutureWeatherThird = [[UILabel alloc] init];
    [lbFutureWeatherThird setBackgroundColor:[UIColor clearColor]];
    [lbFutureWeatherThird setTextColor:[UIColor whiteColor]];
    [lbFutureWeatherThird setTextAlignment:NSTextAlignmentCenter];
    [lbFutureWeatherThird setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [lbFutureWeatherThird setFrame:CGRectMake(160, lbFutureWeatherFirst.frame.origin.y, lbFutureWeatherFirst.frame.size.width, lbFutureWeatherFirst.frame.size.height)];
    [lbFutureWeatherThird setText:@"星期一"];
    [obj addSubview:lbFutureWeatherThird];
    
    //图片
    thirdImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wind.png"]];
    [thirdImgView setFrame:CGRectMake(lbFutureWeatherThird.frame.origin.x+10, lbFutureWeatherThird.frame.origin.y+lbFutureWeatherThird.frame.size.height+offsetGap, imgWidth, imgHeight)];
    [obj addSubview:thirdImgView];
    
    //温度
    lblFutureWeatherTempThird = [[UILabel alloc] init];
    [lblFutureWeatherTempThird setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempThird setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempThird setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempThird setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempThird setFrame:CGRectMake(20+lblFutureWeatherTempFirst.frame.size.width+lblFutureWeatherTempSecond.frame.size.width, secondImgView.frame.origin.y+secondImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempThird setText:@"25℃"];
    [obj addSubview:lblFutureWeatherTempThird];
    
    
    //第4个天气信息
    lbFutureWeatherFourth = [[UILabel alloc] init];
    [lbFutureWeatherFourth setBackgroundColor:[UIColor clearColor]];
    [lbFutureWeatherFourth setTextColor:[UIColor whiteColor]];
    [lbFutureWeatherFourth setTextAlignment:NSTextAlignmentCenter];
    [lbFutureWeatherFourth setFont:[UIFont fontWithName:@"Helvetica" size:11]];
    [lbFutureWeatherFourth setFrame:CGRectMake(230, lbFutureWeatherFirst.frame.origin.y, lbFutureWeatherFirst.frame.size.width, lbFutureWeatherFirst.frame.size.height)];
    [lbFutureWeatherFourth setText:@"星期二"];
    [obj addSubview:lbFutureWeatherFourth];
    
    //图片
    fourthImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"storm.png"]];
    [fourthImgView setFrame:CGRectMake(lbFutureWeatherFourth.frame.origin.x+10, lbFutureWeatherFourth.frame.origin.y+lbFutureWeatherFourth.frame.size.height+offsetGap,imgWidth, imgHeight)];
    [obj addSubview:fourthImgView];
    
    //温度
    lblFutureWeatherTempFourth = [[UILabel alloc] init];
    [lblFutureWeatherTempFourth setBackgroundColor:[UIColor clearColor]];
    [lblFutureWeatherTempFourth setTextColor:[UIColor whiteColor]];
    [lblFutureWeatherTempFourth setTextAlignment:NSTextAlignmentCenter];
    [lblFutureWeatherTempFourth setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [lblFutureWeatherTempFourth setFrame:CGRectMake(20+lblFutureWeatherTempFirst.frame.size.width+lblFutureWeatherTempSecond.frame.size.width+lblFutureWeatherTempThird.frame.size.width, secondImgView.frame.origin.y+secondImgView.frame.size.height, 70, 12)];
    [lblFutureWeatherTempFourth setText:@"25℃"];
    [obj addSubview:lblFutureWeatherTempFourth];
}

@end
