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
    
    _arrayPacientes  = [_server consultarPacientes];
    _arraySearches = [NSMutableArray arrayWithCapacity:[_arrayPacientes count]];
    [_theCollectionView reloadData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_searchBar resignFirstResponder];
}

#pragma mark - Collection View DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HospitalCell *cell = (HospitalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"pacienteCell"
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

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [_searchBar resignFirstResponder];
//}

@end
