//
//  DemoLogOperation.h
//  DemoCommon
//
//  Created by jie cai on 2022/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoLogOperation : NSObject

+ (instancetype)shareLogOperation;

- (void)beginToWriteLog:(NSString *)scene;

- (void)writeLog:(NSString *)content;

- (void)endToWriteLog:(NSString *)scene;

- (NSArray<NSString *> *)listPathDemoLogs;

- (NSString *)fullPathOfLogfile:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
