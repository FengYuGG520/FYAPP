//#import "FYSQL.h"
//#import "FYTools.h"
//#import <FMDB.h>
//#define FY_DB_NAME @"FYDB.db"
//// 队列是 串行队列
//// 任务是 同步执行
//@interface FYSQL ()
//@property (strong, nonatomic, readonly) FMDatabaseQueue *queue;
//@end
//@implementation FYSQL
//
//+ (id)fy_sql:(NSString *)sql {
//    return [[FYSQL sharedFY] fy_sqlExcute:sql];
//}
//
//// 构造方法已经确定数据库名字
//// 并且把数据库存放在沙盒目录
//- (instancetype)init {
//    if (self = [super init]) {
//        // 建立数据库操作队列, 如果数据库不存在, 会建立数据库
//        // 注意: 在使用 FMDB 的时候, _queue 一定要全局唯一, 否则会出现数据库锁定的问题!
//        _queue = [FMDatabaseQueue databaseQueueWithPath:[FYTools fy_path:FY_DB_NAME FY_Path:FY_Path_Caches]];
//    }
//    return self;
//}
//
//+ (instancetype)sharedFY {
//    static id instance;
//    [FYGCD fy_gcdQueue:nil block:^{
//        instance = [self new];
//    } task:FY_Task_Once];
//    return instance;
//}
//
//- (NSArray *)fy_sqlExcuteSQLStrQuery:(NSString *)str {
//    // 创建一个空数组, 用来保存所有的数据字典
//    NSMutableArray *arrM = [NSMutableArray new];
//    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
//        // 执行 SQL 语句, 返回结果集
//        FMResultSet *set = [db executeQuery:str];
//        // 遍历结果集
//        while (set.next) {
//            // 先获取到数据有多少个字段
//            NSInteger colCount = set.columnCount;
//            // 用来存储一条数据
//            NSMutableDictionary *dicM = [NSMutableDictionary new];
//            for (int i = 0; i < colCount; i ++) {
//                NSString *key = [set columnNameForIndex:i];
//                NSString *value = [set objectForColumnIndex:i];
//                [dicM setValue:value forKey:key];
//            }
//            [arrM addObject:dicM];
//        }
//    }];
//    return arrM;
//}
//
//- (id)fy_sqlExcuteSQLStr:(NSString *)str {
//    if ([str hasPrefix:@"SELECT"] || [str hasPrefix:@"select"]) return [self fy_sqlExcuteSQLStrQuery:str];
//    __block int isOK = 1;
//    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
//            isOK = [db executeUpdate:str];
//        }];
//    return @(isOK);
//}
//
//- (id)fy_sqlExcute:(NSString *)sql {
//    if (!_queue) {
//        fyp(@"创建 SQLite 失败");
//        return @0;
//    } else {
//        NSString *path = [NSURL fy_filePath:sql];
//        if (path) sql = path.fy_pathContent;
//        return [self fy_sqlExcuteSQLStr:sql];
//    }
//}
//
//+ (void)fy_sqlArrStr:(NSArray<NSString *> *)arrStr {
//    [[FYSQL sharedFY].queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
//        for (NSString *sql in arrStr) [db executeUpdate:sql];
//    }];
//}
//
//@end
