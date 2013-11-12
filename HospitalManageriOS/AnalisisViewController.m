//
//  AnalisisViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "AnalisisViewController.h"
#import "AnalisisCell.h"
#import "actions.h"

@interface AnalisisViewController ()
//Server
@property (nonatomic) ActionsClient*  server;
@property (nonatomic) NSMutableArray* arraySearches;
@property (nonatomic) NSArray* arrayAnalisis;
//GUI
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *header;
//Selected Patient
@property (weak, nonatomic) NSIndexPath* selectedPatient;
@end

@implementation AnalisisViewController
@synthesize server = _server, arrayAnalisis = _arrayAnalisis, arraySearches = _arraySearches;
@synthesize theTableView = _theTableView, header = _header, searchBar = _searchBar;

- (void)viewDidLoad{
    [super viewDidLoad];
    //Add tap gesture recognizer to button
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [_header addGestureRecognizer:tgr];
    
    @try{
        _server = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getServer];
        _arrayAnalisis = [_server consultarAnalisis];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] closeServer];
        _arraySearches  = [NSMutableArray arrayWithCapacity:[_arrayAnalisis count]];
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
                       
#pragma mark - Search Bar
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [_arraySearches removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.clave contains[c] %@) OR (SELF.tipo contains[c] %@) OR (SELF.descripcion contains[c] %@)", searchText, searchText, searchText];
    _arraySearches = [NSMutableArray arrayWithArray:[_arrayAnalisis filteredArrayUsingPredicate:predicate]];
    [_theTableView reloadData];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

-(void)dismissKeyboard{
    [_searchBar resignFirstResponder];
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([_searchBar.text isEqualToString:@""])
        return [_arrayAnalisis count];
    return [_arraySearches count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnalisisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"analisisCell" forIndexPath:indexPath];
    AnalisisClinico *analisis;
    if([_searchBar.text isEqualToString:@""])
        analisis = [_arrayAnalisis objectAtIndex:indexPath.row];
    else
        analisis = [_arraySearches objectAtIndex:indexPath.row];
    
    [cell.lClave       setText:[NSString stringWithFormat:@"%@:",analisis.clave]];
    [cell.lTipo        setText:analisis.tipo];
    [cell.lDescripcion setText:analisis.descripcion];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_searchBar resignFirstResponder];
}

@end
