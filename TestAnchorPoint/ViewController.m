//
//  ViewController.m
//  TestAnchorPoint
//
//  Created by blucy on 2016/11/24.
//  Copyright © 2016年 bill. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIView * view1;
@property (nonatomic,strong) UIView * view2;
@property (nonatomic,strong) UIButton * changeAPBtn;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSArray * testAPArray;
@property (nonatomic,strong) NSMutableArray * testViewMArray;
@property (nonatomic,strong) UIButton * resetBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view1 = [UIView new];
    CGFloat view1Width = 100;
    self.view1.frame = CGRectMake(self.view.center.x - view1Width/2, 140, view1Width, view1Width);
    self.view1.backgroundColor = [UIColor orangeColor];
    
//    self.view2 = [UIView new];
//    self.view2.backgroundColor = [UIColor orangeColor];
    
    self.testViewMArray = [NSMutableArray array];
    
    //更新按钮
    self.changeAPBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeAPBtn setTitle:NSStringFromCGPoint(self.view1.layer.anchorPoint) forState:UIControlStateNormal];
    [self.changeAPBtn setBackgroundColor:[UIColor colorWithRed:119/255.0 green:210/255.0 blue:58/255.0 alpha:1.0]];
    //119	210	58
    [self.changeAPBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.changeAPBtn addTarget:self action:@selector(changeAPBtnAction) forControlEvents:UIControlEventTouchUpInside];
    CGFloat apBtnWidth = 100;
    self.changeAPBtn.frame = CGRectMake(self.view.center.x - apBtnWidth/2, 360, apBtnWidth, 40);
    self.changeAPBtn.layer.masksToBounds = YES;
    self.changeAPBtn.layer.cornerRadius = CGRectGetHeight(self.changeAPBtn.frame)/2;
    self.changeAPBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    //重置按钮
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    //230	188	58
    [self.resetBtn setBackgroundColor:[UIColor colorWithRed:230/255.0 green:188/255.0 blue:58/255.0 alpha:1.0]];
    [self.resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(resetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.resetBtn.frame = CGRectMake(CGRectGetMinX(self.changeAPBtn.frame), CGRectGetMaxY(self.changeAPBtn.frame)+ 20, CGRectGetWidth(self.changeAPBtn.frame), CGRectGetHeight(self.changeAPBtn.frame));
    self.resetBtn.layer.masksToBounds = YES;
    self.resetBtn.layer.cornerRadius = CGRectGetHeight(self.resetBtn.frame)/2;
    self.resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.changeAPBtn];
    [self.view addSubview:self.resetBtn];
    
    [self logViewCoord:self.view1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)changeAPBtnAction{
    NSInteger i = self.index % self.testAPArray.count;
    NSValue * value = self.testAPArray[i];
    
    UIView * shadowView = [self createShadowView];
    shadowView.frame = self.view1.frame;
    [self.view addSubview:shadowView];
    
    UILabel * originLabel = [self originLabel:shadowView];
    [self.view addSubview:originLabel];
    //存储View，用于后续重置
    [self.testViewMArray addObject:shadowView];
    [self.testViewMArray addObject:originLabel];
    
    self.view1.layer.anchorPoint = [value CGPointValue];
    [self.changeAPBtn setTitle:NSStringFromCGPoint(self.view1.layer.anchorPoint) forState:UIControlStateNormal];
    
    [self logViewCoord:self.view1];
    ++self.index;
}


-(void)resetBtnAction{
    [self.testViewMArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView * view = (UIView *)obj;
        [view removeFromSuperview];
    }];
    
    self.view1.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.index = 0;
}



-(void)logViewCoord:(UIView *)view{
    ///////////////公式///////////////////////////////
    //frame.origin.x = position.x - bounds.size.width * anchorPoint.x
    //frame.origin.y = position.y - bounds.size.height * anchorPoint.y
    ////////////////////////////////////////////////
    
    NSLog(@"frame:%@",NSStringFromCGRect(view.frame));
    NSLog(@"bounds:%@",NSStringFromCGRect(view.bounds));
    NSLog(@"anchorpoint:%@",NSStringFromCGPoint(view.layer.anchorPoint));
    NSLog(@"center:%@",NSStringFromCGPoint(view.center));
    NSLog(@"position:%@",NSStringFromCGPoint(view.layer.position));
    NSLog(@"================================");
}


-(NSArray *)testAPArray{
    if (!_testAPArray) {
        NSMutableArray * tempMArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 3; i++) {
            CGFloat x = i * 0.5;
            for (NSInteger j = 0; j < 3; j++) {
                CGFloat y = j * 0.5;
                CGPoint point = CGPointMake(x, y);
                [tempMArray addObject:[NSValue valueWithCGPoint:point]];
            }
        }
        _testAPArray = [tempMArray copy];
    }
    return _testAPArray;
}


-(UIView *)createShadowView{
    UIView * sView = [UIView new];
    sView.backgroundColor = [UIColor clearColor];
    sView.layer.borderColor = [self randomColor].CGColor;
    sView.layer.borderWidth = 3;
    return sView;
}

-(UILabel *)originLabel:(UIView *)sView{
    UILabel * oLabel = [UILabel new];
    oLabel.textColor = [UIColor colorWithCGColor:sView.layer.borderColor];
    CGFloat height = 14;
    CGFloat width = 100;
    CGFloat y = sView.frame.origin.y - height;
    CGFloat x = sView.frame.origin.x - width/2;
    oLabel.frame = CGRectMake(x, y, width, height);
    oLabel.font = [UIFont systemFontOfSize:12];
    oLabel.textAlignment = NSTextAlignmentCenter;
    oLabel.text = NSStringFromCGPoint(CGPointMake(CGRectGetMinX(sView.frame), CGRectGetMinY(sView.frame)));
    
    return oLabel;
}


-(UIColor *)randomColor{
    CGFloat red = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    CGFloat blue = arc4random() % 255;
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}




@end
