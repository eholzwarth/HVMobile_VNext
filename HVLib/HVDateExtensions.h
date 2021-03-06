//
//  HVDateExtensions.h
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

const NSUInteger NSAllCalendarUnits;

@interface NSDate (HVExtensions)

-(NSString*) toString;
-(NSString*) toStringWithFormat:(NSString*) format;
-(NSString *) toZuluString;
-(NSString*) toStringWithStyle:(NSDateFormatterStyle) style;

-(NSComparisonResult) compareDescending:(NSDate*) other;
-(BOOL) isEqualToDateAccuracySeconds:(NSDate *) other;

+(NSDate *) fromHour:(int) hour;
+(NSDate *) fromHour:(int)hour andMinute:(int) minute;

-(NSTimeInterval) offsetFromNow;
-(NSDate *) toStartOfDay;
-(NSDate *) toEndOfDay;

+(NSDate *) yesterday;

@end


@interface NSCalendar (HVExtensions)

-(NSDateComponents *) componentsForCalendar;
-(NSDateComponents *) getComponentsFor:(NSDate *) date;
-(NSDateComponents *) yearMonthDayFrom:(NSDate *) date;

+(NSDateComponents *) componentsFromDate:(NSDate *) date;
+(NSDateComponents *) newComponents;

+(NSDateComponents *) newUtcComponents;
+(NSDateComponents *) utcComponentsFromDate:(NSDate *)date;

+(NSCalendar *) newGregorian;
+(NSCalendar *) newGregorianUtc;

@end

@interface NSDateFormatter (HVExtensions) 

+(NSDateFormatter *) newUtcFormatter;
+(NSDateFormatter *) newZuluFormatter;

-(NSString *) dateToString:(NSDate*) date withFormat:(NSString*) format;
-(NSString *) dateToString:(NSDate*) date withStyle:(NSDateFormatterStyle) style;
-(NSString *) dateTimeToString:(NSDate*) date withStyle:(NSDateFormatterStyle) style;
-(NSString *) dateTimeToString:(NSDate *)date;

+(NSLocale *) newCultureNeutralLocale;

@end

@interface NSDateComponents (HVExtensions)

+(BOOL)isEqualYearMonthDay:(NSDateComponents *)d1 and:(NSDateComponents *)d2;
+(NSComparisonResult) compareYearMonthDay:(NSDateComponents *)d1 and:(NSDateComponents *)d2;

@end

