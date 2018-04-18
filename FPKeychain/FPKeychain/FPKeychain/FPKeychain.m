//
//  FPKeychain.m
//  FPKeychain
//
//  Created by 方世沛 on 2018/4/18.
//  Copyright © 2018年 方世沛. All rights reserved.
//

#import "FPKeychain.h"
#import <Security/Security.h>

@implementation FPKeychain

+ (NSMutableDictionary *)getKeychainInfoWithService:(NSString *)service {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    [dictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [dictionary setObject:service forKey:(id)kSecAttrAccount];
    [dictionary setObject:service forKey:(id)kSecAttrService];
    return dictionary;
}

+ (BOOL)fp_saveKeychainWithKey:(NSString *)key value:(id)value {
    NSMutableDictionary *saveDictionary = [self getKeychainInfoWithService:key];
    NSData *valueData = [NSKeyedArchiver archivedDataWithRootObject:value];
    if (valueData!=nil&&valueData.bytes>0) {
        [saveDictionary setObject:valueData forKey:(id)kSecValueData];
    }
    OSStatus status = SecItemAdd((CFDictionaryRef)saveDictionary, NULL);
    return status==errSecSuccess;
}

+ (BOOL)fp_updateKeychainWithKey:(NSString *)key value:(id)value {
    NSMutableDictionary *saveDictionary = [self getKeychainInfoWithService:key];
    NSMutableDictionary *updateDictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    NSData *valueData = [NSKeyedArchiver archivedDataWithRootObject:value];
    if (valueData!=nil&&valueData.bytes>0) {
        [updateDictionary setObject:valueData forKey:(id)kSecValueData];
    }
    OSStatus status = SecItemUpdate((CFDictionaryRef)saveDictionary, (CFDictionaryRef)updateDictionary);
    return status==errSecSuccess;
}

+ (id)fp_getKeychainValueWithKey:(NSString *)key {
    NSMutableDictionary *saveDictionary = [self getKeychainInfoWithService:key];
    [saveDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [saveDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef returnData = nil;
    id returnValue=nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)saveDictionary, (CFTypeRef *)&returnData);
    if (status==errSecSuccess) {
        if ([(__bridge NSData *)returnData bytes]>0) {
            returnValue = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)returnData];
        }
    }
    return returnValue;
}

+ (BOOL)fp_deleteKeychainWithKey:(NSString *)key {
    NSMutableDictionary *saveDictionary = [self getKeychainInfoWithService:key];
    return SecItemDelete((CFDictionaryRef)saveDictionary);
}


@end
