//
//  NextViewController.m
//  RefreshDemo
//
//  Created by yoho on 16/5/3.
//  Copyright © 2016年 孟顺. All rights reserved.
//

#import "NextViewController.h"
@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"此页面无效";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-64) style:UITableViewStyleGrouped];
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellReuseIdentifier"];
    

    // Do any additional setup after loading the view.
}
- (UIEdgeInsets)alignmentRectInsets{
    return UIEdgeInsetsMake(40, 0, 0, 0);;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld %ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 60)];
    sectionHeader.backgroundColor = [UIColor greenColor];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:sectionHeader.bounds];
    headLabel.text = [NSString stringWithFormat:@"%ld",(long)section];
    headLabel.textColor = [UIColor blackColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    [sectionHeader addSubview:headLabel];
    return sectionHeader;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
