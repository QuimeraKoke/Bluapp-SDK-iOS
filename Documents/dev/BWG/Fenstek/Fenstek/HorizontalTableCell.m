//
//  HorizontalTableCell.m
//  Fenstek
//
//  Created by Jorge Gutiérrez on 01-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "HorizontalTableCell.h"

@implementation HorizontalTableCell

@synthesize horizontalTableView = _horizontalTableView;
@synthesize articles = _articles;

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ArticleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"The title of the cell in the table within the table :O";
    
    return cell;
}

#pragma mark - Memory Management

- (NSString *) reuseIdentifier
{
    return @"HorizontalCell";
}

- (void)dealloc
{
    self.horizontalTableView = nil;
    self.articles = nil;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
