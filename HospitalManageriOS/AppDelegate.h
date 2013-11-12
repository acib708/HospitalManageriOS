//
//  AppDelegate.h
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionsClient;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(ActionsClient *)getServer;
-(void)closeServer;

@end
