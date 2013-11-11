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
@property (nonatomic) NSMutableArray* arrayPacientes;

//GUI
@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar      *searchBar;

@end

@implementation PacientesViewController
@synthesize server = _server, arrayPacientes = _arrayPacientes, theCollectionView = _theCollectionView, searchBar = _searchBar, arraySearches = _arraySearches;

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
    
    if(!_server)
        _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
    
    _arraySearches  = [_server consultarPacientes];
    _arrayPacientes = [_arraySearches copy];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
        [self moveForgotSearchBar:@"down"];
    else if(indexPath.row == 1)
        [self moveForgotSearchBar:@"up"];
    
    NSLog(@"Selected %ld", (long)indexPath.row);
}

#pragma mark - Collectino View DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HospitalCell *cell = (HospitalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"pacienteCell"
                                          
                                                                                   forIndexPath:indexPath];
    Paciente* paciente = [_arraySearches objectAtIndex:indexPath.row];
    cell.label.text = paciente.nombre;
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", paciente.clave]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_arraySearches count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

#pragma mark - Animations and Text Fields

-(void)moveForgotSearchBar:(NSString*)position {
    if ([position isEqualToString:@"down"]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationBeginsFromCurrentState:YES];
        _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, (_searchBar.frame.origin.y + 44.0), _searchBar.frame.size.width, _searchBar.frame.size.height);
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationBeginsFromCurrentState:YES];
        _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, (_searchBar.frame.origin.y - 44.0), _searchBar.frame.size.width, _searchBar.frame.size.height);
        [UIView commitAnimations];
    }
}

#pragma mark - Search Bar
- (IBAction)searchPRessed {
    if(_searchBar.frame.origin.y == 46){
        [self moveForgotSearchBar:@"down"];
        [_searchBar becomeFirstResponder];
    }
    else if(_searchBar.frame.origin.y == 90){
        [self moveForgotSearchBar:@"up"];
        [_searchBar resignFirstResponder];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self moveForgotSearchBar:@"up"];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self moveForgotSearchBar:@"up"];
}

@end
