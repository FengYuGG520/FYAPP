#pragma mark - 字符串
/**
 比较大小
     res = [@"jack" compare:@"rose"];
 比较(忽视大小写)
     res = [@"jack" compare:@"rose" options:NSCaseInsensitiveSearch];
 比较数字
     res = [@"12jack" compare:@"10rose" options:NSNumericSearch];
 判断字符串是否是以指定的字符串开始或者结束
     res = [@"jack" hasPrefix:@"j"];
     res = [@"jack" hasSuffix:@"k"];
 搜索在字符串中子字符串的位置
     NSRange range = [@"我 love you and itcast , and you?" rangeOfString:@"love"];
 搜索在字符串中字符串最后一次出现的位置
     range = [@"我 love you and itcast , and you?" rangeOfString:@"and" options:NSBackwardsSearch];
 截取(从某个下标开始一直截取到最后)
     NSString *str = [@"我 love you and itcast , and you?" substringFromIndex:3];
 截取(从头开始,一直截取到某个下标)
     str = [@"我 love you and itcast , and you?" substringToIndex:6];
 截取(一个范围的字符串)
     str = [@"我 love you and itcast , and you?" substringWithRange:NSMakeRange(4, 8)];
 截取(某个下标的字符)
     unichar uch = [@"我 love you and itcast , and you?" characterAtIndex:3];
 转换OC字符串数据为其他类型
     str = @"10.2WOW";
     NSLog(@"%.2lf--%zd--%d--%s",str.doubleValue,str.longLongValue,str.intValue,str.UTF8String);
 转换其他类型为OC
     str = @(10.38).description;
 转换C为OC
     str = [NSString stringWithUTF8String:"jack"];
 转换将字符串为大小写字母
     str = [@"i Love You" uppercaseString];
     str = [@"i Love You" lowercaseString];
 删除(字符串的头和尾的空格)
     str = [@" i Love You " stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 删除(字符串前后大小写的字母)
     str = [@" i Love You " stringByTrimmingCharactersInSet:[NSCharacterSet uppercaseLetterCharacterSet]];
     str = [@" i Love You " stringByTrimmingCharactersInSet:[NSCharacterSet lowercaseLetterCharacterSet]];
 删除(头尾指定的字符串)
     str = [@"i love you, i" stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"i"]];
 替换\删除(字符串所有空格)
     str = [@" i love you " stringByReplacingOccurrencesOfString:@" " withString:@""];
 
 1.截取字符串
 
 NSString*string =@"sdfsfsfsAdfsdf";
 string = [string substringToIndex:7];//截取掉下标7之后的字符串
 NSLog(@"截取的值为：%@",string);
 [string substringFromIndex:2];//截取掉下标2之前的字符串
 NSLog(@"截取的值为：%@",string);
 
 
 2.匹配字符串
 NSString*string =@"sdfsfsfsAdfsdf";
 NSRangerange = [stringrangeOfString:@"f"];//匹配得到的下标
 NSLog(@"rang:%@",NSStringFromRange(range));
 string = [string substringWithRange:range];//截取范围类的字符串
 NSLog(@"截取的值为：%@",string);
 
 
 3.分隔字符串
 NSString*string =@"sdfsfsfsAdfsdf";
 
 NSArray *array = [string componentsSeparatedByString:@"A"]; //从字符A中分隔成2个元素的数组
 NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
 
 Copy
 // 系统级别
 UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
 pasteboard.string = self.pTextField.text;
 NSLog(@"\r\n====>输入框内容为:%@\r\n====>剪切板内容为:%@",self.pTextField.text,pasteboard.string);
 // 应用内单独使用时
 NSString * strBuildID = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
 UIPasteboard * myPasteboard = [UIPasteboard pasteboardWithName:strBuildID create:YES];
 myPasteboard.string = @"复制测试数据";
 // 内部使用
 NSString * strBuildID = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
 UIPasteboard * myPasteboard = [UIPasteboard pasteboardWithName:strBuildID create:NO];
 self.pLabel.text = myPasteboard.string;
 
 */

#pragma mark - 可变字符串
/**
 拼接
     [strM appendString:@"我爱你"];
 插入
     [strM insertString:@"枫宇" atIndex:2];
 替换
     [strM replaceCharactersInRange:NSMakeRange(2, 2) withString:@"大神"];
 删除
     [strM deleteCharactersInRange:NSMakeRange(2, 2)];
 */

#pragma mark - 数组和字符串
/**
 拆分字符串成数组
     NSArray *arr = [@"广东,深圳,宝安区,洪浪北二路,凌云大厦9楼" componentsSeparatedByString:@","];
 连接将数组成字符串
     NSString *str = [arr componentsJoinedByString:@"-"];
 判断数组中是否包含指定元素
     BOOL res = [arr containsObject:@"广东"];
 可变数组的增删查改(不可变数组,无法增删改)
     arr = @[@"jack",@"rose",@"lili",@"lilei",@"中文"];
     NSMutableArray *arrM = [NSMutableArray arrayWithObjects:@"jack",@"rose",@"Tom", nil];
 查
     res = [arrM containsObject:@"rose"];
     NSUInteger index = [arrM indexOfObject:@"jack"];   //如果没有找到返回NSNotFound也就是NSIntegerMax
     id objt = [arrM objectAtIndex:2];
 增
     [arrM insertObject:@"lilei" atIndex:1];
 删
     [arrM removeObject:@"Tom"];
     [arrM removeObjectAtIndex:1];
 改
     [arrM replaceObjectAtIndex:1 withObject:@"lili"];
 */

#pragma mark - 可变字典的增删查改
/**
 NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"value1",@"key1",
                         @"value2",@"key2",
                         @"value3",@"key3",
                                         nil];
         dic = @{
             @"key1":@"value1",
             @"key2":@"value2",
             @"key3":@"value3"
         };
 NSMutableDictionary *dicM = [NSMutableDictionary new];
 查
     id obj = [dicM objectForKey:@"key2"];
     obj = dicM[@"key2"];
 增
     [dicM setObject:@"value3" forKey:@"key4"];
 改
     [dicM setObject:@"tsb" forKey:@"key1"];
 删
     [dicM removeObjectForKey:@"key2"];
     [dicM setValue:nil forKey:@"key3"];
 */
