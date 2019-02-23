//
//  StopListViewController.m
//  Aria2
//
//  Created by zj14 on 2019/2/23.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import "StopListViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "APIUtils.h"
#import "FileCell.h"
#import "UIView+TYAlertView.h"

@interface StopListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) NSMutableArray *list;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation StopListViewController

- (void)viewDidDisappear:(BOOL)animated {
    [_timer invalidate];
    _timer = nil;
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setTitle:@"已完成/已停止"];
    _list = [NSMutableArray new];

    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView =
            [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
//        tableView.estimatedRowHeight = 200;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = YES;
        [self.view addSubview:tableView];

        tableView.backgroundColor = ymBackgroudColor;
        [tableView registerClass:[FileCell class] forCellReuseIdentifier:@"FileCellText"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });

    [self fresh];
    _timer =
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fresh) userInfo:nil repeats:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCellText"];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[FileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FileCellText"];
    }
    TaskInfo *act = _list[indexPath.row / 2];
    cell.activite = act;
    return cell;
}

- (void)fresh {
    [APIUtils listStopped:_rpcUri
        success:^(NSArray *activite, NSInteger count) {
            _list = [activite mutableCopy];
            [_myTableView reloadData];
        }
        failure:^(NSString *msg) {
            [MsgUtils showMsg:msg];
        }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择操作"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];

        [alert addAction:[UIAlertAction actionWithTitle:@"删除"
                                                  style:UIAlertActionStyleDestructive
                                                handler:^(UIAlertAction *_Nonnull action) {
                                                    TaskInfo *act = _list[indexPath.row / 2];
                                                    [APIUtils removeResultByGid:act.gid
                                                                         rpcUri:_rpcUri
                                                                        success:^(NSString *okmsg) {
                                                                            [MsgUtils showMsg:@"已删除下载记录"];
                                                                        }
                                                                        failure:nil];
                                                }]];

        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

        [self presentViewController:alert animated:YES completion:nil];
    }
}

//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_list count];
}

@end
