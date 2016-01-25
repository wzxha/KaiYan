//
//  ViewController.m
//  WZXKaiYanDemo
//
//  Created by wordoor－z on 16/1/25.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  数据数组
 */
@property(nonatomic,strong) NSMutableArray * dataArray;

/**
 *  tableview
 */
@property(nonatomic,strong) UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preData];
    [self createTableView];
}

//准备数据
- (void)preData
{
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 20; i++)
    {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [_dataArray addObject:image];
    }
}

//创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark ---------tableView-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil)
    {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    return cell;
}

//在willDisplayCell里面处理数据能优化tableview的滑动流畅性
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell * myCell = (MyCell *)cell;
    
    [myCell setImg:_dataArray[indexPath.row]];
    
    [myCell cellOffset];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height/3.0;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // visibleCells 获取界面上能显示出来了cell
    NSArray<MyCell *> *array = [self.tableView visibleCells];
    
    //enumerateObjectsUsingBlock 类似于for，但是比for更快
    [array enumerateObjectsUsingBlock:^(MyCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj cellOffset];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
