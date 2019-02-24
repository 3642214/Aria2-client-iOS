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
#import "JsonrpcServerCell.h"
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
    [_list addObjectsFromArray:[[LocalCacheUtils getInstance] getJsonrpcArray]];

    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView =
            [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        [self.view addSubview:tableView];

        [tableView registerClass:[JsonrpcServerCell class] forCellReuseIdentifier:@"JsonrpcServerCellText"];
        tableView.backgroundColor = ymBackgroudColor;
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_list count] > 0 && indexPath.row != [_list count]) {
        JsonrpcServer *jrs = _list[indexPath.row];
        [APIUtils getVersion:jrs.uri
            success:^(Version *version) {
                ActiveListViewController *vc = [ActiveListViewController new];
                vc.rpcUri = jrs.uri;
                [self gotoVC:vc];
            }
            failure:^(NSString *msg) {
                [MsgUtils showMsg:@"无法连接到服务器，请检查URI"];
            }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isServerCell:indexPath.row]) {
        JsonrpcServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JsonrpcServerCellText"];
        if (cell == nil) {
            cell = [[JsonrpcServerCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:@"JsonrpcServerCellText"];
        }
        JsonrpcServer *js = _list[indexPath.row];
        [cell setJsonrpcServer:js];
        [APIUtils getGlobalStatus:js.uri
                          success:^(GlobalStatus *globalStatus) {
                              [cell setStat:globalStatus];
                          }
                          failure:nil];
        return cell;
    } else {
        if (!_addBtn) {
            _addBtn = [[ButtonCell alloc] initWithBtnStyle:StrapDangerStyle
                                                     title:@"添加服务端"
                                                clickEvent:^{
                                                    [self addJsonrpcServer];
                                                }];
        }
        return _addBtn;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction
        rowActionWithStyle:UITableViewRowActionStyleDefault
                     title:@"删除"
                   handler:^(UITableViewRowAction *_Nonnull action, NSIndexPath *_Nonnull indexPath) {
                       [_list removeObjectAtIndex:indexPath.row];
                       [[LocalCacheUtils getInstance] setJsonrpcArray:_list];
                       [_myTableView reloadData];
                   }];
    deleteRowAction.backgroundColor = [UIColor greenColor];

    return [self isServerCell:indexPath.row] ? @[ deleteRowAction ] : @[];
}

- (void)addJsonrpcServer {
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"新增jsonrpc地址" message:nil];

    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入名称";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];

    [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入服务地址";
        NSString *str = [[UIPasteboard generalPasteboard] string];
        textField.text = [CommonUtils stringIsNull:str] ? @"http://" : str;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:nil]];
    __typeof(alertView) __weak weakAlertView = alertView;
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定"
                                                  style:TYAlertActionStyleDestructive
                                                handler:^(TYAlertAction *action) {
                                                    JsonrpcServer *jrs = [JsonrpcServer new];
                                                    jrs.name = [(UITextField *) weakAlertView.textFieldArray[0] text];
                                                    jrs.uri = [(UITextField *) weakAlertView.textFieldArray[1] text];
                                                    if ([CommonUtils isUrlAddress:jrs.uri]) {
                                                        [_list addObject:jrs];
                                                        [[LocalCacheUtils getInstance] setJsonrpcArray:_list];
                                                        [_myTableView reloadData];
                                                    } else {
                                                        [MsgUtils showMsg:@"uri错误，重新添加"];
                                                    }
                                                }]];
    [alertView showInController:self preferredStyle:TYAlertControllerStyleAlert];
}

//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_list count] + 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)isServerCell:(NSInteger)row {
    return ([_list count] > 0 && row != [_list count]);
}
@end
