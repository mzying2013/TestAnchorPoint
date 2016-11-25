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


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view1 = [UIView new];
    CGFloat view1Width = 100;
    self.view1.frame = CGRectMake(self.view.center.x - view1Width/2, 140, view1Width, view1Width);
    self.view1.backgroundColor = [UIColor orangeColor];
    
    self.view2 = [UIView new];
    self.view2.backgroundColor = [UIColor orangeColor];
    
    
    //按钮
    self.changeAPBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeAPBtn setTitle:NSStringFromCGPoint(self.view1.layer.anchorPoint) forState:UIControlStateNormal];
    [self.changeAPBtn setBackgroundColor:[UIColor grayColor]];
    [self.changeAPBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.changeAPBtn addTarget:self action:@selector(changeAPBtnAction) forControlEvents:UIControlEventTouchUpInside];
    CGFloat apBtnWidth = 100;
    self.changeAPBtn.frame = CGRectMake(self.view.center.x - apBtnWidth/2, 360, apBtnWidth, 40);
    self.changeAPBtn.layer.masksToBounds = YES;
    self.changeAPBtn.layer.cornerRadius = CGRectGetHeight(self.changeAPBtn.frame)/2;
    
    
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.changeAPBtn];
    
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
    self.view1.layer.anchorPoint = [value CGPointValue];
    [self.changeAPBtn setTitle:NSStringFromCGPoint(self.view1.layer.anchorPoint) forState:UIControlStateNormal];
    
    [self logViewCoord:self.view1];
    ++self.index;
}



-(void)logViewCoord:(UIView *)view{
    ///////////////公式///////////////////////////////
    //frame.origin.x = position.x - bounds.size.width * anchorPoint.x
    //frame.origin.y = position.y - bounds.size.height * anchorPoint.y
    ////////////////////////////////////////////////
    
    NSLog(@"frame:%@",NSStringFromCGRect(view.frame));
    NSLog(@"bounds:%@",NSStringFromCGRect(view.bounds));
    NSLog(@"center:%@",NSStringFromCGPoint(view.center));
    NSLog(@"position:%@",NSStringFromCGPoint(view.layer.position));
    NSLog(@"anchorpoint:%@",NSStringFromCGPoint(view.layer.anchorPoint));
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


-(UIColor *)randomColor{
    CGFloat red = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    CGFloat blue = arc4random() % 255;
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}




@end
