//
//  UIView+borders.h
//  tic-tac-toe-objc
//
//  Created by C4Q  on 5/14/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (borders)

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;



@end
