//
//  HospitalCell.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/10/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "HospitalCell.h"

@interface HospitalCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation HospitalCell
@synthesize image = _image, label = _label, imageView = _imageView;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setImage:(UIImage *)image{
    _imageView.image = image;
}

-(void)prepareForReuse{
    [super prepareForReuse];
    _imageView.image = nil;
}

@end
