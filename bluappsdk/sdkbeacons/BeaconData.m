//
//  BeaconData.m
//  bluappsdk
//
//  Created by Jorge Gutiérrez on 04-09-15.
//
//

#import "BeaconData.h"

@implementation BeaconData
-(instancetype)init: (NSString*)title body:(NSString*)cuerpo cover:(NSString*)cubierta URl:(NSString*)url type:(NSString*)tipo{
    self.title=title;
    self.body=cuerpo;
    self.type=tipo;
    self.url=url;
    self.cover=[UIImage imageNamed:@""];
    return self;
}
@end
