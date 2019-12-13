//
//  HBLocationModel.h
//  HBAddressPickerView
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBLocationModel : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSArray<HBLocationModel *> * list;

- (instancetype)initWithJsonData:(NSDictionary *)jsonData;

@end

NS_ASSUME_NONNULL_END
