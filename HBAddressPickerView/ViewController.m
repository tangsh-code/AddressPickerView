//
//  ViewController.m
//  HBAddressPickerView
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonAction:(id)sender {
    
    HBAddressPickerView * addressPickerView = [HBAddressPickerView pickerView];
    addressPickerView.selectResultBlock = ^(HBLocationModel * _Nullable province, HBLocationModel * _Nullable city, HBLocationModel * _Nullable area) {
        NSLog(@"province = %@ city = %@ area = %@", province.name, city.name, area.name);
    };
    [addressPickerView show];
}

@end
