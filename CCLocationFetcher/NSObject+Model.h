
/**
 *  字典、数组转模型
 */
#import <Foundation/Foundation.h>

@interface NSObject (Model)

/**
 *  字典转模型，返回模型对象
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

/**
 *  数组转模型，返回模型数组
 */
+ (NSArray *)modelWithArray:(NSArray *)array;

@end
