//
//  HVClientSettings.m
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

#import <UIKit/UIKit.h>
#import "HVCommon.h"
#import "HVClientSettings.h"

static NSString* const c_element_debug = @"debug";
static NSString* const c_element_appID = @"masterAppID";
static NSString* const c_element_appName = @"appName";
static NSString* const c_element_name = @"name";
static NSString* const c_element_friendlyName = @"friendlyName";
static NSString* const c_element_serviceUrl = @"serviceUrl";
static NSString* const c_element_shellUrl = @"shellUrl";
static NSString* const c_element_environment = @"environment";
static NSString* const c_element_appData = @"appData";
static NSString* const c_element_deviceName = @"deviceName";
static NSString* const c_element_country = @"country";
static NSString* const c_element_language = @"language";
static NSString* const c_element_signinTitle = @"signInTitle";
static NSString* const c_element_signinRetryMessage = @"signInRetryMessage";
static NSString* const c_element_httpTimeout = @"httpTimeout";
static NSString* const c_element_maxAttemptsPerRequest = @"maxAttemptsPerRequest";
static NSString* const c_element_useCachingInStore = @"useCachingInStore";
static NSString* const c_element_autoRequestDelay = @"autoRequestDelay";

@implementation HVEnvironmentSettings

@synthesize name = m_name;
-(NSString *)name
{
    if ([NSString isNilOrEmpty:m_name])
    {
        self.name = @"PPE";
    }
    
    return m_name;
}

@synthesize friendlyName = m_friendlyName;
-(NSString *)friendlyName
{
    if ([NSString isNilOrEmpty:m_friendlyName])
    {
        self.friendlyName = @"HealthVault Pre-Production";
    }
    
    return m_friendlyName;
}

@synthesize serviceUrl = m_serviceUrl;
-(NSURL *)serviceUrl
{
    if (!m_serviceUrl)
    {
        m_serviceUrl = [[NSURL alloc] initWithString:@"https://platform.healthvault-ppe.com/platform/wildcat.ashx"];
    }
    
    return m_serviceUrl;
}

@synthesize shellUrl = m_shellUrl;
-(NSURL *)shellUrl
{
    if (!m_shellUrl)
    {
        m_shellUrl = [[NSURL alloc] initWithString:@"https://account.healthvault-ppe.com"];
    }
    
    return m_shellUrl;
}

@synthesize appDataXml = m_appData;

-(void)dealloc
{
    [m_name release];
    [m_friendlyName release];
    [m_serviceUrl release];
    [m_shellUrl release];
    [m_appData release];
    
    [super dealloc];
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_name, c_element_name);
    HVSERIALIZE_STRING(m_friendlyName, c_element_friendlyName);
    HVSERIALIZE_URL(m_serviceUrl, c_element_serviceUrl);
    HVSERIALIZE_URL(m_shellUrl, c_element_shellUrl);
    HVSERIALIZE_RAW(m_appData);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_name, c_element_name);
    HVDESERIALIZE_STRING(m_friendlyName, c_element_friendlyName);
    HVDESERIALIZE_URL(m_serviceUrl, c_element_serviceUrl);
    HVDESERIALIZE_URL(m_shellUrl, c_element_shellUrl);
    HVDESERIALIZE_RAW(m_appData, c_element_appData);
}

@end

@implementation HVClientSettings

@synthesize debug = m_debug;
@synthesize masterAppID = m_appID;
@synthesize appName = m_appName;
@synthesize environments = m_environments;
@synthesize deviceName = m_deviceName;
@synthesize country = m_country;
@synthesize language = m_language;
@synthesize signInControllerTitle = m_signInTitle;
@synthesize signinRetryMessage = m_signInRetryMessage;
@synthesize httpTimeout = m_httpTimeout;
@synthesize maxAttemptsPerRequest = m_maxAttemptsPerRequest;
@synthesize useCachingInStore = m_useCachingInStore;
@synthesize autoRequestDelay = m_autoRequestDelay;
@synthesize appDataXml = m_appData;

-(NSArray *)environments
{
    if ([NSArray isNilOrEmpty:m_environments])
    {
        NSMutableArray* defaultEnvironments = [[NSMutableArray alloc] init];
        HVEnvironmentSettings* defaultEnvironment = [[HVEnvironmentSettings alloc] init];
        [defaultEnvironments addObject:defaultEnvironment];
        [defaultEnvironment release];
    }
    
    return m_environments;
}

-(NSString *)deviceName
{
    if ([NSString isNilOrEmpty:m_deviceName])
    {
        m_deviceName = [[UIDevice currentDevice] name];
    }
    
    return m_deviceName;
}

-(NSString *)country
{
   if ([NSString isNilOrEmpty:m_country])
   {
       m_country = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
   }
    
    return m_country;
}

