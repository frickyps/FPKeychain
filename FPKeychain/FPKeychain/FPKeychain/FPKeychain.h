//
//  FPKeychain.h
//  FPKeychain
//
//  Created by 方世沛 on 2018/4/18.
//  Copyright © 2018年 方世沛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPKeychain : NSObject
/***
 @enum Class Value Constants
 @discussion Predefined item class constants used to get or set values in
 a dictionary. The kSecClass constant is the key and its value is one
 of the constants defined here. Note: on Mac OS X 10.6, only items
 of class kSecClassInternetPassword are supported.
 @constant kSecClassInternetPassword Specifies Internet password items. //网络密码
 @constant kSecClassGenericPassword Specifies generic password items.   //普通密码
 @constant kSecClassCertificate Specifies certificate items.            //证书
 @constant kSecClassKey Specifies key items.
 @constant kSecClassIdentity Specifies identity items.                  //标识
 
extern const CFStringRef kSecClassInternetPassword
__OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_2_0);
extern const CFStringRef kSecClassGenericPassword
__OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_2_0);
extern const CFStringRef kSecClassCertificate
__OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_2_0);
extern const CFStringRef kSecClassKey
__OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_2_0);
extern const CFStringRef kSecClassIdentity
__OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_2_0);
 
***/

/**通过key保存到keychain**/
+ (BOOL)fp_saveKeychainWithKey:(NSString *)key value:(id)value;

/**更新到keychain**/
+ (BOOL)fp_updateKeychainWithKey:(NSString *)key value:(id)value;

/**根据key获取值**/
+ ( id )fp_getKeychainValueWithKey:(NSString *)key; 

/**通过key删除keychain**/
+ (BOOL)fp_deleteKeychainWithKey:(NSString *)key;
@end
