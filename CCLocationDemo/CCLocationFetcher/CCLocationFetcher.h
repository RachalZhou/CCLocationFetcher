//
//  CCLocationFetcher.h
//  Created by Rachal Zhou.
//  Copyright © 2018年 RachalPersonal. All rights reserved.
//

/* 方法一（推荐）：
 * 直接用单例初始化对象并调用star方法即可，随用随调。
 * [[CCLocationFetcher sharedInstance] startWithCompletionHandler:];
 * 返回LocationModel对象，所需信息可直接用点语法调用，如：location.city、location.address
 */

/* 方法二：
 * 传统init一个对象，然后调startWithCompletionHandler:方法，对象必须设置成属性或全局变量。
 * _fetcher = [[CCLocationFetcher alloc] init];
 * [_fetcher startWithCompletionHandler:];
 * 返回LocationModel对象，所需信息可直接用点语法调用，如：location.city、location.address
 */

#import <Foundation/Foundation.h>

@class LocationModel;

typedef void(^LocationFetcherCompletionHandler)(LocationModel *location);

@interface CCLocationFetcher : NSObject

+ (instancetype)sharedInstance;

- (void)startWithCompletionHandler:(LocationFetcherCompletionHandler)completion;

@end



#pragma mark - 位置数据模型
@interface LocationModel : NSObject

@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *subCity;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *address;

@end
