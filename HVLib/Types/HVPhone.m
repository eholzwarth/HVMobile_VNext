//
//  HVPhone.m
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

#import "HVCommon.h"
#import "HVPhone.h"

static NSString* const c_element_description = @"description";
static NSString* const c_element_isPrimary = @"is-primary";
static NSString* const c_element_number = @"number";

@implementation HVPhone

@synthesize number = m_number;
@synthesize type = m_type;
@synthesize isPrimary = m_isprimary;

-(id)initWithNumber:(NSString *)number
{
    HVCHECK_STRING(number);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.number = number;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_number release];
    [m_type release];
    [m_isprimary release];
    
    [super dealloc];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return (m_number) ? m_number : c_emptyString;
}

+(HVVocabIdentifier *)vocabForType
{
    return [[[HVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"phone-types"] autorelease];        
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_STRING(m_number, HVClientError_InvalidPhone);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
    
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_type, c_element_description);
    HVSERIALIZE(m_isprimary, c_element_isPrimary);
    HVSERIALIZE_STRING(m_number, c_element_number);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_type, c_element_description);
    HVDESERIALIZE(m_isprimary, c_element_isPrimary, HVBool);
    HVDESERIALIZE_STRING(m_number, c_element_number);
}

@end

@implementation HVPhoneCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVPhone class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVPhone *)itemAtIndex:(NSUInteger)index
{
    return (HVPhone *) [self objectAtIndex:index];
}

@end
