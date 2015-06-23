/*
 *  LSTaskDataManager.m
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
 
 * Model for holding tasks. For purposes of demo, its all in-memory.
 * In the real world, this would be replaced a persistent store (local or remote)
 */

#import "LSTaskDataManager.h"
#import <mach/mach.h>
#import <mach/mach_time.h>

#pragma mark - LSTask Implementation
#define kKeyDetail    @"KeyDetail"
#define kKeyDue   @"KeyDue"

@interface  LSTask ()
@property (nonatomic,readwrite)NSInteger requestId;
@end


@implementation  LSTask
-(id)initWithDetail:(NSString*)detail andDueDate:(NSDate*)due
{
    self = [super init];
    if (self)
    {
        self.requestId = mach_absolute_time();
        self.detail = detail;
        self.dueDate = due;
    }
    return self;
    
}
- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.detail forKey:kKeyDetail];
    [encoder encodeObject:self.dueDate forKey:kKeyDue];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    NSString* detail = [decoder decodeObjectForKey:kKeyDetail];
    NSDate* due = [decoder decodeObjectForKey:kKeyDue];
   
    return [self initWithDetail:detail andDueDate:due];
}



-(NSString*)description
{
    NSMutableString* str = [[NSMutableString alloc]initWithCapacity:0];
    [str appendFormat:@"Description  is %@\n",self.detail ];
    [str appendFormat:@"Due Date is %@\n",self.dueDate];
    
    return str;
}
@end

#pragma mark - LSTaskDataManager Implementation
@interface  LSTaskDataManager ()
@property (nonatomic,strong,readwrite)NSMutableArray* taskList;
@property (nonatomic,assign,readwrite)NSInteger numTasks;
@end

@implementation LSTaskDataManager
static LSTaskDataManager* sharedInstance;
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
    self.taskList = [[NSMutableArray alloc]initWithCapacity:0];
    self.numTasks = self.taskList.count;
}


#pragma mark - List Manipulation
-(void)addTask:(LSTask*)task
{
    [self.taskList addObject:task];
    self.numTasks = self.taskList.count;
   
}

-(void)removeTaskWithId:(NSInteger)requestId
{
     __block NSInteger selectedIndex = NSNotFound;
    [self.taskList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LSTask* task = (LSTask*)obj;
        if (task.requestId == requestId)
        {
            selectedIndex = idx;
            *stop = YES;
        }
    }];
    if (selectedIndex != NSNotFound)
    {
        [self.taskList removeObjectAtIndex:selectedIndex];
        self.numTasks = self.taskList.count;
    }
 
}

@end
