//
//  RHCarouselView.h
//  RHCommonFoundation
//
//  Created by zhuruhong on 16/4/4.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RHCarouselDirection) {
    RHCarouselDirectionNone = 0,
    RHCarouselDirectionLeft = 1,
    RHCarouselDirectionRight = 2
};

@protocol RHCarouselViewDelegate <NSObject>

@required

- (NSUInteger)numberOfImages;
- (UIImage *)imageForIndex:(NSUInteger)index;

@end

@interface RHCarouselView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIScrollView *contentScrollView;
@property (nonatomic, strong, readonly) UIImageView *currentImageView;
@property (nonatomic, strong, readonly) UIImageView *otherImageView;

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

@property (nonatomic, weak) id<RHCarouselViewDelegate> delegate;

@property (nonatomic, assign) RHCarouselDirection direction;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign, readonly) NSInteger nextIndex;

//auto scroll
@property (nonatomic, strong) NSTimer *autoScrollTimer;
@property (nonatomic, assign) BOOL autoScrollEnabled;
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

#pragma mark - timer

- (void)stopAutoScrollTimer;
- (void)startAutoScrollTimer;

@end
