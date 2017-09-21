
//
//  ClassifyView.m
//  ClassifyView
//
//  Created by 陈楠 on 17/5/11.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "ClassifyView.h"
#define ClassifyViewTag 10000


@interface ClassifyView ()
@property (nonatomic, retain)NSMutableArray *btns;
@property (nonatomic, retain)ML_Button *recordBtn;

@property (nonatomic, assign)BOOL isFirst;

@property (nonatomic, assign)NSInteger btnIndex;
@property (nonatomic, assign)NSInteger detailbtnIndex;

@end

@implementation ClassifyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setBtnTextList:(NSArray *)btnTextList{

    _btnTextList = btnTextList;
    CGFloat width = self.frame.size.width/_btnTextList.count;
    CGFloat height = self.frame.size.height;
    _btns = [NSMutableArray array];
    [_btnTextList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ML_Button *btn = [ML_Button buttonWithType:UIButtonTypeCustom];
        btn.status = MLAlignmentStatusCenter;
        btn.frame = CGRectMake(width * idx, 0, width, height);
        [btn setTitleColor:[UIColor grayColor] forState:0];
        [btn setTitle:_btnTextList[idx] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, +10, 0, 0)];
        [btn setImage:[UIImage imageNamed:_btnDefaultImages[idx]] forState:0];
        btn.tag = idx + ClassifyViewTag;
        [self addSubview:btn];
        [_btns addObject:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)setReset:(BOOL)reset{
    _reset = reset;
    _recordBtn.selected = YES;
     for (ML_Button *btn in _btns) {
    [btn setTitleColor:[UIColor grayColor] forState:0];
    [btn setImage:[UIImage imageNamed:_btnDefaultImages[btn.tag-ClassifyViewTag]] forState:0];
    }
}

- (void)btnAction:(ML_Button *)sender{
   
    if (!_systemDropDownView) {
        for (ML_Button *btn in _btns) {
            [btn setTitleColor:[UIColor grayColor] forState:0];
            [btn setImage:[UIImage imageNamed:_btnDefaultImages[btn.tag-ClassifyViewTag]] forState:0];
            if (sender.tag == btn.tag) {
                self.btnIndex = sender.tag - ClassifyViewTag;
                [sender setTitleColor:[UIColor redColor] forState:0];
                //连续点击逻辑判断
                if (_recordBtn == sender) {
                    //是连续点击
                    _recordBtn.selected =!_recordBtn.selected;
                    if (_recordBtn.selected) {
                        [sender setImage:[UIImage imageNamed:_btnDefultWithselectImages[sender.tag-ClassifyViewTag]] forState:0];
                        
                        if ([self.delegate respondsToSelector:@selector(classifyView:integerWithfirst:integerWithTwo:)] && _delegate) {
                            [self.delegate classifyView:self integerWithfirst:self.btnIndex integerWithTwo:1];
                        }
                    }else{
                        if ([self.delegate respondsToSelector:@selector(classifyView:integerWithfirst:integerWithTwo:)] && _delegate) {
                            [self.delegate classifyView:self integerWithfirst:self.btnIndex integerWithTwo:0];
                        }

                        [sender setImage:[UIImage imageNamed:_btnselectImages[sender.tag-ClassifyViewTag]] forState:0];
                    }
                }else{
                     _recordBtn.selected = NO;
                    [sender setImage:[UIImage imageNamed:_btnselectImages[sender.tag-ClassifyViewTag]] forState:0];
                    if ([self.delegate respondsToSelector:@selector(classifyView:integerWithfirst:integerWithTwo:)] && _delegate) {
                        [self.delegate classifyView:self integerWithfirst:self.btnIndex integerWithTwo:0];
                    }

                }
                
                _recordBtn = sender;
               
            }
            
        }
    }else{
        for (ML_Button *btn in _btns) {
            [btn setTitleColor:[UIColor grayColor] forState:0];
            [btn setImage:[UIImage imageNamed:_btnDefaultImages[btn.tag-ClassifyViewTag]] forState:0];
            if (sender.tag == btn.tag) {
                self.btnIndex = sender.tag - ClassifyViewTag;
                if (sender.tag == ClassifyViewTag) {
                    [self.dorpView show];
                }else{
                    [self.dorpView dismissView];
                    if (self.ClassifyViewBlock) {
                        self.ClassifyViewBlock(self.btnIndex,0);
                    }
                    if ([self.delegate respondsToSelector:@selector(classifyView:integerWithfirst:integerWithTwo:)] && _delegate) {
                        [self.delegate classifyView:self integerWithfirst:self.btnIndex integerWithTwo:0];
                    }
                }
                [sender setTitleColor:[UIColor redColor] forState:0];
                //连续点击逻辑判断
                if (_recordBtn == sender) {
                    _recordBtn.selected =!_recordBtn.selected;
                    if (_recordBtn.selected) {
                        [sender setImage:[UIImage imageNamed:_btnDefultWithselectImages[sender.tag-ClassifyViewTag]] forState:0];
                        
                        if (_recordBtn.tag == 11&&_isFirst == YES) {
                            [self.dorpView show];
                            [sender setImage:[UIImage imageNamed:_btnselectImages[sender.tag-ClassifyViewTag]] forState:0];
                            return;
                        }
                        if (_recordBtn.tag == 11) {
                            [self.dorpView dismissView];
                        }
                        if ([self.delegate respondsToSelector:@selector(classifyView:integerWithfirst:integerWithTwo:)] && _delegate) {
                            [self.delegate classifyView:self integerWithfirst:self.btnIndex integerWithTwo:1];
                        }
                    }else{
                        
                        [sender setImage:[UIImage imageNamed:_btnselectImages[sender.tag-ClassifyViewTag]] forState:0];
                    }
                }else{
                    [sender setImage:[UIImage imageNamed:_btnselectImages[sender.tag-ClassifyViewTag]] forState:0];
                }
                
                _recordBtn = sender;
            }
            
        }
    }
    
}


- (ClassifyDropDownView *)dorpView{
    if (!_dorpView) {
        _dorpView = [[ClassifyDropDownView alloc]initWithFrame:CGRectMake(0, self.frame.size.height + self.frame.origin.y,  self.frame.size.width, 150)];
        __weak __typeof(_dorpView)dorpViewS = _dorpView;
        __weak __typeof(self)weakSe = self;
        _dorpView.ClassifyViewBlock = ^(NSInteger index){
            dorpViewS.currentIndex = index;
            if (weakSe.recordBtn.tag == 10) {
            [weakSe.recordBtn setImage:[UIImage imageNamed:weakSe.btnDefultWithselectImages[weakSe.recordBtn.tag-10]] forState:0];
            weakSe.recordBtn.selected = NO;
                _isFirst = YES;
            }
        };
        _dorpView.ClassifyActionBlock = ^(NSInteger index,NSString *text){
            [weakSe.recordBtn setTitleColor:[UIColor redColor] forState:0];
            [weakSe.recordBtn setImage:[UIImage imageNamed:weakSe.btnDefultWithselectImages[weakSe.recordBtn.tag-ClassifyViewTag]] forState:0];
            if (weakSe.ClassifyViewBlock) {
                weakSe.ClassifyViewBlock(weakSe.btnIndex,index);
            }
            
            if ([self.delegate respondsToSelector:@selector(classifyView:integerWithfirst:integerWithTwo:)] && _delegate) {
                [weakSe.delegate classifyView:weakSe integerWithfirst:weakSe.btnIndex integerWithTwo:index];
            }
        };
        _dorpView.dataArray = @[@"综合排序",@"人气优先",@"最新上线"];
        [self addSubview:dorpViewS];
    }
    return _dorpView;
}


@end
