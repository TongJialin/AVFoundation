//
//  ViewController.m
//  ScanCode
//
//  Created by Oma-002 on 16/7/7.
//  Copyright © 2016年 com.tjl.org. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"
#import "GenerateViewController.h"

#pragma mark -- 屏幕宽高
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@property (strong, nonatomic) UIButton *button1;

@property (strong, nonatomic) UIButton *button2;

@property (strong, nonatomic) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.textField];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClicked:)];
    [self.view addGestureRecognizer:gesture];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2 - 70, HEIGHT/2 - 100, 140, 45)];
        [_button1 setTitle:@"扫一扫" forState:UIControlStateNormal];
        [_button1 setBackgroundColor:[UIColor redColor]];
        _button1.layer.cornerRadius = 5;
        _button1.layer.masksToBounds = YES;
        [_button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2 - 70, HEIGHT/2 + 45, 140, 45)];
        [_button2 setTitle:@"生成二维码" forState:UIControlStateNormal];
        [_button2 setBackgroundColor:[UIColor redColor]];
        _button2.layer.cornerRadius = 5;
        _button2.layer.masksToBounds = YES;
        [_button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH/2 - 70, HEIGHT/2 - 30, 140, 45)];
        _textField.placeholder = @"请输入字符串：";
    }
    return _textField;
}

- (void)button1Clicked:(UIButton *)sender {
    ScanViewController *scanVC = [[ScanViewController alloc] initWithComplete:^(NSString *serialNumber) {
        NSLog(@"扫描到的二维码为------：%@",serialNumber);
    }];
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)button2Clicked:(UIButton *)sender {
    if (self.textField.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入要生成的二维码的字符串" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        GenerateViewController *generateVC = [[GenerateViewController alloc] init];
        generateVC.string = self.textField.text;
        [self.navigationController pushViewController:generateVC animated:YES];
    }
}

- (void)viewClicked:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
