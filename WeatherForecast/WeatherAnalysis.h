//
//  WeatherAnalysis.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-25.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherAnalysis : NSObject

+(WeatherAnalysis *)sharedInstaced;

-(NSString *)urlWeatherByCityID:(NSString *)cityID;

-(NSMutableArray *)getWeatherInfo:(NSDictionary *)paramDict;

@end
