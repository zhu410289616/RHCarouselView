//
//  ViewController.m
//  RHCarouselViewDemo
//
//  Created by zhuruhong on 16/4/10.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "ViewController.h"
#import "RHPageCarouselView.h"

@interface ViewController ()
{
    RHCarouselView *_carouselView;
    
    RHPageCarouselView *_pageCarouselView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _carouselView = [[RHCarouselView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 240)];
    [self.view addSubview:_carouselView];
    [_carouselView.images removeAllObjects];
    [_carouselView.images addObject:[UIImage imageNamed:@"img1"]];
    [_carouselView.images addObject:[UIImage imageNamed:@"img2"]];
    [_carouselView setCurrentIndex:0];
    _carouselView.autoScrollTimeInterval = 3;
    [_carouselView startAutoScrollTimer];
    
    _pageCarouselView = [[RHPageCarouselView alloc] initWithFrame:CGRectMake(0, 350, CGRectGetWidth(self.view.frame), 240)];
    [self.view addSubview:_pageCarouselView];
    [_pageCarouselView.images removeAllObjects];
    [_pageCarouselView.images addObject:[UIImage imageNamed:@"img1"]];
    [_pageCarouselView.images addObject:[UIImage imageNamed:@"img2"]];
    [_pageCarouselView setCurrentIndex:1];
    [_pageCarouselView startAutoScrollTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
