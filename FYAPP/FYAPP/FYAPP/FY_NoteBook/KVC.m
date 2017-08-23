/**
 *   KVC:
 *       Key Value Coding
 *
 *   可以操作一个对象时像操作字典那样操作
 *
 *   可以把属性当做字符串的 key 来操作
 *
 *   使用注意:
 *       1. 字典的 key 必须跟属性名一样
 *       2. 模型类的属性不能比字典的 key 少, 可以比字典多
 */

/**
 *    NSDictionary *dic = @{
 *        @"name" : @"戈妮",
 *        @"age" : @16,
 *        @"nickName" : @"小妮子"
 *    };
 *
 *    Person *p = [Person new];
 *
 *    p.name = dic[@"name"];
 *    p.age = [dic[@"age"] intValue];
 *    p.nickName = dic[@"nickName"];
 *
 *    [p setValue:dic[@"name"] forKey:@"name"];
 *    [p setValue:dic[@"age"] forKey:@"age"];
 *    [p setValue:dic[@"nickName"] forKey:@"nickName"];
 *
 *    for (id key in dic) [p setValue:dic[key] forKey:key];
 *
 *    [p setValuesForKeysWithDictionary:dic];
 *
 *    NSLog(@"%@", dic);
 */
