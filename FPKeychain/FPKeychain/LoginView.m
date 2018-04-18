//
//  LoginView.m
//  FPKeychain
//
//  Created by 方世沛 on 2018/4/18.
//  Copyright © 2018年 方世沛. All rights reserved.
//

#import "LoginView.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LoginView ()<UITextFieldDelegate>

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        for (int i =0; i<2; i++) {
            UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(50, 200+i*(46+20), SCREEN_WIDTH-100, 46)];
            textFiled.layer.cornerRadius=23;
            textFiled.returnKeyType=UIReturnKeyDone;
            textFiled.delegate=self;
            textFiled.layer.masksToBounds=YES;
            textFiled.textColor=[UIColor blackColor];
            textFiled.backgroundColor=[UIColor grayColor];
            switch (i) {
                case 0:
                    _userField=textFiled;
                    break;
                default:
                    _passwdField=textFiled;
                    break;
            }
        }
        [self addSubview:_userField];
        [self addSubview:_passwdField];
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame=CGRectMake(50, _passwdField.frame.origin.y+46+20, SCREEN_WIDTH-100, 50);
        _loginButton.layer.cornerRadius=25;
        _loginButton.layer.masksToBounds=YES;
        _loginButton.backgroundColor=[UIColor purpleColor];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_loginButton];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}
@end
