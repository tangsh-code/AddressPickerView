//
//  HBLocationModel.m
//  HBAddressPickerView
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HBLocationModel.h"

@implementation HBLocationModel

- (instancetype)initWithJsonData:(NSDictionary *)jsonData
{
    self = [super init];
    if (self) {
        self.name = [jsonData objectForKey:@"name"];
        self.code = [jsonData objectForKey:@"code"];
        NSMutableArray * dataList = [NSMutableArray array];
        for (NSDictionary * dict in [jsonData objectForKey:@"list"]) {
            HBLocationModel * location = [[HBLocationModel alloc] initWithJsonData:dict];
            [dataList addObject:location];
        }
        self.list = [NSArray arrayWithArray:dataList];
    }
    
    return self;
}

@end
