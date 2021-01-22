//
//  MainViewController.m
//  LHQWidgetDemo
//
//  Created by Xhorse_iOS3 on 2021/1/5.
//

#import "MainViewController.h"
#import "LHQWidgetTestDemo-Swift.h"
#import "TestViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Widget";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    test *t = [[test alloc] init];
//    [t sayHelloWithName:@"CF"];

//    SwiftFileModel *m = [SwiftFileModel new];
//    NSString *str = [m testMethod];
    
    
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(0, 0, 80, 35);
    button.center = self.view.center;
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.LHQ.LHQWidgetDemo"];
    [userDefault setValue:@"进来立即赋值" forKey:@"titleKey"];
    [userDefault synchronize];
    
    if (@available(iOS 14.0, *)) {
        [WidgetManager reloadAllWidgets];
    } else {
        // Fallback on earlier versions
    }
//    [WidgetManager re]
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchAction) name:@"WidgetNotification" object:nil];
}

- (void)touchAction {
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
}


@end
