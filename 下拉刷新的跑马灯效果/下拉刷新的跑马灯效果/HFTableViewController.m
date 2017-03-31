//
//  HFTableViewController.m
//  下拉刷新的跑马灯效果
//
//  Created by 黄来峰 on 2017/3/31.
//  Copyright © 2017年 com.gmw.love. All rights reserved.
//

#import "HFTableViewController.h"
#import "UIScrollView+HFRefresh.h"
@interface HFTableViewController ()

@end

@implementation HFTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithAction:^{
        [weakSelf headerActionOpration];
    }customControl:^(HFDrawTextView *drawView) {
        drawView.refreshText = @"Code4app";
        drawView.textColor = [UIColor redColor];
    }];
}

- (void)headerActionOpration{
    [self.tableView performSelector:@selector(endHeaderRefresh) withObject:nil afterDelay:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
