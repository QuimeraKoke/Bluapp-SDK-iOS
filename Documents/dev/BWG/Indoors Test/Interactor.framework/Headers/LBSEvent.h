#import <Foundation/Foundation.h>
#import "LBSEventType.h"

@interface LBSEvent : NSObject

@property(nonatomic) NSString * name;
@property(nonatomic) NSString * eventDecription;
@property(nonatomic) enum LBSEventType type;
@property(nonatomic) NSMutableSet * content;

@end
