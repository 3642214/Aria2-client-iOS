

//
//  Result.h
//  Aria2
//
//  Created by zj14 on 2019/2/23.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface Version : NSObject
@property (strong, nonatomic) NSArray *enabledFeatures;
@property (strong, nonatomic) NSString *version;
@end

@interface GlobalStatus : NSObject
@property (assign, nonatomic) NSInteger downloadSpeed;   //: "0"
@property (assign, nonatomic) NSInteger numActive;       //: "0"
@property (assign, nonatomic) NSInteger numStopped;      //: "1"
@property (assign, nonatomic) NSInteger numStoppedTotal; //: "1"
@property (assign, nonatomic) NSInteger numWaiting;      //: "2"
@property (assign, nonatomic) NSInteger uploadSpeed;     //: "0"
@end

@interface Uris : NSObject
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *uri;
@end

@interface Files : NSObject
@property (assign, nonatomic) NSInteger completedLength; // = 16777216;
@property (assign, nonatomic) NSInteger index;           // = 1;
@property (assign, nonatomic) NSInteger length;          // = 24816138;
@property (strong, nonatomic) NSString *path; // = "/userdisk/data/\U4e0b\U8f7d/WeChat_2.3.23.17_1548069461.dmg";
@property (assign, nonatomic) BOOL selected;  // = true;
@property (strong, nonatomic) NSArray<Uris *> *uris;
@end

@interface TaskInfo : NSObject
@property (strong, nonatomic) NSString *bitfield;        // = ff8fe0;
@property (assign, nonatomic) NSInteger completedLength; // = 18251776;
@property (assign, nonatomic) NSInteger connections;     // = 2;
@property (strong, nonatomic) NSString *dir;             // = "/userdisk/data/\U4e0b\U8f7d";
@property (assign, nonatomic) NSInteger downloadSpeed;   // = 6133394;
@property (strong, nonatomic) NSArray<Files *> *files;
@property (strong, nonatomic) NSString *gid;          // = 62530a25de537ccf;
@property (assign, nonatomic) NSInteger numPieces;    // = 24;
@property (assign, nonatomic) NSInteger pieceLength;  // = 1048576;
@property (assign, nonatomic) NSString *status;       // = active;
@property (assign, nonatomic) NSInteger totalLength;  // = 24816138;
@property (assign, nonatomic) NSInteger uploadLength; // = 0;
@property (assign, nonatomic) NSInteger uploadSpeed;  // = 0;

@end

@interface Setting : NSObject

