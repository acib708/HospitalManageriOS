//
//  PacientesViewController.h
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PacienteDetailViewController.h"

@interface PacientesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, PacienteDetailViewControllerDelegate>

@end
