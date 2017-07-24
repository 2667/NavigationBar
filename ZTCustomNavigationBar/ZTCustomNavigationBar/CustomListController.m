//
//  CustomListController.m
//  ZTCustomNavigationBar
//
//  Created by 荣 li on 2017/7/24.
//  Copyright © 2017年 荣 li. All rights reserved.
//

#import "CustomListController.h"
#import "CustomNavBarController.h"
#import "ImageNavController.h"
#import "MillcolorGradController.h"
@interface CustomListController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CustomListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.navBar aboveSubview:self.tableView];
    self.navItem.title = @"自定义导航栏";}

#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = nil;
    switch (indexPath.row) {
        case 0:
            str = @"主页";
            break;
        case 1:
            str = @"导航栏显示图片";
            break;
        case 2:
            str = @"实现导航栏渐变色的另一种方式";
            break;
            
        default:
            break;
    }
    cell.textLabel.text = str;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            CustomNavBarController *customNavBarVC = [CustomNavBarController new];
            [self.navigationController pushViewController:customNavBarVC animated:YES];
        }
            break;
        case 1:
        {
            ImageNavController *imageNavVC = [ImageNavController new];
            [self.navigationController pushViewController:imageNavVC animated:YES];
        }
            break;
        case 2:
        {
            MillcolorGradController *millcolorGradVC = [MillcolorGradController new];
            [self.navigationController pushViewController:millcolorGradVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
