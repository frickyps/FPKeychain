//
//  ViewController.m
//  FPKeychain
//
//  Created by 方世沛 on 2018/4/18.
//  Copyright © 2018年 方世沛. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "FPKeychain/FPKeychain.h"

#define INFODICT           [[NSBundle mainBundle] infoDictionary]
#define CFBUNDLEIDEN       [INFODICT objectForKey:@"CFBundleIdentifier"]

#define USER_KECHAIN_INFOKEY @"user_info_keychain_key"
#define USER_NAME_KEY        @"user_name"
#define USER_PASSWORD_KEY    @"user_password"

@interface LoginViewController ()
{
    LoginView *loginView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self dealKeychain];
}

- (void)setupView {
    self->loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self->loginView];
    
    [self->loginView.loginButton addTarget:self
                                    action:@selector(loginAct)
                          forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealKeychain {
    NSString *onlyId = [self getOnlyId];
    NSLog(@"#######%@######",onlyId);
    NSDictionary *dict = [[FPKeychain fp_getKeychainValueWithKey:USER_KECHAIN_INFOKEY] copy];
    if (dict!=nil) {
        NSString *userName = [dict objectForKey:USER_NAME_KEY];
        NSString *password = [dict objectForKey:USER_PASSWORD_KEY];
        self->loginView.userField.text=userName==nil?@"":userName;
        self->loginView.passwdField.text=password==nil?@"":password;
    }
}

- (void)loginAct {
    if ([[self->loginView.userField.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]==0) {
        return;
    }
    if ([self->loginView.passwdField.text length]==0) {
        return;
    }
    NSString *userName = self->loginView.userField.text;
    NSString *password = self->loginView.passwdField.text;
    NSDictionary *dict = @{USER_NAME_KEY:userName,USER_PASSWORD_KEY:password};
    if ([FPKeychain fp_getKeychainValueWithKey:USER_KECHAIN_INFOKEY]!=nil) {
        BOOL success = [FPKeychain fp_updateKeychainWithKey:USER_KECHAIN_INFOKEY value:dict];
        if (success) {
            NSLog(@"更新成功%@",[FPKeychain fp_getKeychainValueWithKey:USER_KECHAIN_INFOKEY]);
        }else {
            NSLog(@"更新失败");
        }
    }else {
        BOOL success = [FPKeychain fp_saveKeychainWithKey:USER_KECHAIN_INFOKEY value:dict];
        if (success) {
            NSLog(@"保存成功%@",[FPKeychain fp_getKeychainValueWithKey:USER_KECHAIN_INFOKEY]);
        }else {
            NSLog(@"保存失败");
        }
    }
}

#pragma mark 通过keychain获取设备唯一标示
- (NSString *)getOnlyId {
    NSString *onlyId = [FPKeychain fp_getKeychainValueWithKey:CFBUNDLEIDEN];
    if (onlyId==nil||onlyId.length==0) {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        onlyId = CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuid));
        [FPKeychain fp_saveKeychainWithKey:CFBUNDLEIDEN value:onlyId];
    }
    return onlyId;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
