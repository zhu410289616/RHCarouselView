//
//  RHPageCarouselView.m
//  RHCarouselViewDemo
//
//  Created by zhuruhong on 16/4/10.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHPageCarouselView.h"

@implementation RHPageCarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //
        _cursorPageControl = [[UIPageControl alloc] init];
        _cursorPageControl.frame = CGRectMake(0, self.height - 20, self.width, 20);
        _cursorPageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _cursorPageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
        [_cursorPageControl addTarget:self action:@selector(doPageControlChanged:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cursorPageControl];
        
    }
    return self;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    [super setCurrentIndex:currentIndex];
    
    _cursorPageControl.numberOfPages = [self.delegate numberOfImages];
    _cursorPageControl.currentPage = self.currentIndex;
}

- (void)doPageControlChanged:(id)sender
{
    UIPageControl *pageControl = sender;
    [self setCurrentIndex:pageControl.currentPage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
