//
//  FileInfoViewController.m
//  Aria2-client-iOS
//
//  Created by zj14 on 2019/2/24.
//  Copyright © 2019 郑珏. All rights reserved.
//
typedef NS_ENUM(NSInteger, FileInfoVCCell) {
    //基本信息
    NAMECELL = 0,
    SIZECELL,
    STATUSCELL,
    PROGRESSCELL,
    COMPLETESIZECELL,
    FILEURLPATHCELL,
    DOWNLOADPATHCELL,
    CELLCOUNT
};

#import "FileInfoViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "LeftRightArrowCell.h"
#import "APIUtils.h"

@interface FileInfoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@end

@implementation FileInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"文件概况";

    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView =
            [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView.backgroundColor = ymBackgroudColor;
        [tableView registerClass:[LeftRightArrowCell class] forCellReuseIdentifier:LeftRightNoArrowCellText];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //        tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self
        //        refreshingAction:@selector(fresh)];
        tableView;
    });
    if (!_taskInfo) {
        [self fresh];
    }
}

- (void)fresh {
    [APIUtils statusByGid:_gid
        rpcUri:_rpcUri
        success:^(TaskInfo *taskInfo) {
            _taskInfo = taskInfo;
            [_myTableView reloadData];
        }
        failure:^(NSString *msg) {
            [MsgUtils showMsg:[NSString stringWithFormat:@"获取文件状态失败:%@", msg]];
        }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftRightArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftRightNoArrowCellText];
    if (cell == nil) {
        cell = [[LeftRightArrowCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:LeftRightNoArrowCellText];
    }
    switch (indexPath.row) {
        case NAMECELL: {
            NSString *filePath = [_taskInfo.files[0].path lastPathComponent];
            NSString *uriPath = [_taskInfo.files[0].uris[0].uri lastPathComponent];
            [cell setLabel:@"任务名称" text:[CommonUtils stringIsNull:filePath] ? uriPath : filePath];
        } break;
        case SIZECELL: {
            [cell setLabel:@"任务大小"
                      text:[NSString stringWithFormat:@"%@(%ld个文件)", [CommonUtils changeKMGB:_taskInfo.totalLength],
                                                      [_taskInfo.files count]]];
        } break;
        case STATUSCELL: {
            [cell setLabel:@"任务状态" text:_taskInfo.status];
        } break;
        case PROGRESSCELL: {
            [cell setLabel:@"进度"
                      text:[NSString stringWithFormat:@"%.2f%%", _taskInfo.totalLength == 0
                                                                     ? 0
                                                                     : (float) _taskInfo.completedLength * 100 /
                                                                           _taskInfo.totalLength]];
        } break;
        case COMPLETESIZECELL: {
            [cell setLabel:@"下载" text:[CommonUtils changeKMGB:_taskInfo.completedLength]];
        } break;
        case FILEURLPATHCELL: {
            [cell setLabel:@"下载地址" text:_taskInfo.files[0].uris[0].uri];
        } break;
        case DOWNLOADPATHCELL: {
            [cell setLabel:@"下载路径" text:_taskInfo.dir];
        } break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case FILEURLPATHCELL: {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择操作"
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];

            [alert addAction:[UIAlertAction actionWithTitle:@"复制下载地址"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *_Nonnull action) {
                                                        [UIPasteboard generalPasteboard].string =
                                                            _taskInfo.files[0].uris[0].uri;
                                                        [MsgUtils showMsg:@"已复制到剪切板"];
                                                    }]];

            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

            [self presentViewController:alert animated:YES completion:nil];
        } break;
        default:
            break;
    }
}

//每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CELLCOUNT;
}
@end
