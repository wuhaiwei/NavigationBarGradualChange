//
//  TableViewBgView.m
//  渐变导航栏透明度
//
//  Created by  wuhiwi on 16/9/1.
//  Copyright © 2016年 wanglibank. All rights reserved.
//

#import "TableViewBgView.h"

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface TableViewBgView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation TableViewBgView
#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self addSubview:self.imageView];
    [self addSubview:self.bottomView];
    return self;
}

#pragma mark - setter getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 250, kScreenWidth, 250)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}


- (void)setBgImage:(UIImage *)bgImage
{
    if (![_bgImage isEqual:bgImage]) {
        _imageView.image = bgImage;
        CGSize imageSize = bgImage.size;
        CGFloat imageHeight = kScreenWidth * imageSize.height / imageSize.width;
        _imageView.frame = CGRectMake(0, 0, kScreenWidth, imageHeight);
    }
}

@end
