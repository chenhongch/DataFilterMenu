

//
//  ClassifyDropDownView.m
//  ClassifyView
//
//  Created by 陈楠 on 17/5/11.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "ClassifyDropDownView.h"
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 屏幕尺寸
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface ClassifyDropDownView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;

@end

@implementation ClassifyDropDownView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        //蒙版
        UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        coverBtn.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        coverBtn.backgroundColor = RGBA(0, 0, 0, 0.3);
        [coverBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverBtn];
        
        
        UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, frame.size.height) style:UITableViewStylePlain];
        table.userInteractionEnabled=YES;
        table.delegate=self;
        table.dataSource=self;
        table.backgroundColor=[UIColor clearColor];
        [self addSubview:table];
        self.tableView = table;
    }
    return self;
}


#pragma mark--uitableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ClassifyDropDownCell";
    ClassifyDropDownCell *cell = (ClassifyDropDownCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ClassifyDropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.titleLab.text =[_dataArray objectAtIndex:indexPath.row];
    cell.selectImgView.hidden = YES;
    cell.titleLab.textColor = RGBA(153, 153, 153, 1);
    if (_currentIndex == indexPath.row) {
        cell.selectImgView.hidden = NO;
        cell.titleLab.textColor= RGBA(258, 95, 80, 1);
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_currentIndex == indexPath.row) {
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_currentIndex
                                                   inSection:0];
    ClassifyDropDownCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.selectImgView.hidden) {
        newCell.selectImgView.hidden = NO;
        newCell.titleLab.textColor= RGBA(258, 95, 80, 1);
    }
    ClassifyDropDownCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (!oldCell.selectImgView.hidden) {
        oldCell.selectImgView.hidden = YES;
        oldCell.titleLab.textColor = RGBA(153, 153, 153, 1);
    }
    
    [self hide];
    
    _currentIndex = indexPath.row;
    self.ClassifyViewBlock(indexPath.row);
    self.ClassifyActionBlock(indexPath.row,_dataArray[indexPath.row]);
}

#pragma mark - action
//隐藏
-(void)dismissView{
    [self hide];
}

- (void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [window.subviews firstObject];
    [topView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
         self.alpha = 1;
    }];
}
-(void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
}

@end

@implementation ClassifyDropDownCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creat];
    }
    return self;
}

- (void)creat{
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenW - 40, 42)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textColor = RGBA(153, 153, 153, 1);
    [self addSubview:_titleLab];
    
    // 选中图标
    _selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 30, 15, 17, 14)];
    _selectImgView.image = [UIImage imageNamed:@"AnyBuy_Yes.png"];
    [self addSubview:_selectImgView];
    
}


@end
