# WXScrollerSelector 简介

可滑动选择器小组件

## Example

```
// 默认创建 -- 不包含底部指示导航条
NSArray *tempArr = @[@"Math", @"Chinese", @"English", @"Biology", @"Physics", @"Chemistry", @"History", @"Geography", @"Politics"];

WXHeaderScrollView *headView = [[WXHeaderScrollView alloc] initWithTitleArr:tempArr frame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 60)];
headView.delegate = self;
headView.backgroundColor = [UIColor orangeColor];
[self.view addSubview:headView];


// 使用配置信息进行创建
WXHeaderScrollView *headView1 = [[WXHeaderScrollView alloc] initWithTitleArr:tempArr frame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 60)];
headView1.delegate = self;
headView1.backgroundColor = [UIColor orangeColor];
[self.view addSubview:headView1];
 // 创建配置类型
WXNewHomeViewHeaderConfig *config = [[WXNewHomeViewHeaderConfig alloc] init];
config.selecte_row = 6;
config.allow_scroll = YES;
config.lineview_is_display = YES;
config.lineview_color = [UIColor redColor];
config.button_background = [UIColor cyanColor];
config.button_corner_radius = 8;
[headView1 configStyle:config];

```
## 展示样式
![000.png](https://upload-images.jianshu.io/upload_images/3963044-a98f0b26f22082aa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![001.png](https://upload-images.jianshu.io/upload_images/3963044-b83aa5199191edbf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 安装 方式
```
pod 'WXScrollerSelector'
```
## Author

714350220@qq.com 

## License

WXScrollerSelector is available under the MIT license. See the LICENSE file for more info.
