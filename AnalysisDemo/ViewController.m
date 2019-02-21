//
//  ViewController.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "ViewController.h"
#import "UIView+AnalysisBind.h"
#import "TableViewTrackViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    int copyType;
}

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *titleArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    copyType = 0;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, 400, 60, 60)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    button.info = [[TrackModel alloc] initWithTrackId:@"6633" trackName:@"Goods" trackInfo:nil];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(150, 400, 60, 60)];
    view.backgroundColor = [UIColor grayColor];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
    [self.view addSubview:view];
    view.info = [[TrackModel alloc] initWithTrackId:@"6644" trackName:@"Activity" trackInfo:nil];
    
    
    UIButton *tagsbutton = [[UIButton alloc] initWithFrame:CGRectMake(250, 400, 60, 60)];
    [tagsbutton addTarget:self action:@selector(tagsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tagsbutton];
    tagsbutton.backgroundColor = [UIColor orangeColor];
    tagsbutton.info = [[TrackModel alloc] initWithTrackId:@"" trackName:@"" trackInfo:nil viewTag:tagsbutton.tag];
    
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(60, 340, 200, 40)];
    [self.view addSubview:textFiled];
    textFiled.borderStyle = UITextBorderStyleRoundedRect;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonClick {
    TableViewTrackViewController *vc = [[TableViewTrackViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewTapped:(UITapGestureRecognizer *)tap {
    
}

//target多事件
- (void)tagsButtonClick:(UIButton *)sender {
    if (copyType == 0) {
        sender.tag = 1;
        copyType = 1;
    } else {
        sender.tag = 0;
        copyType = 0;
    }
    sender.info = [[TrackModel alloc] initWithTrackId:@"" trackName:@"" trackInfo:nil viewTag:sender.tag];
}

#pragma mark - tablView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.info =  [[TrackModel alloc] initWithTrackId:@"1200" trackName:@"CellClick" trackInfo:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

@end
