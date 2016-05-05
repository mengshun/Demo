//
//  ViewController.m
//  RefreshDemo
//
//  Created by yoho on 16/5/3.
//  Copyright © 2016年 孟顺. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UILabel *_label;
//    UILabel *_statsLabel;
    BOOL _isRefreshing;
    UITableView *_tableView;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 568-64) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);//表向下偏移 40
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 0, 0);//表右侧的 滑动条向下偏移40
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellReuseIdentifier"];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    _label.text = @"俺是头,晓得不";
    _label.backgroundColor = [UIColor purpleColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"刷新中");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.mj_header endRefreshing];
        });
    }];
    [_tableView.mj_header beginRefreshing];
    [self.view bringSubviewToFront:_label];

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint contentOffset = scrollView.contentOffset;
    if (contentOffset.y <= -40) {
        _label.frame = CGRectMake(0, 64, 320, 40);
    } else {
        CGFloat headerHeight = _label.frame.size.height;
        CGRect rect = _label.frame;
        rect.origin.y = 64-(headerHeight+contentOffset.y);
        _label.frame = rect;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
