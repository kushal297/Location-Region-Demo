//
//  AppDelegate.h
//  backgroundTest
//
//  Created by kushal bindra on 01/07/14.
//  Copyright (c) 2014 com.kush.devtest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *bestLocation;


- (void) updateLocation;

@end