//@property (copy, nonatomic)BOOL allow-overwrite;//": "false",
//@property (copy, nonatomic)BOOL allow-piece-length-change;//"": "false",
//@property (copy, nonatomic)BOOL always-resume;//"": "true",
//@property (copy, nonatomic)BOOL async-dns;//"": "true",
//@property (copy, nonatomic)BOOL auto-file-renaming;//": "true;//"",
//@property (copy, nonatomic)NSInteger auto-save-interval": "60;//"",
//@property (copy, nonatomic)BOOL bt-detach-seed-only;//": "false;//"",
//@property (copy, nonatomic)BOOL bt-enable-hook-after-hash-check;//;//"": "true",
//@property (copy, nonatomic)BOOL bt-enable-lpd;//": "false",
//@property (copy, nonatomic)BOOL bt-force-encryption;//": "false",
//@property (copy, nonatomic)BOOL bt-hash-check-seed;//": "true",
//@property (copy, nonatomic)BOOL bt-load-saved-metadata;//": "false",
//"bt-max-open-files": "100",
//"bt-max-peers": "55",
//@property (copy, nonatomic)BOOL bt-metadata-only": "false",
//"bt-min-crypto-level": "plain",
//@property (copy, nonatomic)BOOL bt-remove-unselected-file": "false",
//"bt-request-peer-speed-limit": "51200",
//@property (copy, nonatomic)BOOL bt-require-crypto": "false",
//@property (copy, nonatomic)BOOL bt-save-metadata": "false",
//@property (copy, nonatomic)BOOL bt-seed-unverified": "false",
//"bt-stop-timeout": "0",
//"bt-tracker-connect-timeout": "60",
//"bt-tracker-interval": "0",
//"bt-tracker-timeout": "60",
//"ca-certificate": "/etc/ssl/certs/ca-certificates.crt",
//"check-certificate": "false",
//"check-integrity": "false",
//"conditional-get": "false",
//"conf-path": "/etc/mixbox/apps/aria2/config/aria2.conf",
//"connect-timeout": "60",
//"console-log-level": "notice",
//"content-disposition-default-utf8": "false",
//"continue": "true",
//"daemon": "true",
//"deferred-input": "false",
//"dht-file-path": "/root/.cache/aria2/dht.dat",
//"dht-file-path6": "/root/.cache/aria2/dht6.dat",
//"dht-listen-port": "6881-6999",
//"dht-message-timeout": "10",
//"dir": "/userdisk/data/下载",
//"disable-ipv6": "false",
//"disk-cache": "16777216",
//"download-result": "default",
//"dry-run": "false",
//"dscp": "0",
//"enable-color": "true",
//"enable-dht": "true",
//"enable-dht6": "false",
//"enable-http-keep-alive": "true",
//"enable-http-pipelining": "false",
//"enable-mmap": "false",
//"enable-peer-exchange": "true",
//"enable-rpc": "true",
//"event-poll": "epoll",
//"file-allocation": "prealloc",
//"follow-metalink": "true",
//"follow-torrent": "true",
//"force-save": "false",
//"ftp-pasv": "true",
//"ftp-reuse-connection": "true",
//"ftp-type": "binary",
//"hash-check-only": "false",
//"help": "#basic",
//"http-accept-gzip": "false",
//"http-auth-challenge": "false",
//"http-no-cache": "false",
//"human-readable": "true",
//"keep-unfinished-download-result": "true",
//"listen-port": "6881-6999",
//"log": "/etc/mixbox/var/log/aria2.log",
//"log-level": "debug",
//"lowest-speed-limit": "0",
//"max-concurrent-downloads": "5",
//"max-connection-per-server": "5",
//"max-download-limit": "0",
//"max-download-result": "1000",
//"max-file-not-found": "0",
//"max-mmap-limit": "9223372036854775807",
//"max-overall-download-limit": "0",
//"max-overall-upload-limit": "0",
//"max-resume-failure-tries": "0",
//"max-tries": "5",
//"max-upload-limit": "0",
//"metalink-enable-unique-protocol": "true",
//"metalink-preferred-protocol": "none",
//"min-split-size": "10485760",
//"min-tls-version": "TLSv1",
//"netrc-path": "/root/.netrc",
//"no-conf": "false",
//"no-file-allocation-limit": "5242880",
//"no-netrc": "false",
//"optimize-concurrent-downloads": "false",
//"parameterized-uri": "false",
//"pause-metadata": "false",
//"peer-agent": "aria2/1.34.0",
//"peer-id-prefix": "A2-1-34-0-",
//"piece-length": "1048576",
//"proxy-method": "get",
//"quiet": "false",
//"realtime-chunk-checksum": "true",
//"remote-time": "false",
//"remove-control-file": "false",
//"retry-wait": "0",
//"reuse-uri": "true",
//"rlimit-nofile": "1024",
//"rpc-allow-origin-all": "true",
//"rpc-listen-all": "true",
//"rpc-listen-port": "6800",
//"rpc-max-request-size": "2097152",
//"rpc-save-upload-metadata": "true",
//"rpc-secure": "false",
//"save-not-found": "true",
//"save-session": "/etc/aria2.session",
//"save-session-interval": "60",
//"seed-ratio": "1.0",
//"server-stat-timeout": "86400",
//"show-console-readout": "true",
//"show-files": "false",
//"socket-recv-buffer-size": "0",
//"split": "10",
//"stderr": "false",
//"stop": "0",
//"stream-piece-selector": "default",
//"summary-interval": "60",
//"timeout": "60",
//"truncate-console-readout": "true",
//"uri-selector": "feedback",
//"use-head": "false",
//"user-agent": "aria2/1.34.0"
@end

NS_ASSUME_NONNULL_END
