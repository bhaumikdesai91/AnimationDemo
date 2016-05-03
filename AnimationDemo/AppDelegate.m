//
//  AppDelegate.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 09/03/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property BOOL assistiveTouchShown;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setApplicationIconBadgeNumber:16];
    [Appirater setAppId:@"552035781"];
    [Appirater setDaysUntilPrompt:0];
    [Appirater setUsesUntilPrompt:1];
    [Appirater setSignificantEventsUntilPrompt:1];
    [Appirater setTimeBeforeReminding:0];
    [Appirater setDebug:YES];
    self.rectForTransition = CGRectMake(0, 0, 50, 50);
    [Appirater appLaunched:YES];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(UIColor *)calculateRandomColor
{
    CGFloat randomRed = (CGFloat)drand48();
    CGFloat randomGreen = (CGFloat)drand48();
    CGFloat randomBlue = (CGFloat)drand48();
    return [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];
}
+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

-(BOOL)isAssistiveTouchVisible{
    return self.assistiveTouchShown;
}

-(void)setAssistiveTouchVisible:(BOOL)visible{
    self.assistiveTouchShown = visible;
}

@end
