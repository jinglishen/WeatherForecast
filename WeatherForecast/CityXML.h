//
//  CItyXML.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-23.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityXML : NSObject<NSXMLParserDelegate>

@property (nonatomic) NSMutableArray *cities;//全国城市详细信息
@property (nonatomic) NSMutableArray *hotCity;//热门城市
@property (nonatomic) NSMutableArray *nomalCity;//普通城市

/**
 *  读取全国城市XML文件
 *
 *  @return 返回全国城市详细信息
 */
- (NSMutableArray *)loadXML;

/**
 *  获取全国城市信息
 *
 *  @return 全国城市信息
 */
- (NSMutableArray *)getCities;

@end
