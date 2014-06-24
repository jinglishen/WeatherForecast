//
//  CItyXML.m
//  WeatherForecast
//
//  Created by geek-group on 14-6-23.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import "CityXML.h"
#import "City.h"

static CityXML *instance;

@implementation CityXML
@synthesize cities, hotCity, nomalCity;

+(CityXML *)sharedInstaced
{
    if(instance==nil)
    {
        instance=[[CityXML alloc] init];
    }
    return instance;
}

#pragma mark 加载城市XML
- (NSMutableArray *)loadXML
{
    cities = [[NSMutableArray alloc]init];
    NSURL *path = [[NSBundle mainBundle]URLForResource:@"city" withExtension:@"xml"];
    NSData *date = [[NSData alloc]initWithContentsOfURL:path];
    NSXMLParser *xmlPareser = [[NSXMLParser alloc]initWithData:date];
    xmlPareser.delegate = self;
    //初始化热门城市列表
    hotCity = [NSMutableArray array];
    //初始化普通城市列表
    nomalCity = [NSMutableArray array];
    
    NSLog(@"parse start");
    if ([xmlPareser parse]) {
//        [NSThread detachNewThreadSelector:@selector(parserLetter) toTarget:self withObject:nil];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [cities addObject:hotCity];
            [cities addObject:nomalCity];
            [self parserLetter];
        });
        
        NSLog(@"City parse success!!!");
    }else
    {
        NSLog(@"City parse faild!!!");
    }
    return cities;
}

#pragma mark 获取全国城市信息
- (NSMutableArray *)getCities
{
    return cities;
}

#pragma mark 读取节点内容
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //获取county节点下面的城市数据
    if ([elementName isEqualToString:@"county"]) {
        City *city = [[City alloc]initWithCityName:attributeDict[@"name"] cityID:attributeDict[@"id"] weatherCode:attributeDict[@"weatherCode"]];
        //NSLog(@"%@", [city.cityID substringWithRange:NSMakeRange(2,2)]);
        if ([[city.cityID substringWithRange:NSMakeRange(2,2)] isEqualToString:@"01"] && [[city.cityID substringFromIndex:4] isEqualToString:@"01"]) {
            [hotCity addObject:city];
        }else{
            [nomalCity addObject:city];
        }
        //[cities addObject:city];
    }
}

#pragma mark 把城市名称转化为拼音并进行排序
- (void)parserLetter
{
    for (City *item in cities[0]) {
        //判断当前当前城市拼音是否转换完成
        if ([item.cityLetter isEqualToString:@""]) {
            //汉字转拼音，比较排序时候用
            NSMutableString *ms = [[NSMutableString alloc] initWithString:item.cityName];
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            }
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
                //把读取到的城市信息添加到城市数组中
                for (NSString *str in [ms componentsSeparatedByString:@" "]) {
                    [item.cityLetter appendString:[str substringToIndex:1]];
                }
            }
        }
    }
    NSLog(@"the first array parserd!!!");
    for (City *item in cities[1]) {
        //判断当前当前城市拼音是否转换完成
        if ([item.cityLetter isEqualToString:@""]) {
            //汉字转拼音，比较排序时候用
            NSMutableString *ms = [[NSMutableString alloc] initWithString:item.cityName];
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            }
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
                //把读取到的城市信息添加到城市数组中
                for (NSString *str in [ms componentsSeparatedByString:@" "]) {
                    [item.cityLetter appendString:[str substringToIndex:1]];
                }
            }
        }
    }
    NSLog(@"the second array parserd!!!");
    NSLog(@"sorte start!!!");
    //给转换好的城市进行排序
    cities[0] = [[cities[0] sortedArrayUsingFunction:nickNameSort context:NULL] mutableCopy];
    NSLog(@"the first array sorted!!!");
    cities[1] = [[cities[1] sortedArrayUsingFunction:nickNameSort context:NULL] mutableCopy];
    NSLog(@"the second array sorted!!!");
    NSLog(@"citiesCout[0] = %i", [cities[0] count]);
    NSLog(@"citiesCout[1] = %i", [cities[1] count]);
}

#pragma mark 按字母排序方法
NSInteger nickNameSort(id user1, id user2, void *context)
{
    City *u1,*u2;
    //类型转换
    u1 = (City*)user1;
    u2 = (City*)user2;
    return  [u1.cityLetter localizedCompare:u2.cityLetter];
}


@end
