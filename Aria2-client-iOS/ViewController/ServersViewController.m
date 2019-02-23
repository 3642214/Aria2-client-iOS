//
//  ServersViewController.m
//  Aria2
//
//  Created by 郑珏 on 2019/2/22.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import "ServersViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "ButtonCell.h"
#import "APIUtils.h"
#import "ActiveListViewController.h"
#import "StopListViewController.h"
#import "LeftRightArrowCell.h"
#import "LocalCacheUtils.h"
#import "UIView+TYAlertView.h"

@interface ServersViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) ButtonCell *activiteBtn, *addBtn;
@property (strong, nonatomic) NSMutableArray *list;
@end

@implementation ServersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setTitle:@"Aria2"];
    _list = [NSMutableArray new];
    [_list addObjectsFromArray:[[LocalCacheUtils getInstance] getArrayByKey:JSONRPCKey]];

    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView =
            [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        [self.view addSubview:tableView];

        [tableView registerClass:[LeftRightArrowCell class] forCellReuseIdentifier:@"LeftRightArrowCellText"];
        tableView.backgroundColor = ymBackgroudColor;
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_list count] > 0 && indexPath.row != [_list count]) {
        NSString *rpcUri = _list[indexPath.row];
        [APIUtils getVersion:rpcUri
            success:^(Setting *setting) {
                ActiveListViewController *vc = [ActiveListViewController new];
                vc.rpcUri = rpcUri;
                [self gotoVC:vc];
            }
            failure:^(NSString *msg) {
                [MsgUtils showMsg:@"无法连接到服务器，请检查URI"];
            }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_list count] == 0 || indexPath.row == [_list count]) {
        if (!_addBtn) {
            _addBtn = [[ButtonCell alloc] initWithBtnStyle:StrapDangerStyle
                                                     title:@"添加服务端"
                                                clickEvent:^{
                                                    [self addJsonrpcServer];
                                                }];
        }
        return _addBtn;
    } else {
        LeftRightArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightArrowCellText"];
        if (cell == nil) {
            cell = [[LeftRightArrowCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:@"LeftRightArrowCellText"];
        }
        [cell setLabel:_list[indexPath.row] text:@""];
        return cell;
    }
}

- (void)addJsonrpcServer {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"新增jsonrpc地址" message:nil];

    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入服务地址";
        NSString *str = [[UIPasteboard generalPasteboard] string];
        textField.text = [CommonUtils stringIsNull:str] ? @"http://" : str;
    }];

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:nil]];
    __typeof(alertView) __weak weakAlertView = alertView;
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定"
                                                  style:TYAlertActionStyleDestructive
                                                handler:^(TYAlertAction *action) {
                                                    for (UITextField *textField in weakAlertView.textFieldArray) {
                                                        [_list addObject:textField.text];
                                                        [[LocalCacheUtils getInstance] setArray:_list
                                                                                         forKey:JSONRPCKey];
                                                        [_myTableView reloadData];
                                                    }
                                                }]];
    [alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];
}

//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_list count] + 1;
}
@end
