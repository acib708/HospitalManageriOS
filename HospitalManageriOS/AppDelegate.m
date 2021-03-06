//
//  AppDelegate.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "AppDelegate.h"
#import "actions.h"
#import "TSocketClient.h"
#import "TBinaryProtocol.h"
#import "TFramedTransport.h"

@interface AppDelegate()
@property ActionsClient* server;
@property TSocketClient *transport;
@property TBinaryProtocol *protocol;
@end

@implementation AppDelegate
@synthesize server = _server, transport = _transport, protocol = _protocol;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Override point for customization after application launchh
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(ActionsClient *)getServer{
    if(!_server){
        _transport = [[TSocketClient alloc] initWithHostname:@"192.168.0.103" port:7911];
        _protocol = [[TBinaryProtocol alloc] initWithTransport:_transport strictRead:YES strictWrite:YES];
        _server = [[ActionsClient alloc] initWithProtocol:_protocol];
    }
    
    return _server;
}

-(void)closeServer{
    [_transport close];
    _server    = nil;
}

@end
