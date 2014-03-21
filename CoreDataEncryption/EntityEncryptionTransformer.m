//
//  EntityEncryptionTransformer.m
//  CoreDataEncryption
//
//  Created by SRAVAN on 3/19/14.
//  Copyright (c) 2014 SRAVAN. All rights reserved.
//

#import "EntityEncryptionTransformer.h"
#import "NSData+Encryption.h"

#import <CommonCrypto/CommonCrypto.h>

NSString *encryptionKey=@"test";

@implementation EntityEncryptionTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

-(id)transformedValue:(id)value{
    
    NSMutableData *archivedData= [[NSKeyedArchiver archivedDataWithRootObject:value] mutableCopy];
    
    NSData *keyData=[encryptionKey dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *iv=[self randomDataOfLength:kCCBlockSizeAES128 error:Nil];
    
    NSMutableData *completeData=[NSMutableData data];
    
    NSData *encryptedData=  [NSData encrypt:archivedData withIv:iv andKey:keyData];
    
    [completeData appendData:encryptedData];
    
    [completeData appendData:iv];
    
    return completeData;
}

-(id)reverseTransformedValue:(id)value{
    
    NSData *archivedData=(NSData*)value;
    
    NSData *keyData=[encryptionKey dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *iv=[archivedData subdataWithRange:NSMakeRange(archivedData.length-kCCBlockSizeAES128, kCCBlockSizeAES128)];
                
    NSData *encrypedData=[archivedData subdataWithRange:NSMakeRange(0, archivedData.length-kCCBlockSizeAES128)];
    
    NSData *decrytedData=[NSData decrypt:encrypedData withIv:iv andKey:keyData];
    
    id urachivedObject= [NSKeyedUnarchiver unarchiveObjectWithData:decrytedData];
    
    return urachivedObject;
}

// Return a buffer of random bytes of the specified length
-(NSData *)randomDataOfLength:(size_t)length
                        error:(NSError **)err {
    
    NSMutableData *randomBytes= [NSMutableData dataWithLength:length];
    
    int success=SecRandomCopyBytes(kSecRandomDefault,length,randomBytes.mutableBytes);
    
    if(success!=0){
        
        if(err){
            NSMutableDictionary *userInfo=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Error generating random bytes", @"error",nil];
            *err = [NSError errorWithDomain:@"com.entityEncryption.random"
                                       code:0
                                   userInfo:userInfo];
        }
    }
    else {
        if (err)
            *err=nil;
    }
    
    return randomBytes;
    
}

@end
