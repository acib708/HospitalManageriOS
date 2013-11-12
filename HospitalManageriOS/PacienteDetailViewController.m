//
//  PacienteDetailViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/11/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "PacienteDetailViewController.h"
#import "actions.h"

@interface PacienteDetailViewController ()
//GUI
@property (weak, nonatomic) IBOutlet UIView      *bRegresar;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *lClave;
@property (weak, nonatomic) IBOutlet UILabel *lNombre;
@property (weak, nonatomic) IBOutlet UILabel *lDireccion;
@property (weak, nonatomic) IBOutlet UILabel *lTelefono;
@end


@implementation PacienteDetailViewController
@synthesize bRegresar = _bRegresar, image = _image, delegate = _delegate, paciente = _paciente;
@synthesize lClave = _lClave, lNombre = _lNombre, lDireccion = _lDireccion, lTelefono = _lTelefono;

- (void)viewDidLoad{
    [super viewDidLoad];
    //GUI
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
    
    //Add tap gesture recognizer to button
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimissSelf)];
    [_bRegresar addGestureRecognizer:tgr];
    
    //Populate fields
    _image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", _paciente.clave]];
    if (_image.image == nil)
        _image.image = [UIImage imageNamed:@"default"];
    [_lClave        setText:_paciente.clave];
    [_lNombre       setText:_paciente.nombre];
    [_lDireccion    setText:_paciente.direccion];
    [_lTelefono     setText:_paciente.telefono];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Dismiss Self
-(void)dimissSelf{
    [_delegate pacienteDetailViewControllerDidFinish];
}

@end