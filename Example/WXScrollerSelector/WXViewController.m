//
//  WXViewController.m
//  WXScrollerSelector
//
//  Created by 714350220@qq.com on 11/09/2020.
//  Copyright (c) 2020 714350220@qq.com. All rights reserved.
//

#import "WXViewController.h"
#import <WXScrollerSelector/WXHeaderScrollView.h>


@interface WXViewController () <WXHeaderScrollViewDelegate>

@property (nonatomic, strong)WXHeaderScrollView *headView;

@end

@implementation WXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *tempArr = @[@"Ha",@"Math", @"Chinese", @"Lei", @"English", @"Biology", @"Physics", @"Chemistry", @"History", @"Geography", @"Politics"];
    self.headView = [[WXHeaderScrollView alloc] initWithTitleArr:tempArr frame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 60)];
    self.headView.delegate = self;
    self.headView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.headView];
    
    [self config];
}

/// 配置样式
- (void)config {
    WXNewHomeViewHeaderConfig *config = [[WXNewHomeViewHeaderConfig alloc] init];
    
    config.selecte_row = 6;
    config.allow_scroll = YES;
    
    config.lineview_is_display = YES;
    config.lineview_color = [UIColor redColor];
    
    config.button_background = [UIColor cyanColor];
    config.button_corner_radius = 8;
    
    [self.headView configStyle:config];
}

// MARK: - WXHeaderScrollViewDelegate
- (void)selectCurrentBtnTags:(NSInteger)currentTag toView:(UIView *)views {
    NSLog(@"点击了%@视图 选中的第%zd个按钮", [views class],currentTag);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
