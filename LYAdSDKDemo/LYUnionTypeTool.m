//
//  LYUnionTypeTool.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/9/12.
//

#import "LYUnionTypeTool.h"

@implementation LYUnionTypeTool
+ (NSString *)unionName4unionType:(LYAdSdkUnionType)unionType {
    switch (unionType) {
        case LYAdSdkUnionTypeUnknown:
            return @"未知";
        case LYAdSdkUnionTypeADX:
            return @"乐游";
        case LYAdSdkUnionTypeGDT:
            return @"广点通";
        case LYAdSdkUnionTypeCSJ:
            return @"穿山甲";
        case LYAdSdkUnionTypeBaidu :
            return @"百度";
        case LYAdSdkUnionTypeKS:
            return @"快手";
        case LYAdSdkUnionTypeSIG:
            return @"sigmob";
        case LYAdSdkUnionTypeIQY:
            return @"爱奇艺";
        case LYAdSdkUnionTypeJD:
            return @"京东";
        default:
            return @"未知";
    }
}
@end
