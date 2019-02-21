//
//  TableViewTrackViewController.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/9.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "TableViewTrackViewController.h"
#import "UIView+AnalysisBind.h"

@interface TableViewTrackViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *infoArray;

@end

@implementation TableViewTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.infoArray = [self createData];
    // Do any additional setup after loading the view.
}

- (NSArray *)createData {
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 25; i++) {
        NSString *string = [NSString stringWithFormat:@"name rand %ld", random()%25];
        [dataArray addObject:string];
    }
    return dataArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"Cell";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.info = [[TrackModel alloc] initWithTrackId:[NSString stringWithFormat:@"%ld", indexPath.row] trackName:self.infoArray[indexPath.row] trackInfo:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
