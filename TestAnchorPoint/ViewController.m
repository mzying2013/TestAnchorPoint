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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view1 = [UIView new];
    self.view1.backgroundColor = [UIColor orangeColor];
    
    self.view2 = [UIView new];
    self.view2.backgroundColor = [UIColor orangeColor];
    
    
    [self.view addSubview:self.view1];
    [self.view1 addSubview:self.view2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
