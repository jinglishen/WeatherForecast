//
//  WeatherCommand.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-24.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface WeatherCommand : NSObject<ASIHTTPRequestDelegate>

/**
 *  通过IP获取当前所在的的城市WeatherID
 *
 *  @return 返回获取到的weatherID
 */
- (NSString *)autoGetCityWeatherID;

- (void)getWeatherInfo:(NSString *)weatherID;

@end
