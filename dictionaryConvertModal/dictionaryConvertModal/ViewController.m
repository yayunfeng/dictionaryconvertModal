//
//  ViewController.m
//  dictionaryConvertModal
//
//  Created by 冯亚运 on 17/2/27.
//  Copyright © 2017年 冯亚运. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Modal.h"
#import "Person.h"
#import "Woman.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *dic = @{@"name":@"张三",
                          @"age":@"13",
                          @"height":@"10",
                          @"man":@{@"head":@"header"
                                   ,@"body":@"body"},
                          @"woman":@[@{@"name":@"范爷",@"age":@"20"}
                                     ,@{@"name":@"冰爷",@"age":@"25"}]};
    //字典转模型KVC
    Person *p =  [Person itemWithDic:dic];
    
    NSLog(@"%@",p.man.head);
    
    Woman *woman = p.woman[0];
    NSLog(@"woman--%@",woman.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
