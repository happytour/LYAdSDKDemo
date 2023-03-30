//
//  LYDActionCellView.h
//  LYAdSDKDemo
//
//  Created by laole918 on 2023/3/27.
//

#import <UIKit/UIKit.h>
#import "LYDActionCellDefine.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LYDCellType) {
    LYDCellType_normal            = 0,       // non ad
    LYDCellType_setting           = 1,       // setting
    LYDCellType_export            = 2,       // export
    LYDCellType_init              = 3,       // init
};

@interface LYDActionModel (LYDModelFactory)
+ (instancetype)plainTitleActionModel:(NSString *)title type:(LYDCellType)type action:(ActionCommandBlock)action;
@end

@interface LYDPlainTitleActionModel : LYDActionModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) LYDCellType cellType;
@end

@interface LYDActionCellView : UITableViewCell <LYDActionCellConfig, LYDCommandProtocol>

@end

NS_ASSUME_NONNULL_END
