//
//  ViewController.m
//  backgroundTest
//
//  Created by kushal bindra on 01/07/14.
//  Copyright (c) 2014 com.kush.devtest. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction) configureLocationManager
{
//    CLRegion * region = [[CLRegion alloc] initCircularRegionWithCenter: CLLocationCoordinate2DMake(41.8500, 87.6500) radius: 300 identifier: @"regionIDstring"];
    
}

- (IBAction) findLocationBtnAction
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] updateLocation];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToTV" object:nil userInfo:@{@"message": @"begin1"}];
}


- (IBAction) setLocalNotificationAlert
{
    NSLog(@"local notification configured!");
    /*
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = _timePicker.date;
    localNotification.alertBody = [NSString stringWithFormat:@"Alert Fired at %@", _timePicker.date];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
  
    
    UIApplication* app = [UIApplication sharedApplication];

    [app cancelAllLocalNotifications];
    
    NSDate *now = [NSDate date];
    NSDate *notificationDate = [now dateByAddingTimeInterval:60*1];
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = notificationDate;
    localNotification.alertBody = @"Notification Body Text";
    localNotification.alertAction = @"Title";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [app applicationIconBadgeNumber] + 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [app scheduleLocalNotification:localNotification];
     
     */
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    CLCircularRegion *regionToMoniter = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(appdelegate.bestLocation.coordinate.latitude, appdelegate.bestLocation.coordinate.longitude) radius:1 identifier:@"regionMonitorToBG3"];
    
    [appdelegate.locationManager startMonitoringForRegion:regionToMoniter];

}

- (void) addToTv: (NSNotification *) textToAdd
{
    _consoleTV.text = [_consoleTV.text stringByAppendingString:[NSString stringWithFormat:@"\n%@", [textToAdd.userInfo valueForKey:@"message"]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addToTv:) name:@"addToTV" object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
