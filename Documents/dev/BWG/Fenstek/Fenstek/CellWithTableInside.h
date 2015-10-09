//
//  CellWithTableInside.h
//  Fenstek
//
//  Created by Jorge Gutiérrez on 01-07-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWithTableInside : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableViewInCell;
@property (nonatomic, strong) NSArray* cellData;

@end