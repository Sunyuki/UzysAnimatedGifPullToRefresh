//
//  UIScrollView+UzysAnimatedGifPullToRefresh.m
//  UzysAnimatedGifPullToRefresh
//
//  Created by Uzysjung on 2014. 4. 8..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//

#import "UIScrollView+UzysAnimatedGifPullToRefresh.h"
#import <objc/runtime.h>
#import <AnimatedGIFImageSerialization.h>
static char UIScrollViewPullToRefreshView;

@implementation UIScrollView (UzysAnimatedGifPullToRefresh)
@dynamic pullToRefreshView, showPullToRefresh;

- (void)addPullToRefreshWithProgressImages:(NSArray *)progressImages
                             loadingImages:(NSArray *)loadingImages
                   progressScrollThreshold:(NSInteger)threshold
                    loadingImagesFrameRate:(NSInteger)frameRate
                             actionHandler:(actionHandler)handler
{
    if(self.pullToRefreshView == nil)
    {
        UzysAnimatedGifActivityIndicator *view = [[UzysAnimatedGifActivityIndicator alloc] initWithProgressImages:progressImages LoadingImages:loadingImages ProgressScrollThreshold:threshold LoadingImagesFrameRate:frameRate];
        view.pullToRefreshHandler = handler;
        view.scrollView = self;
        view.frame = CGRectMake((self.bounds.size.width - view.bounds.size.width)/2,
                                -view.bounds.size.height, view.bounds.size.width, view.bounds.size.height);
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        view.originalTopInset = self.contentInset.top;
        [self addSubview:view];
        [self sendSubviewToBack:view];
        self.pullToRefreshView = view;
        self.showPullToRefresh = YES;
    }
    
}

- (void)addPullToRefreshWithProgressImages:(NSArray *)progressImages
                   progressScrollThreshold:(NSInteger)threshold
                             actionHandler:(actionHandler)handler

{
    [self addPullToRefreshWithProgressImages:progressImages
                               loadingImages:nil
                     progressScrollThreshold:threshold
                      loadingImagesFrameRate:0
                               actionHandler:handler];
}

- (void)addPullToRefreshWithProgressImagesGifName:(NSString *)progressGifName
                             loadingImagesGifName:(NSString *)loadingGifName
                          progressScrollThreshold:(NSInteger)threshold
                                    actionHandler:(actionHandler)handler
{
    UIImage *progressImage = [UIImage imageNamed:progressGifName];
    UIImage *loadingImage = [UIImage imageNamed:loadingGifName];
    
    [self addPullToRefreshWithProgressImages:progressImage.images
                               loadingImages:loadingImage.images
                     progressScrollThreshold:threshold
                      loadingImagesFrameRate:(NSInteger)ceilf(1.0/(loadingImage.duration/loadingImage.images.count))
                               actionHandler:handler];
}

- (void)addPullToRefreshWithProgressImagesGifName:(NSString *)progressGifName
                             loadingImagesGifName:(NSString *)loadingGifName
                          progressScrollThreshold:(NSInteger)threshold
                            loadingImageFrameRate:(NSInteger)frameRate
                                    actionHandler:(actionHandler)handler
{
    UIImage *progressImage = [UIImage imageNamed:progressGifName];
    UIImage *loadingImage = [UIImage imageNamed:loadingGifName];
    
    [self addPullToRefreshWithProgressImages:progressImage.images
                               loadingImages:loadingImage.images
                     progressScrollThreshold:threshold
                      loadingImagesFrameRate:frameRate
                               actionHandler:handler];
}

- (void)addPullToRefreshWithProgressImagesGifName:(NSString *)progressGifName
                          progressScrollThreshold:(NSInteger)threshold
                                    actionHandler:(actionHandler)handler
{
    UIImage *progressImage = [UIImage imageNamed:progressGifName];
    [self addPullToRefreshWithProgressImages:progressImage.images
                     progressScrollThreshold:threshold
                               actionHandler:handler];
}

- (void)triggerPullToRefresh
{
    [self.pullToRefreshView manuallyTriggered];
}
- (void)stopRefreshAnimation
{
    [self.pullToRefreshView stopIndicatorAnimation];
}
#pragma mark - property
- (void)setPullToRefreshView:(UzysAnimatedGifActivityIndicator *)pullToRefreshView
{
    [self willChangeValueForKey:@"UzysAnimatedGifActivityIndicator"];
    objc_setAssociatedObject(self, &UIScrollViewPullToRefreshView, pullToRefreshView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"UzysAnimatedGifActivityIndicator"];
}
- (UzysAnimatedGifActivityIndicator *)pullToRefreshView
{
    return objc_getAssociatedObject(self, &UIScrollViewPullToRefreshView);
}

- (void)setShowPullToRefresh:(BOOL)showPullToRefresh {
    self.pullToRefreshView.hidden = !showPullToRefresh;
    
    if(showPullToRefresh)
    {
        if(!self.pullToRefreshView.isObserving)
        {
            [self addObserver:self.pullToRefreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.pullToRefreshView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.pullToRefreshView forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            self.pullToRefreshView.isObserving = YES;
        }
    }
    else
    {
        if(self.pullToRefreshView.isObserving)
        {
            [self removeObserver:self.pullToRefreshView forKeyPath:@"contentOffset"];
            [self removeObserver:self.pullToRefreshView forKeyPath:@"contentSize"];
            [self removeObserver:self.pullToRefreshView forKeyPath:@"frame"];
            self.pullToRefreshView.isObserving = NO;
        }
    }
}

- (BOOL)showPullToRefresh
{
    return !self.pullToRefreshView.hidden;
}

- (void)setShowAlphaTransition:(BOOL)showAlphaTransition
{
    self.pullToRefreshView.showAlphaTransition = showAlphaTransition;
}
- (BOOL)showAlphaTransition
{
    return self.pullToRefreshView.showAlphaTransition;
}
- (void)setShowVariableSize:(BOOL)showVariableSize
{
    self.pullToRefreshView.isVariableSize = showVariableSize;
}
-(BOOL)showVariableSize
{
    return self.pullToRefreshView.isVariableSize;
}
@end
