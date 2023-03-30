//
//  DemoLogOperation.m
//  DemoCommon
//
//  Created by jie cai on 2022/3/8.
//

#import "DemoLogOperation.h"

@interface DemoLogOperation ()

@property (nonatomic, strong)NSFileHandle *toFileHandle;
@property (nonatomic, strong) dispatch_queue_t writeQueue;

@end

@implementation DemoLogOperation

+ (instancetype)shareLogOperation {
    static DemoLogOperation *shareDemoLog;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        shareDemoLog = [DemoLogOperation new];
    });
    return shareDemoLog;
}

- (instancetype)init {
    if (self = [super init]) {
        ///检验文件夹
        if (![self isExistsAtPath:self.directoryOfDemoLog]) {
            [self createDirectoryAtPath:self.directoryOfDemoLog error:nil];
        }
        /// 日期文件名
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *logFileName = [NSString stringWithFormat:@"%@-DemoLog.txt",[dateFormatter stringFromDate:now]];
        NSString *logFilePath = [self.directoryOfDemoLog stringByAppendingPathComponent:logFileName];
        if (![self isExistsAtPath:logFilePath]) {
            [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
        }
        _toFileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        if (!_toFileHandle) {
            NSLog(@"_toFileHandle error");
        }
        _writeQueue = dispatch_queue_create("DemoLog.write.queue", 0);
    }
    return self;
}

- (NSString *)directoryOfDemoLog {
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"DemoLogs"];
}

- (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isSuccess = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    return isSuccess;
}

- (void)beginToWriteLog:(NSString *)scene {
    NSString *beginString = [NSString stringWithFormat:@"----------Begin:%@(%@)----------\n",scene,[self dateID:nil]];
    
    [self asyncToWriteLog:beginString];
}

- (void)writeLog:(NSString *)content {
    NSDate *date = [NSDate date];
    NSString *logString = [NSString stringWithFormat:@"D|callbackLog|%@|%ld|%@",content,(NSInteger)([date timeIntervalSince1970] * 1000),[self dateID:date]];
    NSLog(@"%@",logString);
    [self asyncToWriteLog:logString];
}

- (void)endToWriteLog:(NSString *)scene {
    NSString *endString = [NSString stringWithFormat:@"----------End:%@(%@)----------\n",scene,[self dateID:nil]];
    [self asyncToWriteLog:endString];
}

- (NSArray<NSString *> *)listPathDemoLogs {
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *shallowArr = [manager contentsOfDirectoryAtPath:self.directoryOfDemoLog error:&error];
    if (!error) {
        return shallowArr;;
    }else {
        NSLog(@"listPathDemoLogs error -- %@",error);
        return nil;;
    }
}

- (NSString *)fullPathOfLogfile:(NSString *)fileName {
    return [self.directoryOfDemoLog stringByAppendingPathComponent:fileName];
}

- (NSString *)dateID:(NSDate *)current {
    NSDate *now = current ?: [NSDate date];
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
    }
    return [dateFormatter stringFromDate:now];;
}

- (void)asyncToWriteLog:(NSString *)log {
    if(log.length == 0) return;
    __weak typeof(self) weak_self = self;
    dispatch_async(_writeQueue, ^{
        [weak_self.toFileHandle seekToEndOfFile];
        NSData *data = [log dataUsingEncoding:NSUTF8StringEncoding];
        [weak_self.toFileHandle writeData:data];
    });
}

@end
