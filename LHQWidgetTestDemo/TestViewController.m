//
//  TestViewController.m
//  LHQWidgetTestDemo
//
//  Created by Xhorse_iOS3 on 2021/1/8.
//

#import "TestViewController.h"
#import "LHQWidgetTestDemo-Swift.h"

@interface TestViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改数据";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textField = [UITextField new];
    _textField.placeholder = @"修改小组件标题";
    _textField.frame = CGRectMake(0, 0, 180, 40);
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.center = self.view.center;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textField];
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(0, 0, 80, 35);
    button.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"修改" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)touchAction {
//    [[NSUserDefaults standardUserDefaults] addSuiteNamed:@"group.LHQ.LHQWidgetDemo"];
//    [[NSUserDefaults standardUserDefaults] setValue:_textField.text forKey:@"titleKey"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.LHQ.LHQWidgetDemo"];
    [userDefault setValue:_textField.text forKey:@"titleKey"];
    [userDefault synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"修改标题成功");
    
    NSString *str =  [userDefault objectForKey:@"titleKey"];
    NSLog(@"修改标题%@", str);
    
    if (@available(iOS 14.0, *)) {
        [WidgetManager reloadAllWidgets];
    } else {
        // Fallback on earlier versions
    }
}

@end