-(NSString *) language
{
    if ([NSString isNilOrEmpty:m_language])
    {
        m_language = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
    }
    
    return m_language;
}

-(NSString *)signInControllerTitle
{
    if ([NSString isNilOrEmpty:m_signInTitle])
    {
        m_signInTitle = NSLocalizedString(@"HealthVault", @"Sign in to HealthVault");
    }
    
    return m_signInTitle;
}

-(NSString *) signinRetryMessage
{
    if ([NSString isNilOrEmpty:m_signInRetryMessage])
    {
        m_signInRetryMessage = NSLocalizedString(@"Could not sign into HealthVault. Try again?", @"Retry signin message");
    }
    
    return m_signInRetryMessage;
}

-(HVEnvironmentSettings *)firstEnvironment
{
    return [self.environments objectAtIndex:0];
}

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    m_debug = FALSE;
    m_httpTimeout = 60;             // Default timeout in seconds
    m_maxAttemptsPerRequest = 3;    // Retry thrice...
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_appID release];
    [m_appName release];
    [m_deviceName release];
    [m_country release];
    [m_language release];
    
    [m_signInTitle release];
    [m_signInRetryMessage release];
    
    [m_appData release];
    
    [super dealloc];
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_BOOL(m_debug, c_element_debug);
    HVSERIALIZE_STRING(m_appID, c_element_appID);
    HVSERIALIZE_STRING(m_appName, c_element_appName);
    HVSERIALIZE_ARRAY(m_environments, c_element_environment);
    HVSERIALIZE_STRING(m_deviceName, c_element_deviceName);
    HVSERIALIZE_STRING(m_country, c_element_language);
    HVSERIALIZE_STRING(m_language, c_element_language);
    HVSERIALIZE_STRING(m_signInTitle, c_element_signinTitle);
    HVSERIALIZE_STRING(m_signInRetryMessage, c_element_signinRetryMessage);
    HVSERIALIZE_DOUBLE(m_httpTimeout, c_element_httpTimeout);
    HVSERIALIZE_INT(m_maxAttemptsPerRequest, c_element_maxAttemptsPerRequest);
    HVSERIALIZE_BOOL(m_useCachingInStore, c_element_useCachingInStore);
    HVSERIALIZE_DOUBLE(m_autoRequestDelay, c_element_autoRequestDelay);
    
    HVSERIALIZE_RAW(m_appData);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_BOOL(m_debug, c_element_debug);
    HVDESERIALIZE_STRING(m_appID, c_element_appID);
    HVDESERIALIZE_STRING(m_appName, c_element_appName);
    
    NSMutableArray* environs = nil;
    HVDESERIALIZE_ARRAY(environs, c_element_environment, HVEnvironmentSettings);
    self.environments = environs;
    
    HVDESERIALIZE_STRING(m_deviceName, c_element_deviceName);
    HVDESERIALIZE_STRING(m_country, c_element_country);
    HVDESERIALIZE_STRING(m_language, c_element_language);
    HVDESERIALIZE_STRING(m_signInTitle, c_element_signinTitle);
    HVDESERIALIZE_STRING(m_signInRetryMessage, c_element_signinRetryMessage);
    HVDESERIALIZE_DOUBLE(m_httpTimeout, c_element_httpTimeout);
    HVDESERIALIZE_INT(m_maxAttemptsPerRequest, c_element_maxAttemptsPerRequest);
    HVDESERIALIZE_BOOL(m_useCachingInStore, c_element_useCachingInStore);
    HVDESERIALIZE_DOUBLE(m_autoRequestDelay, c_element_autoRequestDelay);
    
    HVDESERIALIZE_RAW(m_appData, c_element_appData);
}

-(HVEnvironmentSettings *)environmentWithName:(NSString *)name
{
    HVCHECK_NOTNULL(name);
    
    NSArray* environments = self.environments;
    for (NSUInteger i = 0, count = environments.count; i < count; ++i)
    {
        HVEnvironmentSettings* environment = [environments objectAtIndex:i];
        if ([environment.name isEqualToStringCaseInsensitive:name])
        {
            return environment;
        }
    }
    
LError:
    return nil;
}

-(HVEnvironmentSettings *)environmentAtIndex:(NSUInteger)index
{
    return [m_environments objectAtIndex:index];
}

+(HVClientSettings *)newSettingsFromResource
{
    HVClientSettings* settings = (HVClientSettings *) [NSObject newFromResource:@"ClientSettings" withRoot:@"clientSettings" asClass:[HVClientSettings class]];
    
    if (!settings)
    {
        settings = [[HVClientSettings alloc] init];
    }
    
    return settings;
}

@end
