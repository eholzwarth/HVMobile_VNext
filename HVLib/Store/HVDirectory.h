//
//  HVDirectory.h
//  HVLib
//
//  Copyright (c) 2012 Microsoft Corporation. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"

@interface NSFileManager (HVDirectorExtensions) 

-(NSURL *) pathForStandardDirectory:(NSSearchPathDirectory) name;
-(NSURL *) documentDirectoryPath;
-(NSURL *) cacheDirectoryPath;

@end

//
// HVDirect implements all methods in HVObjectStore
//
@interface HVDirectory : NSObject <HVObjectStore>
{
    NSURL *m_path;
    NSString *m_stringPath;
}

@property (readonly, nonatomic) NSURL* url;
@property (readonly, nonatomic) NSString* stringPath;

-(id) initWithPath:(NSURL *) path;
-(id) initWithRelativePath:(NSString *) path;

-(NSURL *) makeChildUrl:(NSString *) name;
-(NSString *) makeChildPath:(NSString *) name;

-(HVDirectory *) newChildNamed:(NSString *) name;

-(NSEnumerator *) getFileNames;

-(BOOL) fileExists:(NSString *) fileName;
-(NSString *) makeFilePathIfExists:(NSString *) fileName;
-(BOOL) deleteFile:(NSString *) fileName;

-(NSFileHandle *) openFileForRead:(NSString *) fileName;
-(NSFileHandle *) openFileForWrite:(NSString *) fileName;

-(id) newObjectWithKey:(NSString *) key name:(NSString *) name andClass:(Class) cls;

@end