# NSDictionary-GetValue
 通过字符串形式从嵌套字典取值

例子：
```
NSDictionary *dic = @{@"name": @{
                                  @"first":@"haha"}};
NSString *name = [dic getValueWithProperty:@"name.first"];
```
