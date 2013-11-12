//
//  ReporteViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/12/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "ReporteViewController.h"
#import "actions.h"
#import "ReportCell.h"

@interface ReporteViewController ()
//GUI
@property (weak, nonatomic) IBOutlet UIView *bRegresar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lTop;
@property (weak, nonatomic) IBOutlet UILabel *lBottom;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

//Server
@property (nonatomic) ActionsClient*  server;

@end

@implementation ReporteViewController
@synthesize delegate = _delegate, reports = _reports, reportType = _reportType, bRegresar = _bRegresar;
@synthesize imageView = _imageView, lTop = _lTop, lBottom = _lBottom, theTableView = _theTableView;
@synthesize claveAnalisis = _claveAnalisis, claveDoctor = _claveDoctor, clavePaciente = _clavePaciente;

- (void)viewDidLoad{
    [super viewDidLoad];
    //Server
    if(!_server)
        _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
    
    //GUI
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
    
    //Add tap gesture recognizer to button
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
    [_bRegresar addGestureRecognizer:tgr];
    
    //Populate view according to report type
    switch(_reportType){
        case rAnalisisPaciente:
            [self displayAnalisisPaciente];
            break;
        case rDoctoresPaciente:
            [self displayDoctoresPaciente];
            break;
        case rPacientesAnalisis:
            [self displayPacientesAnalisis];
            break;
        case rPacientesDoctor:
            [self displayPacientesDoctor];
            break;
        default:
            [NSException raise:@"Wrong type of report." format:@"Asked to populate view for unknown report type. Aborting."];
            break;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Dismiss Self
-(void)dismissSelf{
    [_delegate reporteViewControllerDidFinish];
}

#pragma mark - Reports
-(void)displayAnalisisPaciente{
    Paciente* paciente = [_server consultarPacienteClave:_clavePaciente];
    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", paciente.clave]]];
    [_lTop setText:[NSString stringWithFormat:@"Paciente %@", paciente.clave]];
    [_lBottom setText:paciente.nombre];
}

-(void)displayDoctoresPaciente{
    Paciente* paciente = [_server consultarPacienteClave:_clavePaciente];
    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", paciente.clave]]];
    [_lTop setText:[NSString stringWithFormat:@"Paciente %@", paciente.clave]];
    [_lBottom setText:paciente.nombre];
}

-(void)displayPacientesAnalisis{
    AnalisisClinico* analisis = [_server consultarAnalisisClave:_claveAnalisis];
    [_imageView setImage:[UIImage imageNamed:@"imageAnalisis.jpg"]];
    [_lTop setText:[NSString stringWithFormat:@"Análisis %@", analisis.clave]];
    [_lBottom setText:[NSString stringWithFormat:@"%@ | %@", analisis.tipo, analisis.descripcion]];
}

-(void)displayPacientesDoctor{
    Doctor* doctor = [_server consultarDoctorClave:_claveDoctor];
    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", doctor.clave]]];
    [_lTop setText:[NSString stringWithFormat:@"Doctor %@", doctor.clave]];
    [_lBottom setText:doctor.nombre];
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_reports count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportCell" forIndexPath:indexPath];
    
    if(_reportType == rAnalisisPaciente){
        ReporteAnalisisPaciente* current = [_reports objectAtIndex:indexPath.row];
        [cell setImage:[UIImage imageNamed:@"imageAnalisis.jpg"]];
        [cell.label setText:[NSString stringWithFormat:@"Tipo: %@ | Descripción: %@ | Aplicación: %@ | Entrega: %@", current.tipo, current.descripcion, current.fechaAplic, current.fechaEntrega]];
    }
    else if(_reportType == rDoctoresPaciente){
        ReporteDoctoresPaciente* current = [_reports objectAtIndex:indexPath.row];
        [cell setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",current.claveDoctor]]];
        [cell.label setText:[NSString stringWithFormat:@"Doctor: %@ | Tratamiento: %@ | Diagnóstico: %@ | Fecha: %@", current.nombreDoctor, current.tratamiento, current.diagnostico, current.fecha]];
    }
    else if(_reportType == rPacientesAnalisis){
        ReportePacientesAnalisis* current = [_reports objectAtIndex:indexPath.row];
        [cell setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",current.clavePaciente]]];
        [cell.label setText:[NSString stringWithFormat:@"Paciente: %@ | Aplicación: %@ | Entrega: %@",current.nombrePaciente, current.fechaAplic, current.fechaEntrega]];
    }
    else if(_reportType == rPacientesDoctor){
        ReportePacientesDoctor* current = [_reports objectAtIndex:indexPath.row];
        [cell setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",current.clavePaciente]]];
        [cell.label setText:[NSString stringWithFormat:@"Paciente: %@ | Tratamiento: %@ | Diagnóstic: %@",current.nombrePaciente, current.tratamiento, current.diagnostico]];
    }
    return cell;
}

@end
