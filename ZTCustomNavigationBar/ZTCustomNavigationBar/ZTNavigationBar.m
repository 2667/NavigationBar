//
//  ZTNavigationBar.m
//  ZTCustomNavigationBar
//
//  Created by 荣 li on 2017/7/24.
//  Copyright © 2017年 荣 li. All rights reserved.
//

#import "ZTNavigationBar.h"
#import <objc/runtime.h>

@implementation ZTNavigationBar

@end

@interface UIColor (Addition)
+ (UIColor *)defaultNavBarBarTintColor;
+ (UIColor *)defaultNavBarTintColor;
+ (UIColor *)defaultNavBarTitleColor;
+ (UIStatusBarStyle)defaultStatusBarStyle;
+ (BOOL)defaultNavBarShadowImageHidden;
+ (CGFloat)defaultNavBarBackgroundAlpha;
+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent;
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent;
@end


@implementation UIColor (ZTAddition)

static char kZTDefaultNavBarBarTintColorKey;
static char kZTDefaultNavBarBackgroundImageKey;
static char kZTDefaultNavBarTintColorKey;
static char kZTDefaultNavBarTitleColorKey;
static char kZTDefaultStatusBarStyleKey;
static char kZTDefaultNavBarShadowImageHiddenKey;

+ (UIColor *)defaultNavBarBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kZTDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)zt_setDefaultNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kZTDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kZTDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)zt_setDefaultNavBarBackgroundImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &kZTDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kZTDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)zt_setDefaultNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kZTDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kZTDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)zt_setDefaultNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kZTDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle
{
    id style = objc_getAssociatedObject(self, &kZTDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)zt_setDefaultStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kZTDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kZTDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)zt_setDefaultNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kZTDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha
{
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent
{
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end

#pragma mark - UINavigationBar
@implementation UINavigationBar (ZTAddition)

static char kZTBackgroundViewKey;
static char kZTBackgroundImageViewKey;
static int kZTNavBarBottom = 64;

- (UIView *)backgroundView
{
    return (UIView *)objc_getAssociatedObject(self, &kZTBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView
{
    objc_setAssociatedObject(self, &kZTBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView
{
    return (UIImageView *)objc_getAssociatedObject(self, &kZTBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView
{
    objc_setAssociatedObject(self, &kZTBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)zt_setBackgroundImage:(UIImage *)image
{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kZTNavBarBottom)];
        self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
    }
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)zt_setBackgroundColor:(UIColor *)color
{
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    if (self.backgroundView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), kZTNavBarBottom)];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)zt_setBackgroundAlpha:(CGFloat)alpha
{
    UIView *barBackgroundView = self.subviews.firstObject;
    barBackgroundView.alpha = alpha;
}

- (void)zt_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator
{
    for (UIView *view in self.subviews)
    {
        if (hasSystemBackIndicator == YES)
        {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil)
            {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil)
            {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else
        {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO)
            {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil)
                {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil)
                {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离
- (void)zt_setTranslationY:(CGFloat)translationY
{
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)zt_getTranslationY
{
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[1] = {
                          @selector(setTitleTextAttributes:)
                      };
                      
                      for (int i = 0; i < 1;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"zt_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)zt_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes
{
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self zt_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self zt_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self zt_setTitleTextAttributes:newTitleTextAttributes];
}

@end


@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end

//==========================================================================
#pragma mark - UINavigationController
//==========================================================================
@implementation UINavigationController (ZTAddition)

static CGFloat ztPopDuration = 0.12;
static int ztPopDisplayCount = 0;
- (CGFloat)ztPopProgress
{
    CGFloat all = 60 * ztPopDuration;
    int current = MIN(all, ztPopDisplayCount);
    return current / all;
}

static CGFloat ztPushDuration = 0.10;
static int ztPushDisplayCount = 0;
- (CGFloat)ztPushProgress
{
    CGFloat all = 60 * ztPushDuration;
    int current = MIN(all, ztPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController zt_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage
{
    [self.navigationBar zt_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor
{
    [self.navigationBar zt_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha
{
    [self.navigationBar zt_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor
{
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden
{
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor
{
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress
{
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC zt_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC zt_navBarBarTintColor];
    UIColor *newBarTintColor = [UIColor middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC zt_navBarTintColor];
    UIColor *toTintColor = [toVC zt_navBarTintColor];
    UIColor *newTintColor = [UIColor middleColor:fromTintColor toColor:toTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    
    // change navBarTitleColor
    UIColor *fromTitleColor = [fromVC zt_navBarTitleColor];
    UIColor *toTitleColor = [toVC zt_navBarTitleColor];
    UIColor *newTitleColor = [UIColor middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC zt_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC zt_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [UIColor middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[4] = {
                          NSSelectorFromString(@"_updateInteractiveTransition:"),
                          @selector(popToViewController:animated:),
                          @selector(popToRootViewControllerAnimated:),
                          @selector(pushViewController:animated:)
                      };
                      
                      for (int i = 0; i < 4;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [[NSString stringWithFormat:@"zt_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (NSArray<UIViewController *> *)zt_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        ztPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:ztPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self zt_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)zt_popToRootViewControllerAnimated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        ztPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:ztPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self zt_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        ztPopDisplayCount += 1;
        CGFloat popProgress = [self ztPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)zt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        ztPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:ztPushDuration];
    [CATransaction begin];
    [self zt_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        ztPushDisplayCount += 1;
        CGFloat pushProgress = [self ztPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES)
    {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10)
        {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        else
        {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIColor *curColor = [[context viewControllerForKey:key] zt_navBarBarTintColor];
        CGFloat curAlpha = [[context viewControllerForKey:key] zt_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES)
    {
        double cancelDuration = [context transitionDuration] * [context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    }
    else
    {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)zt_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    
    [self zt_updateInteractiveTransition:percentComplete];
}

@end


//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (ZTAddition)

static char kZTPushToCurrentVCFinishedKey;
static char kZTPushToNextVCFinishedKey;
static char kZTNavBarBackgroundImageKey;
static char kZTNavBarBarTintColorKey;
static char kZTNavBarBackgroundAlphaKey;
static char kZTNavBarTintColorKey;
static char kZTNavBarTitleColorKey;
static char kZTStatusBarStyleKey;
static char kZTNavBarShadowImageHiddenKey;
static char kZTCustomNavBarKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kZTPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kZTPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kZTPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kZTPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)zt_navBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kZTNavBarBackgroundImageKey);
    image = (image == nil) ? [UIColor defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)zt_setNavBarBackgroundImage:(UIImage *)image
{
    if ([[self zt_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self zt_customNavBar];
        [navBar zt_setBackgroundImage:image];
    }
    else {
        objc_setAssociatedObject(self, &kZTNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar barTintColor
- (UIColor *)zt_navBarBarTintColor
{
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kZTNavBarBarTintColorKey);
    return (barTintColor != nil) ? barTintColor : [UIColor defaultNavBarBarTintColor];
}
- (void)zt_setNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kZTNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self zt_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self zt_customNavBar];
        [navBar zt_setBackgroundColor:color];
    }
    else
    {
        if ([self pushToCurrentVCFinished] == YES && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)zt_navBarBackgroundAlpha
{
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kZTNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [UIColor defaultNavBarBackgroundAlpha];
    
}
- (void)zt_setNavBarBackgroundAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &kZTNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self zt_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self zt_customNavBar];
        [navBar zt_setBackgroundAlpha:alpha];
    }
    else
    {
        if ([self pushToCurrentVCFinished] == YES && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar tintColor
- (UIColor *)zt_navBarTintColor
{
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kZTNavBarTintColorKey);
    return (tintColor != nil) ? tintColor : [UIColor defaultNavBarTintColor];
}
- (void)zt_setNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kZTNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self zt_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self zt_customNavBar];
        navBar.tintColor = color;
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar titleColor
- (UIColor *)zt_navBarTitleColor
{
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kZTNavBarTitleColorKey);
    return (titleColor != nil) ? titleColor : [UIColor defaultNavBarTitleColor];
}
- (void)zt_setNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kZTNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self zt_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        UINavigationBar *navBar = (UINavigationBar *)[self zt_customNavBar];
        navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)zt_statusBarStyle
{
    id style = objc_getAssociatedObject(self, &kZTStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [UIColor defaultStatusBarStyle];
}
- (void)zt_setStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kZTStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)zt_setNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kZTNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
    
}
- (BOOL)zt_navBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kZTNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [UIColor defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)zt_customNavBar
{
    UIView *navBar = objc_getAssociatedObject(self, &kZTCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)zt_setCustomNavBar:(UINavigationBar *)navBar
{
    objc_setAssociatedObject(self, &kZTCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[3] = {
                          @selector(viewWillAppear:),
                          @selector(viewWillDisappear:),
                          @selector(viewDidAppear:)
                      };
                      
                      for (int i = 0; i < 3;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"zt_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)zt_viewWillAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self zt_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self zt_navBarTitleColor]];
    }
    [self zt_viewWillAppear:animated];
}

- (void)zt_viewWillDisappear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        [self setPushToNextVCFinished:YES];
    }
    [self zt_viewWillDisappear:animated];
}

- (void)zt_viewDidAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self zt_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self zt_navBarBarTintColor]];
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self zt_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self zt_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self zt_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self zt_navBarShadowImageHidden]];
    }
    [self zt_viewDidAppear:animated];
}

- (BOOL)canUpdateNavigationBar
{
    if (self.navigationController && CGRectEqualToRect(self.view.frame, [UIScreen mainScreen].bounds)) {
        return YES;
    } else {
        return NO;
    }
}

@end


