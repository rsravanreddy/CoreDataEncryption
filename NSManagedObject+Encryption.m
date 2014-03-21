//
//  NSManagedObject+Encryption.m
//  CoreDataEncryption
//
//  Created by SRAVAN on 3/19/14.
//  Copyright (c) 2014 SRAVAN. All rights reserved.
//

#import "NSManagedObject+Encryption.h"
#import "EntityEncryptionTransformer.h"

@implementation NSManagedObject (Encryption)


+(void)initialize{
    
    EntityEncryptionTransformer *encTransformer=[[EntityEncryptionTransformer alloc] init
                                                 ];
    
    [NSValueTransformer setValueTransformer:encTransformer forName:@"encTransformer"];
    
    
}


@end
