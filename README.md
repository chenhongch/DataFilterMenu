# DataFilterMenu
数据筛选菜单

### 1. 效果图
![classView1](https://github.com/chenhongch/DataFilterMenu/blob/master/image/classView1.gif)
### 2. 代码

```
@interface ClassifyView : UIView

/**
 下拉选择视图
 */
@property (nonatomic, retain) ClassifyDropDownView *dorpView;

/**
 显示文字数字
 */
@property (nonatomic, retain)NSArray *btnTextList;
/**
 未选择时默认图片数组
 */
@property (nonatomic, retain)NSArray *btnDefaultImages;
/**
 选中时显示图片数组
 */
@property (nonatomic, retain)NSArray *btnselectImages;
/**
 选中时反向显示图片数组
 */
@property (nonatomic, retain)NSArray *btnDefultWithselectImages;
/**
 默认NO 自带下拉选择view 
 */
@property (nonatomic, assign)BOOL systemDropDownView;

/**
 恢复默认状态
 */
@property (nonatomic, assign)BOOL reset;





/**
 点击事件Block回调 （ index:第一级位置  如果有二级选择页面  detailIndex:二级位置(0--->向上 1--->向下) 多种选择默认从0开始）
 */
@property (nonatomic, copy) void(^ClassifyViewBlock)(NSInteger index,NSInteger detailIndex);
/**
 点击事件delegate代理
 */
@property (nonatomic, assign)id<ClassifyViewDelegate> delegate;


@end

```

