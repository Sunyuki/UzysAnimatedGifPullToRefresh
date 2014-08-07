//
//  UIScrollView+UzysAnimatedGifPullToRefresh.h
//  UzysAnimatedGifPullToRefresh
//
//  Created by Uzysjung on 2014. 4. 8..
//  Copyright (c) 2014년 Uzys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysAnimatedGifActivityIndicator.h"
@interface UIScrollView (UzysAnimatedGifPullToRefresh)
@property (nonatomic,assign) BOOL showPullToRefresh;
@property (nonatomic,assign) BOOL showAlphaTransition;
@property (nonatomic,assign) BOOL showVariableSize;
@property (nonatomic,strong) UzysAnimatedGifActivityIndicator *pullToRefreshView;
//테스트
//- (void)addPullToRefreshActionHandler:(actionHandler)handler;


- (void)addPullToRefreshWithProgressImages:(NSArray *)progressImages
                             loadingImages:(NSArray *)loadingImages
                   progressScrollThreshold:(NSInteger)threshold
                    loadingImagesFrameRate:(NSInteger)frameRate
                             actionHandler:(actionHandler)handler;

- (void)addPullToRefreshWithProgressImages:(NSArray *)progressImages
                   progressScrollThreshold:(NSInteger)threshold
                             actionHandler:(actionHandler)handler;

- (void)addPullToRefreshWithProgressImagesGifName:(NSString *)progressGifName
                             loadingImagesGifName:(NSString *)loadingGifName
                          progressScrollThreshold:(NSInteger)threshold
                                    actionHandler:(actionHandler)handler;

- (void)addPullToRefreshWithProgressImagesGifName:(NSString *)progressGifName
                          progressScrollThreshold:(NSInteger)threshold
                                    actionHandler:(actionHandler)handler;

- (void)addPullToRefreshWithProgressImagesGifName:(NSString *)progressGifName
                             loadingImagesGifName:(NSString *)loadingGifName
                          progressScrollThreshold:(NSInteger)threshold
                            loadingImageFrameRate:(NSInteger)frameRate
                                    actionHandler:(actionHandler)handler
;

- (void)triggerPullToRefresh;
- (void)stopRefreshAnimation;
@end
