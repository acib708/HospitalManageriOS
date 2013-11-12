//
//  AnalisisCell.h
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/11/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalisisCell : UITableViewCell

//GUI
@property (weak, nonatomic) IBOutlet UILabel *lClave;
@property (weak, nonatomic) IBOutlet UILabel *lTipo;
@property (weak, nonatomic) IBOutlet UILabel *lDescripcion;


@end
