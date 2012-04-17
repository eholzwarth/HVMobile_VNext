//
//  HVDataView.h
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
#import "XLib.h"
#import "HVAsyncTask.h"
#import "HVTypeViewItems.h"
#import "HVLocalVault.h"
#import "HVItemFilter.h"
#import "HVIndexList.h"

@class HVSynchronizedStore;
@class HVTypeView;

@protocol HVTypeViewDelegate <NSObject>

-(void) itemsAvailable:(HVItemCollection *) items inView:(HVTypeView *) view;
-(void) keysNotAvailable:(NSArray *) keys inView:(HVTypeView *) view;

-(void) synchronizationCompletedInView:(HVTypeView *) view keysRemoved:(NSArray *) keys;
-(void) synchronizationFailedInView:(HVTypeView *) view withError:(id) ex;

@optional
-(void) itemsAvailableAtIndexes:(HVIndexList *) indexes inView:(HVTypeView *) view;
-(void) itemsNotAvailableAtIndexes:(HVIndexList *) indexes inView:(HVTypeView *) view;

@end

@interface HVTypeView : XSerializableType
{
    NSString* m_typeID;
    HVTypeFilter* m_filter;
    NSDate* m_lastUpdateDate;
    NSInteger m_maxItems;
  
    HVTypeViewItems* m_items;
    HVLocalRecordStore* m_store;
    
    BOOL m_isDelegateInMainThread;
    id<HVTypeViewDelegate> m_delegate;
}

@property (readonly, nonatomic, retain) HVRecordReference* record;
@property (readonly, nonatomic) NSString* typeID;
@property (readonly, nonatomic) HVTypeFilter* filter;
@property (readwrite, nonatomic, retain) NSDate* lastUpdateDate;
@property (readwrite, nonatomic) NSInteger maxItems;

@property (readonly, nonatomic) NSUInteger count;
@property (readwrite, nonatomic, retain) HVLocalRecordStore* store;
@property (readwrite, nonatomic, retain) id<HVTypeViewDelegate> delegate;

-(id) initForTypeID:(NSString *) typeID overStore:(HVLocalRecordStore *) store;
-(id) initForTypeID:(NSString *)typeID filter:(HVTypeFilter *) filter overStore:(HVLocalRecordStore *) store;

-(HVTypeViewItem *) itemKeyAtIndex:(NSUInteger) index;
-(NSUInteger) indexOfItemID:(NSString *) itemID;

-(BOOL) isStale:(NSTimeInterval) maxAge;

//
// Synchronize view but not data
//
-(HVTask *) synchronize;
//
// Synchronize HVItems associated with this view
//
-(HVTask *) synchronizeData;
-(HVTask *) synchronizeDataInRange:(NSRange) range;
//
// Synchronized get/put Methods
// These methods locally cached items immediately. If no local item available, returns nil
// Pending items are returned through delegate callbacks as they become available
//
-(HVItem *) getItemAtIndex:(NSUInteger) index;
-(HVItem *) getItemAtIndex:(NSUInteger) index readAheadCount:(NSUInteger) readAheadCount; 
-(HVItemCollection *) getItemsInRange:(NSRange) range; 

-(HVItemCollection *) getItemsInRange:(NSRange) range downloadTask:(HVTask **) task;

-(NSUInteger) putItem:(HVItem *) item;
-(BOOL) putItems:(HVItemCollection *) items;

-(HVItem *) getLocalItemAtIndex:(NSUInteger) index;
-(void) removeLocalItemAtIndex:(NSUInteger) index;
-(void) removeAllLocalItems;

// TODO: rename these view specific methods
-(BOOL) updateItemInView:(HVItem *) item;
-(BOOL) updateItemsInView:(HVItemCollection *) items;
-(BOOL) removeItemFromViewByID:(NSString *) itemID;
-(BOOL) removeItemsFromViewByID:(NSArray *) itemIDs;

-(BOOL) save;
-(BOOL) saveWithName:(NSString*) name;
+(HVTypeView *) loadViewNamed:(NSString *) name fromStore:(HVLocalRecordStore *) store;

+(HVTypeView *) getViewForTypeClassName:(NSString *) className;
+(HVTypeView *) getViewForTypeID:(NSString *)typeID;


//
// Delegate callbacks for HVSynchronizedStore
//
-(void) keysNotRetrieved:(NSArray *) keys withError:(id) error;
-(void) itemsRetrieved:(HVItemCollection *) items forKeys:(NSArray *) keys; // Not all keys may result in a match

@end
