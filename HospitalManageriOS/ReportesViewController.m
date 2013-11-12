//
//  ReportesViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/11/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "ReportesViewController.h"
#import "actions.h"
#import "AppDelegate.h"

@interface ReportesViewController ()

@property ReportType reportType;

//GUI
@property (weak, nonatomic) IBOutlet UIView *bAnalisisPaciente;
@property (weak, nonatomic) IBOutlet UIView *bDoctoresPaciente;
@property (weak, nonatomic) IBOutlet UIView *bPacientesAnalisis;
@property (weak, nonatomic) IBOutlet UIView *bPacientesDoctor;
@property (nonatomic) UITextField *textField;

//Key for each report type
@property (weak, nonatomic) NSString* claveAnalisis;
@property (weak, nonatomic) NSString* clavePaciente;
@property (weak, nonatomic) NSString* claveDoctor;

//Server
@property (nonatomic) ActionsClient*  server;

//Reports
@property (nonatomic) NSMutableArray* reports;

@end

@implementation ReportesViewController
@synthesize bAnalisisPaciente  = _bAnalisisPaciente,  bDoctoresPaciente = _bDoctoresPaciente, reportType = _reportType;
@synthesize bPacientesAnalisis = _bPacientesAnalisis, bPacientesDoctor  = _bPacientesDoctor, textField = _textField, reports = _reports;
@synthesize claveAnalisis = _claveAnalisis, claveDoctor = _claveDoctor, clavePaciente = _clavePaciente, server = _server;

- (void)viewDidLoad{
    [super viewDidLoad];
    //Add actions
    UITapGestureRecognizer* tapAnalisisPaciente  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(generarAnalisisPaciente)];
    UITapGestureRecognizer* tapDoctoresPaciente  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(generarDoctoresPaciente)];
    UITapGestureRecognizer* tapPacientesAnalisis = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(generarPacientesAnalisis)];
    UITapGestureRecognizer* tapPacientesDoctor   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(generarPacientesDoctor)];
    [_bAnalisisPaciente  addGestureRecognizer:tapAnalisisPaciente];
    [_bDoctoresPaciente  addGestureRecognizer:tapDoctoresPaciente];
    [_bPacientesAnalisis addGestureRecognizer:tapPacientesAnalisis];
    [_bPacientesDoctor   addGestureRecognizer:tapPacientesDoctor];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Generar Reportes
-(void)generarAnalisisPaciente{
    _reportType = rAnalisisPaciente;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Análisis Paciente"
                                                    message:@"Proporcionar clave del paciente."
                                                   delegate:self
                                          cancelButtonTitle:@"Regresar"
                                          otherButtonTitles:@"Generar Reporte", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];

    [alert addSubview:_textField];
    [alert show];
}

-(void)generarDoctoresPaciente{
    _reportType = rDoctoresPaciente;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Doctores Paciente"
                                                    message:@"Proporcionar clave del paciente."
                                                   delegate:self
                                          cancelButtonTitle:@"Regresar"
                                          otherButtonTitles:@"Generar Reporte", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];

    [alert addSubview:_textField];
    [alert show];
}

-(void)generarPacientesAnalisis{
    _reportType = rPacientesAnalisis;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pacientes Análisis"
                                                    message:@"Proporcionar clave del análisis."
                                                   delegate:self
                                          cancelButtonTitle:@"Regresar"
                                          otherButtonTitles:@"Generar Reporte", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [alert addSubview:_textField];
    [alert show];
}

-(void)generarPacientesDoctor{
    _reportType = rPacientesDoctor;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pacientes Doctor"
                                                    message:@"Proporcionar clave del doctor."
                                                   delegate:self
                                          cancelButtonTitle:@"Regresar"
                                          otherButtonTitles:@"Generar Reporte", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];

    [alert addSubview:_textField];
    [alert show];
}

#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if([[[alertView textFieldAtIndex:0] text] isEqualToString:@""] && buttonIndex != 0)
        [[[UIAlertView alloc] initWithTitle:@"Reportes"
                                    message:@"Favor de proporcionar una clave."
                                   delegate:nil
                          cancelButtonTitle:@"Regresar"
                          otherButtonTitles:nil] show];
    
    else if(buttonIndex == 1){ //Generate report
        //Init variables
        UIAlertView* noReports = [[UIAlertView alloc] initWithTitle:@"Reportes"
                                                            message:@"No se encontró ningun reporte para esa clave. Intentar otra búsqueda."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Regresar"
                                                  otherButtonTitles:nil];
        
        @try{
            switch (_reportType) {
                case rAnalisisPaciente:
                    _clavePaciente = [[alertView textFieldAtIndex:0] text];
                    if(_reports.count == 0) [noReports show];
                    else [self performSegueWithIdentifier:@"modalToReport" sender:self];
                    break;
                case rDoctoresPaciente:
                    _clavePaciente = [[alertView textFieldAtIndex:0] text];
                    _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
                    _reports = [_server generarReporteDoctoresPaciente:_clavePaciente];
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] closeServer];
                    if(_reports.count == 0) [noReports show];
                    else [self performSegueWithIdentifier:@"modalToReport" sender:self];
                    break;
                case rPacientesAnalisis:
                    _claveAnalisis = [[alertView textFieldAtIndex:0] text];
                    _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
                    _reports = [_server generarReportePacientesAnalisis:_claveAnalisis];
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] closeServer];
                    if(_reports.count == 0) [noReports show];
                    else [self performSegueWithIdentifier:@"modalToReport" sender:self];
                    break;
                case rPacientesDoctor:
                    _claveDoctor   = [[alertView textFieldAtIndex:0] text];
                    _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
                    _reports = [_server generarReportePacientesDoctor:_claveDoctor];
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] closeServer];
                    if(_reports.count == 0) [noReports show];
                    else [self performSegueWithIdentifier:@"modalToReport" sender:self];
                    break;
                default:
                    [NSException raise:@"Unknown report type." format:@"There was an error with reports."];
                    break;
            }
        }
        @catch(TException *e){
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:@"Hubo un error al conectarse al servidor. Favor de intentar de nuevo."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil] show];
        }
    }
}

#pragma mark - Reporte Detail Delegate
-(void)reporteViewControllerDidFinish{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"modalToReport"]){
        ReporteViewController* rvc = (ReporteViewController *)segue.destinationViewController;
        rvc.reportType = _reportType;
        rvc.delegate   = self;
        rvc.reports    = [_reports copy];
        rvc.clavePaciente = _clavePaciente;
        rvc.claveDoctor   = _claveDoctor;
        rvc.claveAnalisis = _claveAnalisis;
    }
}

@end
