//
//  HospitalCell.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "HospitalCell.h"
#import "actions.h"

@interface HospitalCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation HospitalCell
@synthesize label = _label, imageView = _imageView, user = _user;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setUser:(id)user{
    if([user isMemberOfClass:[Doctor class]]){
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",((Doctor *)user).clave]];
        if (_imageView.image == nil)
            _imageView.image = [UIImage imageNamed:@"default.jpg"];
        _label.text      = ((Doctor *)user).nombre;
    }
    else if([user isMemberOfClass:[Paciente class]]){
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",((Paciente *)user).clave]];
        _label.text      = ((Paciente *)user).nombre;
    }
}

-(void)prepareForReuse{
    [super prepareForReuse];
    _imageView.image = nil;
}

@end
