//
//  ViewController.m
//  YYZMainProj
//
//  Created by yangyongzheng on 2019/12/18.
//  Copyright © 2019 yangyongzheng. All rights reserved.
//

#import "ViewController.h"
#import "DateTableViewCell.h"
#import "TitleHeaderView.h"
#import <YYZKit/YYZKit.h>
#import "YearMonth.h"
#import "SDDDateProvider.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray<NSArray<SDDDateItem *> *> *viewModels;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self.tableView registerNib:[UINib nibWithNibName:@"DateTableViewCell" bundle:NSBundle.mainBundle]
         forCellReuseIdentifier:@"DateTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleHeaderView" bundle:NSBundle.mainBundle]
forHeaderFooterViewReuseIdentifier:@"TitleHeaderView"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModels[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateTableViewCell"];
    SDDDateItem *model = self.viewModels[indexPath.section][indexPath.row];
    cell.monthLabel.text = [NSString stringWithFormat:@"%02ld月", model.monthNum];
    NSArray<UIButton *> *buttons = cell.stackView.arrangedSubviews;
    if (model.enabledMonthPeriods & SDDDateMonthPeriodFirst) {
        buttons[0].backgroundColor = UIColor.greenColor;
    } else {
        buttons[0].backgroundColor = UIColor.grayColor;
    }
    if (model.enabledMonthPeriods & SDDDateMonthPeriodSecond) {
        buttons[1].backgroundColor = UIColor.greenColor;
    } else {
        buttons[1].backgroundColor = UIColor.grayColor;
    }
    if (model.enabledMonthPeriods & SDDDateMonthPeriodThird) {
        buttons[2].backgroundColor = UIColor.greenColor;
    } else {
        buttons[2].backgroundColor = UIColor.grayColor;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TitleHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TitleHeaderView"];
    headerView.yearLabel.text = [NSString stringWithFormat:@"%ld", self.viewModels[section].firstObject.yearNum];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 52;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SDDDateItem *firstItem = self.viewModels.firstObject.firstObject;
    SDDDateItem *lastItem = self.viewModels.lastObject.lastObject;
    NSDate *startDate = [SDDDateProvider startFuzzyDateWithFirstItem:firstItem];
    NSDate *endDate = [SDDDateProvider endFuzzyDateWithLastItem:lastItem];
    if ([SDDDateProvider validateDate:NSDate.date minDate:startDate maxDate:endDate]) {
        NSLog(@"nice");
    }
}

- (void)setup {
    NSDate *date = [SDDDateProvider dateFromString:@"2020-07-10" dateFormat:@"yyyy-MM-dd"];
    self.viewModels = [SDDDateProvider presaleFuzzyDateItemsWithTodayDate:date];
}

@end
