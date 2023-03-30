//
//  LYDActionCellDefine.h
//  LYAdSDKDemo
//
//  Created by laole918 on 2023/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActionCommandBlock)(void);

@protocol LYDCommandProtocol <NSObject>
- (void)execute;
@end

@interface LYDActionModel : NSObject
@property (nonatomic, copy) ActionCommandBlock action;
@end

@protocol LYDActionCellConfig <NSObject>
- (void)configWithModel:(LYDActionModel *)model;
@end

NS_ASSUME_NONNULL_END
