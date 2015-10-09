//
//  CellWithTableInside.m
//  Fenstek
//
//  Created by Jorge Gutiérrez on 01-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "CellWithTableInside.h"

@implementation CellWithTableInside

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@synthesize tableViewInCell;
@synthesize cellData = _cellData;

- (void)setCellData:(NSArray *)cellData
{
    _cellData = cellData;
    [tableViewInCell reloadData];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [tableViewInCell setFrame:self.bounds];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupTableView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView
{
    tableViewInCell = [[UITableView alloc] initWithFrame:self.bounds];
    [tableViewInCell setDataSource:self];
    [tableViewInCell setDelegate:self];
    [self addSubview:tableViewInCell];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NestedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.cellData objectAtIndex:indexPath.row];
    return cell;
}

@end
