//
//  HVEmotionalState.h
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
#import "HVTypes.h"

enum HVMood 
{
    HVMood_Unknown = 0,
    HVMood_Depressed,
    HVMood_Sad,
    HVMood_Neutral,
    HVMood_Happy,
    HVMood_Elated
};

enum HVWellBeing 
{
    HVWellBeing_Unknown = 0,
    HVWellBeing_Sick,
    HVWellBeing_Impaired,
    HVWellBeing_Able,
    HVWellBeing_Healthy,
    HVWellBeing_Vigorous
};

@interface HVEmotionalState : HVItemDataTyped
{
    HVDateTime* m_when;
    HVOneToFive* m_mood;
    HVOneToFive* m_stress;
    HVOneToFive* m_wellbeing;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic) enum HVMood mood;
@property (readwrite, nonatomic) enum HVRelativeRating stress;
@property (readwrite, nonatomic) enum HVWellBeing wellbeing;

+(NSString *) typeID;
+(NSString *) XRootElement;

+(HVItem *) newItem;

@end