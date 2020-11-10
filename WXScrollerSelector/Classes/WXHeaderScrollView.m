//
//  WXHeaderScrollView.m
//  PlayerDemo
//
//  Created by 苏文潇 on 2020/11/6.
//  Copyright © 2020 we_shell. All rights reserved.
//

#import "WXHeaderScrollView.h"

#define TagValue 1000           // 按钮 tag

@implementation WXNewHomeViewHeaderConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

/// 初始化
- (void)config {
    
    self.allow_scroll = YES;
    self.selecte_row = 0;
    
    self.lineview_is_display = NO;
    self.lineview_color = [UIColor redColor];
    self.lineview_place = 4;
    self.lineview_size = CGSizeMake(40, 4);
    self.lineview_corner_radius = self.lineview_size.height/2;
    
    self.button_background = [UIColor clearColor];
    self.button_selected_color = [UIColor redColor];
    self.button_normal_color = [UIColor blackColor];
    
    self.button_corner_radius = 0;
    self.button_height = 30;
    
    self.button_place = 10;
    self.button_content_place = 20;
    self.button_normal_font = [UIFont systemFontOfSize:18];
    self.button_select_font = [UIFont boldSystemFontOfSize:18];
}

@end


@interface WXHeaderScrollView() // <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btn_view_array; // 按钮视图集合
@property (nonatomic, strong) UIView *lineView;                           // 导航视图
@property (nonatomic, strong) WXNewHomeViewHeaderConfig *config;   // 状态配置

@end

@implementation WXHeaderScrollView {
    NSArray *_temp_btn_arr;
}

- (instancetype)initWithTitleArr:(NSArray<NSString *> *)titleArray frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = [[WXNewHomeViewHeaderConfig alloc] init];
        self.btn_view_array = [NSMutableArray array];
        _temp_btn_arr = titleArray;
        
        [self setUI];
    }
    return self;
}

- (void)configStyle:(WXNewHomeViewHeaderConfig *)config {
    self.config = config;
    if (self.btn_view_array.count > 0) {
        for (UIButton *btn in self.btn_view_array) {
            [btn removeFromSuperview];
        }
        [self.btn_view_array removeAllObjects];
    }
    [self addBtnView];
}

- (void)setUI {
    [self addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addBtnView];
}

/// 按钮视图
- (void)addBtnView {
    self.scrollView.scrollEnabled = self.config.allow_scroll;
    CGFloat l_w = 0.0; CGFloat l_h = 0.0;
    CGFloat h = self.config.button_height; // 高
    CGFloat y = (self.scrollView.bounds.size.height - h) / 2; // y 坐标
    CGFloat p = self.config.button_place; // 控件间距
    CGFloat lr = self.config.button_content_place; // 控件内容间距
    CGFloat l_p = self.config.lineview_place;
    UIFont *font = self.config.button_normal_font; // 字体大小
    BOOL display_line_view = self.config.lineview_is_display;
    UIButton *select_btn; // 默认选中的按钮
    UIView *temp_view = [UIView new];
    
    if (display_line_view){
        l_w = self.config.lineview_size.width;  // 线条 宽
        l_h = self.config.lineview_size.height; // 线条 高
        y = (self.scrollView.bounds.size.height - (h+l_p+l_h)) / 2;
        [self.scrollView addSubview:self.lineView];
    }
    
    for (int i = 0; i < _temp_btn_arr.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.tag = i + TagValue;
        [button setTitle:_temp_btn_arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if (self.config.button_corner_radius > 0) {
            button.layer.cornerRadius = self.config.button_corner_radius;
            button.layer.masksToBounds = YES;
        }
        button.backgroundColor = self.config.button_background;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [self.btn_view_array addObject:button];

        CGSize temp_size = [self sizeWithFontCompatible:font text:_temp_btn_arr[i]];
        if (i == 0) {
            button.frame =  CGRectMake(p, y, temp_size.width + lr, h);
            if (display_line_view) {
                self.lineView.frame = CGRectMake(p+(button.bounds.size.width - l_w)/2, y+h+l_p, l_w, l_h);
            }
        } else {
            button.frame = CGRectMake(temp_view.frame.origin.x + temp_view.bounds.size.width + 2*p, y, temp_size.width + lr, h);
            if (self.config.selecte_row != 0 && i == self.config.selecte_row) {
                select_btn = button;
                if (display_line_view) {
                    CGFloat line_x = button.frame.origin.x + (button.bounds.size.width - l_w)/2;
                    self.lineView.frame = CGRectMake(line_x, y+h+l_p, l_w, l_h);
                }
            }
        }
        temp_view = button;
        
    }
    CGSize scroll_content = CGSizeMake(temp_view.frame.origin.x + temp_view.bounds.size.width + p, self.bounds.size.height);
    self.scrollView.contentSize = scroll_content;
    if (self.config.selecte_row != 0 && select_btn) {
        [self scorllview_scrolrect:select_btn];
        [self btnClick:select_btn];
    } else {
        if (self.btn_view_array.firstObject) {
            [self btnClick:self.btn_view_array.firstObject];
        }
    }
}

/// 按钮 点击事件
- (void)btnClick: (UIButton *)btn {
    if (btn.isSelected) return;
    [self change_button_config:btn];
    [self scorllview_scrolrect:btn];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCurrentBtnTags:toView:)]) {
        [self.delegate selectCurrentBtnTags:btn.tag - TagValue toView:self];
    }
}

