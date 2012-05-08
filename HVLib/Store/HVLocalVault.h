//
//  HVLocalVault.h
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
#import "HVDirectory.h"
#import "HVObjectStore.h"
#import "HVLocalRecordStore.h"
#import "HVLocalVocabStore.h"

@interface HVLocalVault : NSObject
{
    HVDirectory* m_root;
    NSMutableDictionary* m_recordStores;
    HVLocalVocabStore* m_vocabs;
}

-(id) initWithRoot:(HVDirectory *) root;

@property (readonly, nonatomic) id<HVObjectStore> root;
@property (readonly, nonatomic) HVLocalVocabStore* vocabs;

-(HVLocalRecordStore *) getRecordStore:(HVRecordReference *) record;


@end
