//
//  PacientesViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "PacientesViewController.h"
#import "actions.h"
#import "HospitalCell.h"

@interface PacientesViewController ()
//Client
@property (nonatomic) ActionsClient*  server;
@property (nonatomic) NSMutableArray* arraySearches;
@property (nonatomic) NSArray* arrayPacientes;

//GUI
@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar      *searchBar;
@property (weak, nonatomic) IBOutlet UIView           *header;

//Selected Patient
@property (weak, nonatomic) NSIndexPath* selectedPatient;

@end

@implementation PacientesViewController
@synthesize server = _server, arrayPacientes = _arrayPacientes, theCollectionView = _theCollectionView, searchBar = _searchBar, arraySearches = _arraySearches, header = _header, selectedPatient = _selectedPatient;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //GUI
    [_theCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]]];
    //Add tap gesture recognizer to button
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [_header addGestureRecognizer:tgr];
    
    @try{
        _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
        _arrayPacientes = [_server consultarPacientes];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] closeServer];
        _arraySearches  = [NSMutableArray arrayWithCapacity:[_arrayPacientes count]];
        [_theCollectionView reloadData];
    }
    @catch(TException *e){
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Hubo un error al conectarse al servidor. Favor de intentar de nuevo."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil] show];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_searchBar resignFirstResponder];
    _selectedPatient = indexPath;
    [self performSegueWithIdentifier:@"modalToPatientDetail" sender:self];
}

#pragma mark - Collection View DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HospitalCell *cell = (HospitalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"patientCell"
                                                                                   forIndexPath:indexPath];
    if([_searchBar.text isEqualToString:@""])
        cell.user = [_arrayPacientes objectAtIndex:indexPath.row];
    else
        cell.user = [_arraySearches objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([_searchBar.text isEqualToString:@""])
        return [_arrayPacientes count];
    
    return [_arraySearches count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

#pragma mark - Search Bar
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [_arraySearches removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.nombre contains[c] %@) OR (SELF.clave contains[c] %@)", searchText, searchText];
    _arraySearches = [NSMutableArray arrayWithArray:[_arrayPacientes filteredArrayUsingPredicate:predicate]];
    [_theCollectionView reloadData];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

-(void)dismissKeyboard{
    [_searchBar resignFirstResponder];
}

#pragma mark - Doctor Detail
-(void)pacienteDetailViewControllerDidFinish{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"modalToPatientDetail"]){
        PacienteDetailViewController* pdvc = (PacienteDetailViewController *)segue.destinationViewController;
        pdvc.delegate = self;
        if([_searchBar.text isEqualToString:@""])
            pdvc.paciente = [_arrayPacientes objectAtIndex:_selectedPatient.row];
        else
            pdvc.paciente = [_arraySearches objectAtIndex:_selectedPatient.row];
    }
}

@end
