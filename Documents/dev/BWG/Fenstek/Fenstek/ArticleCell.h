//
//  ArticleCell.h
//  Fenstek
//
//  Created by Jorge Gutiérrez on 01-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleTitleLabel;

@interface ArticleCell : UITableViewCell
{
    UIImageView *_thumbnail;
    ArticleTitleLabel *_titleLabel;
}

@property (nonatomic, retain) UIImageView *thumbnail;
@property (nonatomic, retain) ArticleTitleLabel *titleLabel;
@end
