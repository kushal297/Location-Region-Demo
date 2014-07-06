//
//  AppDelegate.m
//  backgroundTest
//
//  Created by kushal bindra on 01/07/14.
//  Copyright (c) 2014 com.kush.devtest. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize locationManager = _locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToTV" object:nil userInfo:@{@"message": @"begin"}];
    return YES;
}

- (void) updateLocation
{
    if (!_locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    if (locations.count == 0)
        return;
    
    CLLocation *newLocation = [locations objectAtIndex:0];

    NSLog(@"newLocation :%@", newLocation);
    
    if (newLocation.horizontalAccuracy > 100.0f)
        return;
    
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 15)
        return;
    
    if (_bestLocation == nil || _bestLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        
        _bestLocation = newLocation;
        
       [_locationManager stopUpdatingLocation];
        
        [[[UIAlertView alloc] initWithTitle:@"Location Test!" message:@"Got Location!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addToTV" object:nil userInfo:@{@"message": @"Found best location"}];
    }

    
}

- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error {
    
    NSLog(@"did not find location :%@", error);
    
    [_locationManager stopUpdatingLocation];
}


- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
    
    CLCircularRegion *regionToMoniter = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(_bestLocation.coordinate.latitude, _bestLocation.coordinate.longitude) radius:1 identifier:@"regionMonitorToBG2"];
    
    [_locationManager startMonitoringForRegion:regionToMoniter];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToTV" object:nil userInfo:@{@"message": @"start region monitoring"}];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToTV" object:nil userInfo:@{@"message": @"didEnterRegion"}];
    
    [[[UIAlertView alloc] initWithTitle:@"" message:@"didEnterRegion" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    
    UIApplication* app = [UIApplication sharedApplication];
    
    [app cancelAllLocalNotifications];
    
    NSDate *now = [NSDate date];
    NSDate *notificationDate = [now dateByAddingTimeInterval:10*1];
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = notificationDate;
    localNotification.alertBody = @"Did enter region!";
    localNotification.alertAction = @"Location..";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [app applicationIconBadgeNumber] + 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [app scheduleLocalNotification:localNotification];

}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToTV" object:nil userInfo:@{@"message": @"didExitRegion"}];
    
    [[[UIAlertView alloc] initWithTitle:@"" message:@"didExitRegion" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    
    UIApplication* app = [UIApplication sharedApplication];
    
    [app cancelAllLocalNotifications];
    
    NSDate *now = [NSDate date];
    NSDate *notificationDate = [now dateByAddingTimeInterval:10*1];
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = notificationDate;
    localNotification.alertBody = @"Did exit region!";
    localNotification.alertAction = @"Open app";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [app applicationIconBadgeNumber] + 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [app scheduleLocalNotification:localNotification];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToTV" object:nil userInfo:@{@"message": @"didStartMonitoringForRegion"}];
    
    
    [[[UIAlertView alloc] initWithTitle:@"" message:@"didStartMonitoringForRegion" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    
    UIApplication* app = [UIApplication sharedApplication];
    
    [app cancelAllLocalNotifications];
    
    NSDate *now = [NSDate date];
    NSDate *notificationDate = [now dateByAddingTimeInterval:10*1];
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = notificationDate;
    localNotification.alertBody = @"didStartMonitoringForRegion";
    localNotification.alertAction = @"Open app";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [app applicationIconBadgeNumber] + 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [app scheduleLocalNotification:localNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate");
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[[UIAlertView alloc] initWithTitle:@"didReceiveLocalNotification" message:notification.alertBody delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

@end
