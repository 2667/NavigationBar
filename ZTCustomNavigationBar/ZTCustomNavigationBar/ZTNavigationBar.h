//
//  ZTNavigationBar.h
//  ZTCustomNavigationBar
//
//  Created by 荣 li on 2017/7/24.
//  Copyright © 2017年 荣 li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZTNavigationBar : NSObject

@end

#pragma mark - UIColor
@interface UIColor (ZTAddition)
/**<设置 BarTintColor */
+ (void)zt_setDefaultNavBarBarTintColor:(UIColor *)color;

/**<设置 BackgroundImage */
+ (void)zt_setDefaultNavBarBackgroundImage:(UIImage *)image;

/**<设置 TintColor */
+ (void)zt_setDefaultNavBarTintColor:(UIColor *)color;

/**<设置 TitleColor */
+ (void)zt_setDefaultNavBarTitleColor:(UIColor *)color;

/**<设置 BarStyle */
+ (void)zt_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/**<设置 default shadowImage isHidden of UINavigationBar */
+ (void)zt_setDefaultNavBarShadowImageHidden:(BOOL)hidden;


@end


#pragma mark - UINavigationBar
@interface UINavigationBar (ZTAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)zt_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)zt_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)zt_getTranslationY;

@end

#pragma mark - UIViewController
@interface UIViewController (ZTAddition)

/** record current ViewController navigationBar backgroundImage **/
- (void)zt_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)zt_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)zt_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)zt_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)zt_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)zt_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)zt_setNavBarTintColor:(UIColor *)color;
- (UIColor *)zt_navBarTintColor;

/** record current ViewController titleColor */
- (void)zt_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)zt_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)zt_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)zt_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)zt_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)zt_navBarShadowImageHidden;

/** record current ViewController custom navigationBar */
- (void)zt_setCustomNavBar:(UINavigationBar *)navBar;

@end

