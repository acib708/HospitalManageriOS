//
//  AnalisisViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "AnalisisViewController.h"
#import "actions.h"

@interface AnalisisViewController ()
@property(nonatomic) ActionsClient* server;
@end

@implementation AnalisisViewController
@synthesize server = _server;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if(!_server)
        _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
