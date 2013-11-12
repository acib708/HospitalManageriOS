//
//  ReporteViewController.h
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/12/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReporteViewControllerDelegate
-(void)reporteViewControllerDidFinish;
@end

@interface ReporteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//Report Types
typedef enum{
    rAnalisisPaciente,
    rDoctoresPaciente,
    rPacientesAnalisis,
    rPacientesDoctor
}ReportType;

//Delegate
@property (nonatomic) id<ReporteViewControllerDelegate> delegate;

//Reports
@property ReportType reportType;
@property (nonatomic) NSArray *reports;

//Key for each report type
@property (weak, nonatomic) NSString* claveAnalisis;
@property (weak, nonatomic) NSString* clavePaciente;
@property (weak, nonatomic) NSString* claveDoctor;

@end
