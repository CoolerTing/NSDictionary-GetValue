//
//  ViewController.m
//  DictionaryCategory
//
//  Created by 丁强 on 2019/8/21.
//  Copyright © 2019 丁强. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+GetValue.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dic = @{@"name": @{
                                  @"first":@"haha"}};
    NSString *name = [dic getValueWithProperty:@"name.first"];
    NSLog(@"%@", name);
}

@end
