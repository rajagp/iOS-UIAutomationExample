/*
 *  LSAccountDataManager.m
 *  LSUIAExample
 *
 *  Created by Priya Rajagopal on 9/23/13.
 *  Copyright (c) 2013 Lunaria Software, LLC. All rights reserved.
 *  Redistribution and use in source and binary forms, with or without modification,
 *  are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 * Model for holding credentials of valid account. For purposes of demo, its all hard coded here
 * and is in-memory.In the real world, this would be replaced by something that would validated
 * against accounts in an authentication server and stored securely
 */
#import "LSAccountDataManager.h"


#pragma mark - LSAccount
#define kKeyUser    @"KeyUser"
#define kKeyPass  @"KeyPass"

@interface  LSAccount:NSObject
@property (nonatomic,copy)NSString* user ;
@property (nonatomic,copy)NSString* password ;
@end


@implementation  LSAccount
-(id)initWithUser:(NSString*)user andPassword:(NSString*)pass
{
    self = [super init];
    if (self)
    {
        self.user = user;
        self.password = pass;
    }
    return self;
    
}
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.user forKey:kKeyUser];
    [encoder encodeObject:self.password forKey:kKeyPass];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    NSString* user = [decoder decodeObjectForKey:kKeyUser];
    NSString* pass = [decoder decodeObjectForKey:kKeyPass];
    
    return [self initWithUser:user andPassword:pass];
}



-(NSString*)description
{
    NSMutableString* str = [[NSMutableString alloc]initWithCapacity:0];
    [str appendFormat:@"User  is %@\n",self.user ];
    return str;
}
@end

#pragma mark - LSAccountDataManager
@interface  LSAccountDataManager ()
@property (nonatomic,strong,readwrite)NSMutableArray* validUsers;
@end

@implementation LSAccountDataManager

static LSAccountDataManager* sharedInstance;
+(id) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
        [sharedInstance initialize];
    });
    return sharedInstance;
}

-(void)initialize
{
    self.validUsers = [[NSMutableArray alloc]initWithCapacity:0];
    
    LSAccount* account1 = [[LSAccount alloc]initWithUser:@"admin" andPassword:@"admin"];
    [self.validUsers addObject:account1];
    
    LSAccount* account2 = [[LSAccount alloc]initWithUser:@"priya" andPassword:@"password"];
    [self.validUsers addObject:account2];
    
}

-(BOOL)isValidUser:(NSString*)user withPassword:(NSString*)pass
{
    __block BOOL isValid = NO;
    
    [self.validUsers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LSAccount* account = (LSAccount*)obj;
        if ([account.user isEqualToString:user] && [account.password isEqualToString:pass])
        {
            isValid = YES;
            *stop = YES;
        }
    }];
    
    return isValid;
}

@end
