//
//  LYDDrawVideoAdCell.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYDDrawVideoAdCell.h"

@interface LYDDrawVideoAdCell ()

@property (nonatomic, weak) LYDrawVideoAdRelatedView *relatedView;

@end

@implementation LYDDrawVideoAdCell

- (void)refreshWithDrawVideoAdRelatedView:(LYDrawVideoAdRelatedView *)relatedView {
    self.relatedView = relatedView;
    [self.relatedView registerContainer:self.contentView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.relatedView unregisterView];
}

@end
