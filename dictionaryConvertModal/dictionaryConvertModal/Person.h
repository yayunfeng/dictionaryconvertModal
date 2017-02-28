//
//  Person.h
//  runtime
//
//  Created by 冯亚运 on 16/7/25.
//  Copyright © 2016年 冯亚运. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Man.h"
#import "Woman.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *age;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, strong) Man *man;

@property (nonatomic, strong) NSArray<Woman *> *woman;

+ (NSDictionary *)objectClassInArray;
@end
