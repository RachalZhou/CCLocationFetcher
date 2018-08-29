//
//  CCLocationFetcher.m
//  Created by Rachal Zhou.
//  Copyright © 2018年 RachalPersonal. All rights reserved.
//

#import "CCLocationFetcher.h"
#import <CoreLocation/CoreLocation.h>
#import "NSObject+Model.h"

@interface CCLocationFetcher()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) LocationFetcherCompletionHandler completionHandler;

@end

@implementation CCLocationFetcher {
    NSUInteger _locationAge;//定位次数(避免重复定位)
}

//单例
+ (instancetype)sharedInstance {
    static CCLocationFetcher *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCLocationFetcher alloc] init];
    });
    return sharedInstance;
}

//初始化
- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0;
        _locationManager.delegate = self;
        
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

//开始
- (void)startWithCompletionHandler:(LocationFetcherCompletionHandler)completion {
    self.completionHandler = completion;
    
    _locationAge = 0;
    [_locationManager startUpdatingLocation];
}

//完成
- (void)locateCompleted:(LocationModel *)location {
    if (_completionHandler) {
        _completionHandler(location);
    }
    self.completionHandler = nil;//定位成功后销毁（避免产生保留环）
}

#pragma mark - CLLocationDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [_locationManager stopUpdatingLocation];//结束定位
    
    if (_locationAge != 0) return;
    
    //反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //将字典转为模型
        NSDictionary *dic = [self getInfoWithPlacemark:placemarks[0]];
        LocationModel *model = [LocationModel modelWithDictionary:dic];
        
        [self locateCompleted:model];
    }];
    
    _locationAge ++;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"错误：拒绝定位");
    }else if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"错误：无法获取定位");
    }else {
        NSLog(@"%@",error.localizedDescription);
    }
}

#pragma mark - 整理位置信息
- (NSDictionary *)getInfoWithPlacemark:(CLPlacemark *)placemark {
    
    // 经纬度
    CLLocationCoordinate2D coordinate = placemark.location.coordinate;
    NSString *longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    
    // 省/市/县(区)/街道/详细地址
    NSString *province = placemark.administrativeArea;
    NSString *city = placemark.locality;
    province = province ? province : placemark.locality;//若省不存在则为直辖市
    NSString *subCity = placemark.subLocality;
    NSString *street = placemark.addressDictionary[@"Street"];
    
    NSString *address;
    if ([province isEqualToString:city]) {
        address = [NSString stringWithFormat:@"%@%@%@",city,subCity,street];
    }else {
        address = [NSString stringWithFormat:@"%@%@%@%@",province,city,subCity,street];
    }
    
    NSDictionary *dic = @{@"longitude":longitude,
                          @"latitude" :latitude,
                          @"province" :province,
                          @"city"     :city,
                          @"subCity"  :subCity,
                          @"street"   :street,
                          @"address"  :address};
    return dic;
}

@end



#pragma mark - 定位数据模型
@implementation LocationModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
