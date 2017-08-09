//
//  NSData+Encrypt.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

/**利用AES加密数据*/
- (NSData *)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**利用AES解密数据*/
- (NSData *)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**利用3DES加密数据*/
- (NSData *)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**利用3DES解密数据*/
- (NSData *)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
