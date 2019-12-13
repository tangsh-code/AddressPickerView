//
//  HBAddressPickerView.m
//  HBAddressPickerView
//
//  Created by mac on 2019/12/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HBAddressPickerView.h"


#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface HBAddressPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray * provinceList;
@property (nonatomic, strong) NSArray * cityList;
@property (nonatomic, strong) NSArray * areaList;
@property(strong,nonatomic) HBLocationModel *selectProvince;
@property(strong,nonatomic) HBLocationModel *selectCity;
@property(strong,nonatomic) HBLocationModel *selectArea;

@end

@implementation HBAddressPickerView

+ (instancetype)pickerView
{
   HBAddressPickerView * addressPickerView = [[[NSBundle mainBundle] loadNibNamed:@"HBAddressPickerView" owner:nil options:nil] firstObject];
    addressPickerView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    return addressPickerView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupPickerViewUI];
    [self setupData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)setupPickerViewUI
{
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)setupData
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"city_code" ofType:@"json"];
    NSData * data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    NSLog(@"jsonData = %@", jsonData);
    NSMutableArray * list = [NSMutableArray array];
    for (NSDictionary * provinceDict in jsonData) {
//        NSLog(@"name = %@ code = %@", [provinceDict objectForKey:@"name"], [provinceDict objectForKey:@"code"]);
        HBLocationModel * province = [[HBLocationModel alloc] initWithJsonData:provinceDict];
        [list addObject:province];
    }
    self.provinceList = [list copy];

    if ([self.provinceList count]) {
        HBLocationModel * first = [self.provinceList firstObject];
        self.cityList = first.list;
    }
    if (self.cityList.count) {
        HBLocationModel * first = [self.cityList firstObject];
        self.areaList = first.list;
    }
    [self.pickerView reloadAllComponents];
}

- (void)show
{
    if (@available(iOS 13.0, *)) {
        [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
    } else {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (IBAction)cancelButtonAction:(UIButton *)sender {
    [self dismiss];
}

- (IBAction)sureButtonAction:(id)sender {
    if (self.selectResultBlock) {
        self.selectResultBlock(self.selectProvince, self.selectCity, self.selectArea);
    }
    [self dismiss];
}

#pragma mark -------- <UIPickerViewDataSource, UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        //省
        return self.provinceList.count;
    } else if (component == 1){
        //市
        return self.cityList.count;
    } else {
        // 区县
        return self.areaList.count;
    }
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * list = nil;
    if (component == 0) {
        //省
        list = self.provinceList;
    } else if (component == 1){
        //市
        list = self.cityList;
    } else {
        list = self.areaList;
    }
    HBLocationModel * model = list[row];
    return model.name;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * list = nil;
    if (component == 0) {
        //省
        list = self.provinceList;
    } else if (component == 1){
        //市
        list = self.cityList;
    } else {
        list = self.areaList;
    }
    HBLocationModel * model = list[row];
    NSAttributedString * attributeString = [[NSAttributedString alloc] initWithString:model.name attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    return attributeString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        //省
        self.selectProvince = self.provinceList[row];
        //查出市的数据
        self.cityList = self.selectProvince.list;
        if (self.cityList.count) {
            self.selectCity = self.cityList[0];
        }
        //查出区的数据
        HBLocationModel * firstCity = self.cityList.firstObject;
        self.areaList = firstCity.list;
        self.selectArea = self.areaList[0];
        
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
    } else if (component == 1){
        //市
        if (self.cityList.count) {
            self.selectCity = self.cityList[row];
        }
        self.areaList = self.selectCity.list;
        [self.pickerView reloadComponent:2];
    } else {
        //区
        self.selectArea = self.areaList[row];
    }
}

@end
