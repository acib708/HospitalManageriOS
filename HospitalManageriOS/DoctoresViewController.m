//
//  DoctoresViewController.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "DoctoresViewController.h"
#import "actions.h"
#import "HospitalCell.h"

@interface DoctoresViewController ()
//Client
@property (nonatomic) ActionsClient*  server;
@property (nonatomic) NSMutableArray* arrayDoctores;

//GUI
@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;


@end

@implementation DoctoresViewController
@synthesize server = _server, arrayDoctores = _arrayDoctores, theCollectionView = _theCollectionView;

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
    
    _arrayDoctores = [_server consultarDoctores];
//    NSLog(@"%@",_arrayDoctores);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected %d", (int)indexPath.row);
}

#pragma mark - Collectino View DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HospitalCell *cell = (HospitalCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"doctorCell"
                                                                                   forIndexPath:indexPath];
    
    Doctor* doc = [_arrayDoctores objectAtIndex:indexPath.row];
    cell.label.text = doc.nombre;
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", (int)indexPath.row+1]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_arrayDoctores count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

#pragma mark - Search Pressed
- (IBAction)searchPressed {
}


@end
