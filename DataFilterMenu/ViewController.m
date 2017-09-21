//
//  ViewController.m
//  DataFilterMenu
//
//  Created by 陈楠 on 17/9/21.
//  Copyright © 2017年 email:ch_email@126.com. All rights reserved.
//

#import "ViewController.h"
#import "ClassifyView.h"
#define BGCorlor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
@interface ViewController ()<ClassifyViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = BGCorlor;
    ClassifyView *classifyView = [[ClassifyView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 44)];
    classifyView.systemDropDownView = YES;//需要默认下拉选择框 暂时默认第一个
    classifyView.delegate = self;
    classifyView.btnDefaultImages = @[@"AnyBuy_Head_B",@"AnyBuy_Head_B",@"AnyBuy_Head_B",@"AnyBuy_Head_G"];
    classifyView.btnselectImages = @[@"AnyBuy_Head_UR",@"AnyBuy_Head_UR",@"AnyBuy_Head_UR",@"AnyBuy_Head_up"];
    classifyView.btnDefultWithselectImages = @[@"AnyBuy_Head_D",@"AnyBuy_Head_D",@"AnyBuy_Head_D",@"AnyBuy_Head_R"];
    classifyView.btnTextList = @[@"综合",@"地区",@"价格",@"销量"];;
    [self.view addSubview:classifyView];
    
    ClassifyView *classifyView1 = [[ClassifyView alloc]initWithFrame:CGRectMake(0, 270, self.view.frame.size.width, 44)];
    classifyView1.systemDropDownView = NO;//不需要默认下拉选择框
    classifyView1.delegate = self;
    classifyView1.btnDefaultImages = @[@"AnyBuy_Head_B",@"AnyBuy_Head_B",@"AnyBuy_Head_B",@"AnyBuy_Head_G"];
    classifyView1.btnselectImages = @[@"AnyBuy_Head_UR",@"AnyBuy_Head_UR",@"AnyBuy_Head_UR",@"AnyBuy_Head_up"];
    classifyView1.btnDefultWithselectImages = @[@"AnyBuy_Head_D",@"AnyBuy_Head_D",@"AnyBuy_Head_D",@"AnyBuy_Head_R"];
    classifyView1.btnTextList = @[@"分类",@"地区",@"价格",@"销量"];;
    [self.view addSubview:classifyView1];
    
    
}

- (void)classifyView:(ClassifyView *)classifyView integerWithfirst:(NSInteger)index integerWithTwo:(NSInteger)detailIndex{
    NSLog(@"ClassifyView == %ld    %ld",(long)index,(long)detailIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
