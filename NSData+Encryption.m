//
//  NSData+Encryption.m
//  CoreDataEncryption
//
//  Created by SRAVAN on 3/20/14.
//  Copyright (c) 2014 SRAVAN. All rights reserved.
//

#import "NSData+Encryption.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (Encryption)

+(NSData*)encrypt:(NSData*)plainData withIv:(NSData*)iv andKey:(NSData*)key{
    
    NSData *encryptedata=nil;
    
    char *keyBuffer=malloc(kCCKeySizeAES256);
    
    memset(keyBuffer, 0, kCCKeySizeAES256);
    
    memcpy(keyBuffer, [key bytes], key.length);
    
    size_t numBytesEncrypted=0;
    
    size_t outBufferLen=[plainData length]+kCCBlockSizeAES128;
    
    char *outBuffer=malloc(outBufferLen);
    
    CCCryptorStatus result = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                     keyBuffer, kCCKeySizeAES256,
                                     [iv bytes] /* initialization vector (optional) */,
                                     [plainData bytes], [plainData length], /* input */
                                     outBuffer, outBufferLen, /* output */
                                     &numBytesEncrypted );
    
    if ( result == kCCSuccess ){
        
        encryptedata=[NSData dataWithBytes:outBuffer length:numBytesEncrypted];
        
    }
    
    free(keyBuffer);
    
    free(outBuffer);
    
    return encryptedata;
}

+(NSData*)decrypt:(NSData *)cipherData withIv:(NSData*)iv andKey:(NSData *)key{
    
    NSData *decrypedtedata=nil;
    
    char *keyBuffer=malloc(kCCKeySizeAES256);
    
    memset(keyBuffer, 0, kCCKeySizeAES256);
    
    memcpy(keyBuffer, [key bytes], key.length);
    
    size_t numBytesDecrypted=0;
    
    size_t outBufferLen=[cipherData length]+kCCBlockSizeAES128;
    
    char *outBuffer=malloc(outBufferLen);
    
    CCCryptorStatus result = CCCrypt( kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                     keyBuffer, kCCKeySizeAES256,
                                     [iv bytes] /* initialization vector (optional) */,
                                     [cipherData bytes], [cipherData length], /* input */
                                     outBuffer, outBufferLen, /* output */
                                     &numBytesDecrypted );
    
    if ( result == kCCSuccess ){
        
        decrypedtedata=[NSData dataWithBytes:outBuffer length:numBytesDecrypted];
        
    }
    
    free(keyBuffer);
    
    free(outBuffer);
    
    return decrypedtedata;
    
    
}

@end
