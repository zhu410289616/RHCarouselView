//
//  RHCarouselView.m
//  RHCommonFoundation
//
//  Created by zhuruhong on 16/4/4.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHCarouselView.h"

@implementation RHCarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _width = CGRectGetWidth(frame);
        _height = CGRectGetHeight(frame);
        
        //
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.frame = CGRectMake(0, 0, _width, _height);
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_contentScrollView];
        
        //
        _currentImageView = [[UIImageView alloc] init];
        _currentImageView.frame = CGRectMake(_width, 0, _width, _height);
        [_contentScrollView addSubview:_currentImageView];
        
        //
        _otherImageView = [[UIImageView alloc] init];
        [_contentScrollView addSubview:_otherImageView];
        
        //
        _contentScrollView.contentSize = CGSizeMake(_width * 3, _height);
        _contentScrollView.contentOffset = CGPointMake(_width, 0);
        
        //
        [self addObserver:self forKeyPath:@"direction" options:NSKeyValueObservingOptionNew context:nil];
        
        //
        _images = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"direction" context:nil];
}

#pragma mark - observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (change[NSKeyValueChangeNewKey] == change[NSKeyValueChangeOldKey]) {
        return;
    }
    
    if ([change[NSKeyValueChangeNewKey] intValue] == RHCarouselDirectionLeft) {
        _otherImageView.frame = CGRectMake(CGRectGetMaxX(_currentImageView.frame), 0, _width, _height);
        _nextIndex = (_currentIndex + 1) % _images.count;
    } else if ([change[NSKeyValueChangeNewKey] intValue] == RHCarouselDirectionRight) {
        _otherImageView.frame = CGRectMake(0, 0, _width, _height);
        _nextIndex = (_currentIndex - 1 < 0) ? (_images.count - 1) : (_currentIndex - 1);
    }
    
    _otherImageView.image = _images[_nextIndex];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.direction = scrollView.contentOffset.x > _width ? RHCarouselDirectionLeft : RHCarouselDirectionRight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopAutoScrollTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_autoScrollEnabled) {
        [self startAutoScrollTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self pauseScroll];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //setContentOffset:animated方法执行完后，不会调用scrollView的scrollViewDidEndDecelerating方法，
    //但是会调用scrollViewDidEndScrollingAnimation方法，我们在该方法中调用pauseScroll
    [self pauseScroll];
}

- (void)pauseScroll
{
    //清空滚动方向
    _direction = RHCarouselDirectionNone;
    //判断最终是向左还是向右
    int tempIndex = _contentScrollView.contentOffset.x / _width;
    //如果是1，表示当前页面依旧居中显示，不做更新
    if (tempIndex == 1) {
        return;
    }
    
    //当前图片索引更新
    [self setCurrentIndex:_nextIndex];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    _currentImageView.frame = CGRectMake(_width, 0, _width, _height);
    _currentImageView.image = _images[_currentIndex];
    _contentScrollView.contentOffset = CGPointMake(_width, 0);
}

#pragma mark - timer

- (void)stopAutoScrollTimer
{
    if (_autoScrollTimer) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }
}

- (void)startAutoScrollTimer
{
    [self stopAutoScrollTimer];
    
    //只有一张图片，不开定时器，直接返回
    if (_images.count <= 1) {
        return;
    }
    
    _autoScrollEnabled = YES;
    _autoScrollTimeInterval = (_autoScrollTimeInterval > 0) ? _autoScrollTimeInterval : 5;
    _autoScrollTimer = [NSTimer timerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_autoScrollTimer forMode:NSRunLoopCommonModes];
}

- (void)nextPage
{
    [_contentScrollView setContentOffset:CGPointMake(_width * 2, 0) animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
