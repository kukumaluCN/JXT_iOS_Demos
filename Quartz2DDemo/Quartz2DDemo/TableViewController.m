//
//  TableViewController.m
//  Quartz2DDemo
//
//  Created by JXT on 2017/2/8.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "TableViewController.h"

#import "CanvasViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray * dataArray;
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Quartz2DDemo";
    
    self.tableView.rowHeight = 60;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    
    self.dataArray = @[
                       @"0.画1/4圆（扇形）",
                       @"1.画矩形、正方形",
                       @"2.UIBezierPath画扇形",
                       @"3.画圆形",
                       @"4.画圆角矩形",
                       @"5.画直线",
                       @"6.画曲线",
                       @"7.画饼图",
                       @"8.绘制文字",
                       @"9.加水印",
                       @"10.屏幕截图",
                       ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CanvasViewController *canvasVC = [[CanvasViewController alloc] init];
    canvasVC.index = indexPath.row;
    canvasVC.indexTitle = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:canvasVC animated:YES];
}


@end
