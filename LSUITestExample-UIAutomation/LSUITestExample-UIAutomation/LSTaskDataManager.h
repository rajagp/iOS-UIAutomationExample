/*
 *  LSTaskDataManager.h
 *  LSUIAExample
 *
 *  Created by Priya Rajagopal on 9/23/13.
 *  Copyright (c) 2015 Lunaria Software, LLC. All rights reserved.
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface LSTask : NSObject
@property (nonatomic,readonly,assign)NSInteger requestId;
@property (nonatomic,copy)NSString* detail;
@property (nonatomic,copy)NSDate* dueDate;

-(id)initWithDetail:(NSString*)detail andDueDate:(NSDate*)due;
@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN
@interface LSTaskDataManager : NSObject
@property (nonatomic,strong,readonly)NSMutableArray* taskList;
@property (nonatomic,readonly)NSInteger numTasks;

+(instancetype)sharedInstance;
-(void)addTask:(LSTask*)task;
-(void)removeTaskWithId:(NSInteger)requestId;
@end
NS_ASSUME_NONNULL_END
