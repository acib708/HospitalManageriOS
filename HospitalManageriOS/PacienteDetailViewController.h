//
//  PacienteDetailViewController.h
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/11/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Paciente;
@protocol PacienteDetailViewControllerDelegate
-(void)pacienteDetailViewControllerDidFinish;
@end

@interface PacienteDetailViewController : UIViewController

@property (weak, nonatomic) id<PacienteDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) Paciente* paciente;

@end

