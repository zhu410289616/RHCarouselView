//
//  ViewController.m
//  RHCarouselViewDemo
//
//  Created by zhuruhong on 16/4/10.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "ViewController.h"
#import "RHPageCarouselView.h"

@interface ViewController () <RHCarouselViewDelegate>
{
    RHCarouselView *_carouselView;
    
    RHPageCarouselView *_pageCarouselView;
    
    NSMutableArray *_imageList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageList = [[NSMutableArray alloc] init];
    [_imageList addObject:[UIImage imageNamed:@"img1"]];
    [_imageList addObject:[UIImage imageNamed:@"img2"]];
    
    //
    _carouselView = [[RHCarouselView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 240)];
    _carouselView.delegate = self;
    [self.view addSubview:_carouselView];
    [_carouselView setCurrentIndex:0];
    _carouselView.autoScrollTimeInterval = 3;
    
    //
    _pageCarouselView = [[RHPageCarouselView alloc] initWithFrame:CGRectMake(0, 350, CGRectGetWidth(self.view.frame), 240)];
    _pageCarouselView.delegate = self;
    [self.view addSubview:_pageCarouselView];
    [_pageCarouselView setCurrentIndex:1];
    _carouselView.autoScrollTimeInterval = 1.5;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_carouselView startAutoScrollTimer];
    [_pageCarouselView startAutoScrollTimer];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_carouselView stopAutoScrollTimer];
    [_pageCarouselView stopAutoScrollTimer];
}

#pragma mark - RHCarouselViewDelegate

- (NSUInteger)numberOfImages
{
    return _imageList.count;
}

- (UIImage *)imageForIndex:(NSUInteger)index
{
    return _imageList[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