/// 改变按钮 参数配置
- (void)change_button_config:(UIButton *)btn {
    for (UIButton *button in [self.btn_view_array copy]) {
        if (btn.tag == button.tag) {
            [button setSelected:YES];
            button.titleLabel.font = self.config.button_select_font;
        } else {
            [button setSelected:NO];
            button.titleLabel.font = self.config.button_normal_font;
        }
    }
}

/// 计算字体大小
- (CGSize)sizeWithFontCompatible:(UIFont *)font text:(NSString *)text {
    NSDictionary *dictionaryAttributes = @{NSFontAttributeName:font};
    CGSize stringSize = [text sizeWithAttributes:dictionaryAttributes];
    return CGSizeMake(ceil(stringSize.width), ceil(stringSize.height));
}

/// 根据点击按钮，移动scrollView
- (void)scorllview_scrolrect:(UIButton *)btn {
    if (!self.config.allow_scroll) return;
    CGFloat btnX = btn.frame.origin.x;
    CGFloat btnY = btn.frame.origin.y;
    CGFloat btnW = btn.frame.size.width;
    CGFloat btnH = btn.frame.size.height;
    
    CGFloat main_Y = [UIScreen mainScreen].bounds.size.width/2;
    CGFloat scr_W = self.scrollView.bounds.size.width;
    CGFloat scr_H = self.scrollView.bounds.size.height;
    
    if (btnX > main_Y) {
        [self.scrollView scrollRectToVisible:CGRectMake(btnX+btnW/2-main_Y, btnY, scr_W, scr_H) animated:YES];
    } else {
        [self.scrollView scrollRectToVisible:CGRectMake(0, btnY, scr_W, scr_H) animated:YES];
    }
    
    if (self.config.lineview_is_display) {
        [UIView animateWithDuration:0.25 animations:^{
            self.lineView.frame = CGRectMake(btnX+(btnW-self.config.lineview_size.width)/2, btnY+btnH+self.config.lineview_place, self.config.lineview_size.width, self.config.lineview_size.height);
            [self.lineView layoutIfNeeded];
        }];
    }
}

// MARK: - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"==== %@", NSStringFromCGPoint(scrollView.contentOffset));
//}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"Dragging begin");
//}
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset API_AVAILABLE(ios(5.0)){
//    NSLog(@"Dragging WillEnd");
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"Dragging End");
//}

// MARK: - 控件
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.bounds.size.height);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = self.config.lineview_color;
        if (self.config.lineview_corner_radius > 0) {
            _lineView.layer.cornerRadius = self.config.lineview_corner_radius;
            _lineView.layer.masksToBounds = YES;
        }
    }
    
    return _lineView;
}
@end
