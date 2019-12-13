//
//  HBAddressPickerView.h
//  HBAddressPickerView
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBLocationModel.h"

typedef void(^ResultBlock)(HBLocationModel * _Nullable province, HBLocationModel * _Nullable city, HBLocationModel * _Nullable area);

NS_ASSUME_NONNULL_BEGIN

@interface HBAddressPickerView : UIView

@property (nonatomic, copy) ResultBlock selectResultBlock;

+ (instancetype)pickerView;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
