//
//  ClassifyView.h
//  ClassifyView
//
//  Created by 陈楠 on 17/5/11.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ML_Button.h"
#import "ClassifyDropDownView.h"
@class ClassifyView;
@protocol ClassifyViewDelegate <NSObject>


- (void)classifyView:(ClassifyView *)classifyView integerWithfirst:(NSInteger)index integerWithTwo:(NSInteger)detailIndex;

@end

@interface ClassifyView : UIView
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
