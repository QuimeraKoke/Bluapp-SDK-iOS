//
//  ArticleCell.m
//  Fenstek
//
//  Created by Jorge Gutiérrez on 01-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell
@synthesize thumbnail = _thumbnail;
@synthesize titleLabel = _titleLabel;

#pragma mark - View Lifecycle

- (NSString *)reuseIdentifier
{
    return @"ArticleCell";
}

#pragma mark - Memory Management

- (void)dealloc
{
    self.thumbnail = nil;
    self.titleLabel = nil;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
