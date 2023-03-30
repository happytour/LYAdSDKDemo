//
//  LYDActionCellView.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2023/3/27.
//

#import "LYDActionCellView.h"

#define inconWidth 28

@implementation LYDPlainTitleActionModel

@end

@implementation LYDActionModel (LYDModelFactory)

+ (instancetype)plainTitleActionModel:(NSString *)title type:(LYDCellType)type action:(ActionCommandBlock)action {
    LYDPlainTitleActionModel *model = [LYDPlainTitleActionModel new];
    model.title = title;
    model.cellType = type;
    model.action = [action copy];
    return model;
}

@end


@interface LYDActionCellView ()
@property (nonatomic, strong) LYDPlainTitleActionModel *model;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *titleLable;
@end

@implementation LYDActionCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.img = [UIImageView new];
        self.img.frame = CGRectMake(15, (self.frame.size.height - inconWidth)/2, inconWidth , inconWidth);
        [self.contentView addSubview:self.img];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(inconWidth + self.img.frame.origin.x + 15, self.img.frame.origin.y, 300, inconWidth)];
//        self.titleLable.textColor =BUD_RGB(0x8a, 0x8a, 0x89);
        [self.contentView addSubview:self.titleLable];
    }
    return self;
}

- (void)configWithModel:(LYDPlainTitleActionModel *)model {
    if ([model isKindOfClass:[LYDPlainTitleActionModel class]]) {
        self.model = model;
        self.titleLable.text = self.model.title;
        NSString *imageString = nil;
        switch (model.cellType) {
            case LYDCellType_normal:
                imageString = @"demo_ad.png";
                break;
            case LYDCellType_setting:
                imageString = @"demo_settings.png";
                break;
            case LYDCellType_export:
                imageString = @"demo_export.png";
                break;
            case LYDCellType_init:
                imageString = @"demo_init.png";
                break;
            default:
                imageString = @"demo_ad.png";
                break;
        }
        self.img.image = [UIImage imageNamed:imageString];
    }
}

- (void)execute {
    if (self.model.action) {
        self.model.action();
    }
}

@end
