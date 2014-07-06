//
//  ViewController.h
//  backgroundTest
//
//  Created by kushal bindra on 01/07/14.
//  Copyright (c) 2014 com.kush.devtest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextView *consoleTV;

- (IBAction) setLocalNotificationAlert;

- (IBAction) findLocationBtnAction;

@end
