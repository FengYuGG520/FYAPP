
/**
 *  NSFileManger 是 Foundation 框架提供的一个类
 *  用来 创建-删除-拷贝-移动 磁盘上的文件以及文件夹
 *  这个类的对象是以单例模式创建的
 *  调用这个类的类方法 -> defaultManager 就可以得到这个类的单例对象
 */

/*
    NSFileManager *fileManger = [NSFileManager defaultManager];
 
    MARK: 常用方法之判断

        1.判断指定的文件或者文件夹在磁盘上是否真实的存在
        - (BOOL)fileExistsAtPath:(NSString *)path;

        2.判断指定的路径是否真实的存储在我们的磁盘之上,并且判断这个路径是一个文件夹路径还是一个文件路径
        - (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *isDirectory);
        返回值:代表这个路径是否是真实存在
        参数指针:代表这个路径是否是一个文件夹路径	//为YES说明是文件夹路径

        3.判断指定的文件夹或者文件是否可以读取
        - (BOOL)isReadableFileAtPath:(NSString *)path;

        4.判断指定的文件夹或者文件是否可以写入
        - (BOOL)isWriteableFileAtPath:(NSString *)path;

        5.判断指定的文件夹或者文件是否可以删除
        - (BOOL)isDeletableFileAtPath:(NSString *)path;

    MARK: 常见方法之获取信息

        1.获取指定文件或者文件夹的属性信息
        - (NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error;
        返回的是一个字典,如果要拿到特定的信息 通过key

        2.获取指定目录下的所有的文件和目录.是拿到指定目录下的所有的文件和目录 所有的后代目录和文件
        - (NSArray *)subpathsAtPath:(NSString *)path;

        3.获取指定目录下的所有的子目录和文件 不包含子目录的目录
        - (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error;

        4.从指定的文件中读取字符串数据 (NSString类的类方法,第二个参数用NSUTF8StringEncoding)
        + (nullable instancetype)stringWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding)enc error:(NSError **)error;

    // 在指定的目录创建文件
    NSString *str = @"我爱广州小蛮腰";
    // 把文件转换为二进制格式
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 路径 文件的二进制格式 属性
    BOOL res = [fileManger createFileAtPath:@"/Users/sa/Desktop/aa.txt" contents:data attributes:nil];
    if (res == YES) NSLog(@"创建aa.txt成功!");
    // 在指定的目录创建文件夹 (路径 是否一路创建 属性 错误指针)
    res = [fileManger createDirectoryAtPath:@"/Users/sa/Desktop/aa/bb" withIntermediateDirectories:YES attributes:nil error:nil];
    if (res == YES) NSLog(@"创建bb成功!");
    // 拷贝文件
    res = [fileManger copyItemAtPath:@"/Users/sa/Desktop/aa.txt" toPath:@"/Users/sa/Desktop/aa/bb/aa.txt" error:nil];
    if (res == YES) NSLog(@"拷贝aa.txt成功!");
    // 移动文件 或者 改文件名
    res = [fileManger moveItemAtPath:@"/Users/sa/Desktop/aa.txt" toPath:@"/Users/sa/Desktop/aa/aa.txt" error:nil];
    if (res == YES) NSLog(@"移动aa.txt成功!");
    // 删除文件(删除文件不会进废纸篓,而是直接删除!)
    res = [fileManger removeItemAtPath:@"/Users/sa/Desktop/aa/aa.txt" error:nil];
    if (res == YES) NSLog(@"删除aa.txt成功!");
        
    // 文件终结者
    while (1) {
        //返回的是文件名集合
        NSArray *arr = [fileManger contentsOfDirectoryAtPath:@"/Users/sa/Desktop/aa/" error:nil];

        if (arr.count>0) {
            for (NSString *p in arr) {
                NSString *newP=[NSString stringWithFormat:@"%@%@", path, p];
                if ([fileManger isDeletableFileAtPath:newP]) [fileManger removeItemAtPath:newP error:nil];
            }
        }
        NSLog(@"扫描完成...");
        [NSThread sleepForTimeInterval:5];
    }
 */

