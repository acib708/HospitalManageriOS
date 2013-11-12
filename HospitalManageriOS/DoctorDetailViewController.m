//
//  DoctorDetailViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/11/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "DoctorDetailViewController.h"
#import "actions.h"

@interface DoctorDetailViewController ()
//GUI
@property (weak, nonatomic) IBOutlet UIView      *bRegresar;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *lClave;
@property (weak, nonatomic) IBOutlet UILabel *lNombre;
@property (weak, nonatomic) IBOutlet UILabel *lDireccion;
@property (weak, nonatomic) IBOutlet UILabel *lEspecialidad;
@property (weak, nonatomic) IBOutlet UILabel *lTelefono;
@end

@implementation DoctorDetailViewController
@synthesize bRegresar = _bRegresar, image = _image, delegate = _delegate, doctor = _doctor;
@synthesize lClave = _lClave, lNombre = _lNombre, lDireccion = _lDireccion, lEspecialidad = _lEspecialidad, lTelefono = _lTelefono;

- (void)viewDidLoad{
    [super viewDidLoad];
    //GUI
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
    
    //Add tap gesture recognizer to button
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimissSelf)];
    [_bRegresar addGestureRecognizer:tgr];
    
    //Populate fields
    _image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", _doctor.clave]];
    if (_image.image == nil)
        _image.image = [UIImage imageNamed:@"default"];
    [_lClave        setText:_doctor.clave];
    [_lNombre       setText:_doctor.nombre];
    [_lDireccion    setText:_doctor.direccion];
    [_lEspecialidad setText:_doctor.especialidad];
    [_lTelefono     setText:_doctor.telefono];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Dismiss Self
-(void)dimissSelf{
    [_delegate doctorDetailViewControllerDidFinish];
}

@end