
/**
 *  字典、数组转模型(KVC)
 */
#import "NSObject+Model.h"

@implementation NSObject (Model)

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
    
    id obj = [[[self class] alloc] init];
    [obj setValuesForKeysWithDictionary:dic];
    return obj;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    
    NSMutableArray *objs = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        
        id obj = [[self class] modelWithDictionary:dic];
        [objs addObject:obj];
    }
    return objs;
}

@end
