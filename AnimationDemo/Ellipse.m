//
//  Ellipse.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 01/10/15.
//  Copyright © 2015 Bhaumik P. Desai. All rights reserved.
//

#import "Ellipse.h"

@implementation Ellipse

-(UIDynamicItemCollisionBoundsType)collisionBoundsType{
    return UIDynamicItemCollisionBoundsTypeEllipse;
}

@end
