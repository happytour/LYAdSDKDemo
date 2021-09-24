//
//  LYDrawVideoAdCell.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYDrawVideoAdCell.h"

@interface LYDrawVideoAdCell ()

@property (nonatomic, weak) LYDrawVideoAdRelatedView *relatedView;

@end

@implementation LYDrawVideoAdCell

- (void)refreshWithDrawVideoAdRelatedView:(LYDrawVideoAdRelatedView *)relatedView {
    self.relatedView = relatedView;
    [self.relatedView registerContainer:self.contentView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.relatedView unregisterView];
}

@end
