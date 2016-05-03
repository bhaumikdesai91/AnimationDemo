//
//  BDProgressView.h
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 13/07/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BDProgressView : UIView

@property (strong, nonatomic) IBInspectable UIColor *color1;
@property (strong, nonatomic) IBInspectable UIColor *color2;
@property (strong, nonatomic) IBInspectable UIColor *color3;

@property (nonatomic) IBInspectable CGFloat radius;

@end
