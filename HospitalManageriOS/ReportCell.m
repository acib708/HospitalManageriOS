//
//  ReportCell.m
//  HospitalManageriOS
//
//  Created by Alejandro Cárdenas on 11/12/13.
//  Copyright (c) 2013 Aplicaciones Web. All rights reserved.
//

#import "ReportCell.h"

@interface ReportCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ReportCell
@synthesize imageView = _imageView, label = _label, image = _image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImage:(UIImage *)image{
    _imageView.image = image;
}

@end
