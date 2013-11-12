//
//  DoctorDetailViewController.h
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/11/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Doctor;
@protocol DoctorDetailViewControllerDelegate
-(void)doctorDetailViewControllerDidFinish;
@end

@interface DoctorDetailViewController : UIViewController

@property (weak, nonatomic) id<DoctorDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) Doctor* doctor;

@end
