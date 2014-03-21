//
//  NSData+Encryption.h
//  CoreDataEncryption
//
//  Created by SRAVAN on 3/20/14.
//  Copyright (c) 2014 SRAVAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)

+(NSData*)encrypt:(NSData*)plainData withIv:(NSData*)iv andKey:(NSData*)key;

+(NSData*)decrypt:(NSData*)plainData withIv:(NSData*)iv  andKey:(NSData*)key;


@end
