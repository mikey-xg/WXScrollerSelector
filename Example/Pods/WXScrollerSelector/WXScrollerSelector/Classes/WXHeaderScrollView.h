//
//  WXHeaderScrollView.h
//  PlayerDemo
//
//  Created by 苏文潇 on 2020/11/6.
//  Copyright © 2020 we_shell. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface WXNewHomeViewHeaderConfig: NSObject

@property (nonatomic, assign) BOOL allow_scroll;     ///<是否允许滚动  - 默认 YES -允许滚动
@property (nonatomic, assign) NSInteger selecte_row; ///<默认选中哪一个  - 默认 0

// MARK: - 导航视图相关
@property (nonatomic, assign) BOOL lineview_is_display;       ///<是否展示底部 线条  - 默认 NO - 不显示
@property (nonatomic, strong) UIColor *lineview_color;        ///<底部线条颜色  - 默认orangeColor
@property (nonatomic, assign) CGSize lineview_size;           ///<底部线条 size  - 默认(40, 4)
@property (nonatomic, assign) CGFloat lineview_corner_radius; ///< 底部线条 圆角大小  - 默认 4/2=2
@property (nonatomic, assign) CGFloat lineview_place;         ///< 底部线条 相对按钮视图垂直间隔  -默认 4

// MARK: - 按钮视图相关
@property (nonatomic, strong) UIColor *button_background;     ///< 按钮 背景颜色  - 默认 ClearColor
@property (nonatomic, strong) UIColor *button_selected_color; ///< 按钮 选中颜色  - 默认 redColor
@property (nonatomic, strong) UIColor *button_normal_color;   ///< 按钮 正常状态颜色  - 默认 blackColor

@property (nonatomic, assign) CGFloat button_corner_radius;   ///< 按钮 圆角大小  - 默认 0 - 无圆角
@property (nonatomic, assign) CGFloat button_height;          ///< 视图 高度  - 默认 30
@property (nonatomic, assign) CGFloat button_place;           ///< 视图 间距  - 默认 10
@property (nonatomic, assign) CGFloat button_content_place;   ///< 视图 内容间距  - 默认 10

@property (nonatomic, strong) UIFont *button_normal_font;     ///< 按钮 默认字体  - 默认 系统字体: 18号
@property (nonatomic, strong) UIFont *button_select_font;     ///< 按钮 选中字体  - 默认 系统加粗字体: 18号

@end

@protocol WXHeaderScrollViewDelegate <NSObject>

/// 点击视图回传消息
/// @param currentTag 点击当前第几个按钮
/// @param views  WXHeaderScrollView 对象
- (void)selectCurrentBtnTags:(NSInteger)currentTag toView:(UIView *)views;

@end

@interface WXHeaderScrollView : UIView

- (instancetype)initWithTitleArr:(NSArray<NSString *> *)titleArray frame:(CGRect)frame;

/// 配置指示器 参数
/// @param config config
- (void)configStyle:(WXNewHomeViewHeaderConfig *)config;

@property (nonatomic, weak) id<WXHeaderScrollViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
