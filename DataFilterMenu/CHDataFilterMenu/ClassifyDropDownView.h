//
//  ClassifyDropDownView.h
//  ClassifyView
//
//  Created by 陈楠 on 17/5/11.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyDropDownView : UIView

@property (nonatomic,strong)NSArray *dataArray;//显示文字数据
@property (nonatomic, copy) void(^ClassifyViewBlock)(NSInteger index);
@property (nonatomic, copy) void(^ClassifyActionBlock)(NSInteger index,NSString *text);
@property (assign, nonatomic)NSInteger currentIndex;// 当前选中

- (void)dismissView;
- (void)show;
@end

@interface ClassifyDropDownCell : UITableViewCell

@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UIImageView       *selectImgView;//选中图标

@end
