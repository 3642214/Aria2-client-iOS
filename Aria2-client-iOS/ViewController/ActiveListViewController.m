//
//  ActiveListViewController.m
//  Aria2
//
//  Created by zj14 on 2019/2/23.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import "ActiveListViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "APIUtils.h"
#import "FileCell.h"
#import "UIView+TYAlertView.h"
#import "ButtonCell.h"
#import "StopListViewController.h"

@interface ActiveListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) NSMutableArray *list;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) ButtonCell *stopBtn;
@end

@implementation ActiveListViewController

- (void)viewWillAppear:(BOOL)animated {
    if (_timer && !_timer.valid) {
        [_timer fire];
    } else {
        _timer =
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fresh) userInfo:nil repeats:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [_timer invalidate];
    _timer = nil;
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setTitle:@"正在下载"];
    _list = [NSMutableArray new];

    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                      target:self
                                                      action:@selector(create)];

    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView =
            [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.estimatedRowHeight = 67;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = YES;
        [self.view addSubview:tableView];

        tableView.backgroundColor = ymBackgroudColor;
        [tableView registerClass:[FileCell class] forCellReuseIdentifier:@"FileCellText"];
        [tableView registerClass:[ButtonCell class] forCellReuseIdentifier:@"ButtonCellText"];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });

    [self fresh];
}

- (void)create {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"新增下载任务" message:nil];

    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入下载链接";
        textField.text = [[UIPasteboard generalPasteboard] string];
    }];

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:nil]];
    __typeof(alertView) __weak weakAlertView = alertView;
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定"
                                                  style:TYAlertActionStyleDestructive
                                                handler:^(TYAlertAction *action) {
                                                    for (UITextField *textField in weakAlertView.textFieldArray) {
                                                        [APIUtils addUri:textField.text
                                                            rpcUri:_rpcUri
                                                            success:^(NSString *gid) {
                                                                LLog(@"ok");
                                                            }
                                                            failure:^(NSString *msg) {
                                                                [MsgUtils showMsg:msg];
                                                            }];
                                                    }
                                                }]];
    [alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_list count] == 0 || indexPath.row == [_list count]) {
        if (!_stopBtn) {
            _stopBtn = [[ButtonCell alloc] initWithBtnStyle:StrapDangerStyle
                                                      title:@"完成/停止列表"
                                                 clickEvent:^{
                                                     StopListViewController *vc = [StopListViewController new];
                                                     vc.rpcUri = _rpcUri;
                                                     [self gotoVC:vc];
                                                 }];
        }
        return _stopBtn;
    } else {
        FileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCellText"];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[FileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FileCellText"];
        }
        TaskInfo *act = _list[indexPath.row];
        cell.activite = act;
        return cell;
    }
}

- (void)fresh {
    [APIUtils listActiveAndStop:_rpcUri
        success:^(NSArray *taskInfos, NSInteger count) {
            _list = [taskInfos mutableCopy];
            [_myTableView reloadData];
        }
        failure:^(NSString *msg) {
            [MsgUtils showMsg:msg];
        }];
    //    [APIUtils listActiveSuccess:^(NSArray *activite, NSInteger count) {
    //        _list = [activite mutableCopy];
    //        [_myTableView reloadData];
    //    }
    //        failure:^(NSString *msg) {
    //            [MsgUtils showMsg:msg];
    //        }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskInfo *taskInfo = _list[indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择操作"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];

    [alert addAction:[UIAlertAction actionWithTitle:[taskInfo.status isEqualToString:@"active"] ? @"暂停" : @"恢复"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                if ([taskInfo.status isEqualToString:@"active"]) {
                                                    [APIUtils pauseByGid:taskInfo.gid
                                                                  rpcUri:_rpcUri
                                                                 success:^(NSString *okmsg) {
                                                                     [MsgUtils showMsg:@"已暂停下载"];
                                                                 }
                                                                 failure:nil];
                                                } else {
                                                    [APIUtils unpauseByGid:taskInfo.gid
                                                                    rpcUri:_rpcUri
                                                                   success:^(NSString *okmsg) {
                                                                       [MsgUtils showMsg:@"恢复下载"];
                                                                   }
                                                                   failure:nil];
                                                }
                                            }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"删除"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                [APIUtils removeByGid:taskInfo.gid
                                                               rpcUri:_rpcUri
                                                              success:^(NSString *okmsg) {
                                                                  [MsgUtils showMsg:@"已删除下载任务"];
                                                              }
                                                              failure:nil];
                                            }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_list count] + 1;
}

@end
