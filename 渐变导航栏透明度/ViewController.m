//
//  ViewController.m
//  渐变导航栏透明度
//
//  Created by  wuhiwi on 16/8/31.
//  Copyright © 2016年 wanglibank. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+Background.h"
#import "TableViewBgView.h"

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define kNavigationTopHeight 64.0
#define kTableViewReuseidentifier @"kTableViewReuseidentifier"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar hwSetBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
    
    TableViewBgView *bgView = [[TableViewBgView alloc] init];
    bgView.bgImage = [UIImage imageNamed:@"scenery"];
    _tableView.backgroundView = bgView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//导航栏的背景色是黑色, 字体为白色
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//用于去除导航栏的底线，也就是周围的边线
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar hwResetBackgroundColor];
}

#pragma mark - setter getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
//        _tableView.bounces = NO;  
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.contentInset = UIEdgeInsetsMake(kScreenHeight / 5, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewReuseidentifier];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewReuseidentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%lu=====%lu",indexPath.section,indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = [UIColor blueColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > - kScreenHeight / 5 - kNavigationTopHeight) {
        CGFloat alpha = MIN(1, (kScreenHeight / 5 + offsetY + kNavigationTopHeight) / (kScreenHeight / 5));
        [self.navigationController.navigationBar hwSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
    }else
    {
        [self.navigationController.navigationBar hwSetBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

@end
