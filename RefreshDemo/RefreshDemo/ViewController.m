//
//  ViewController.m
//  RefreshDemo
//
//  Created by yoho on 16/5/3.
//  Copyright © 2016年 孟顺. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UILabel *_label;
    UILabel *_statsLabel;
    BOOL _isRefreshing;
    UITableView *_tableView;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-64) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellReuseIdentifier"];
    
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, -80, 200, 40)];
    headView.backgroundColor = [UIColor redColor];
    _tableView.backgroundView = headView;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    _label.text = @"我是头";
    _label.backgroundColor = [UIColor purpleColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:_label];
    
    _statsLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
    _statsLabel.text = @"下拉刷新";
    _statsLabel.backgroundColor = [UIColor orangeColor];
    _statsLabel.textColor = [UIColor whiteColor];
    _statsLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:_statsLabel];

    // Do any additional setup after loading the view, typically from a nib.
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat headerHeight = _label.frame.size.height;
    CGPoint contentOffset = scrollView.contentOffset;
    if (contentOffset.y >= 0 || contentOffset.y <= -40) {
        _label.frame = CGRectMake(0, 0, 320, 40);
        if (contentOffset.y < -100) {
            _statsLabel.text = @"松手开始刷新";
        } else if (contentOffset.y == -80) {
            if (_isRefreshing) {
                _isRefreshing = NO;
                _statsLabel.text = @"正在刷新";
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _statsLabel.text = @"下拉刷新";
                    [_tableView setContentOffset:CGPointMake(0, -40) animated:YES];
                });
            }
        } else {
            _statsLabel.text = @"下拉刷新";
        }
    } else {
        CGRect rect = _label.frame;
        rect.origin.y = -headerHeight-contentOffset.y;
        _label.frame = rect;
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < -100) {
        _isRefreshing = YES;
       dispatch_async(dispatch_get_main_queue(), ^{
           [_tableView setContentOffset:CGPointMake(0, -80) animated:YES];
       });
    } else {
        _isRefreshing = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
