//
//  HVItemTypes.m
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

#import "HVItemTypes.h"

#define HVDECLARE_GETTOR(type, name) \
-(type *) name { \
    if (self.hasTypedData) { \
            return (type *) self.data.typed; \
    } \
    return nil; \
}


@implementation HVItem (HVTypedExtensions)

HVDECLARE_GETTOR(HVWeight, weight);

HVDECLARE_GETTOR(HVBloodPressure, bloodPressure);

HVDECLARE_GETTOR(HVCholesterol, cholesterol);

HVDECLARE_GETTOR(HVBloodGlucose, bloodGlucose);

HVDECLARE_GETTOR(HVHeight, height);

HVDECLARE_GETTOR(HVExercise, exercise);

HVDECLARE_GETTOR(HVDailyMedicationUsage, medicationUsage);

HVDECLARE_GETTOR(HVEmotionalState, emotionalState);

HVDECLARE_GETTOR(HVAssessment, assessment);

HVDECLARE_GETTOR(HVQuestionAnswer, questionAnswer);

HVDECLARE_GETTOR(HVDietaryIntake, dietaryIntake);

HVDECLARE_GETTOR(HVSleepJournalAM, sleepJournalAM);

HVDECLARE_GETTOR(HVSleepJournalPM, sleepJournalPM);

HVDECLARE_GETTOR(HVAllergy, allergy);

HVDECLARE_GETTOR(HVCondition, condition);

HVDECLARE_GETTOR(HVImmunization, immunization);

HVDECLARE_GETTOR(HVMedication, medication);

HVDECLARE_GETTOR(HVProcedure, procedure);

HVDECLARE_GETTOR(HVVitalSigns, vitalSigns);

HVDECLARE_GETTOR(HVEncounter, encounter);

HVDECLARE_GETTOR(HVFamilyHistory, familyHistory);

HVDECLARE_GETTOR(HVEmergencyOrProviderContact, emergencyOrProviderContact);

HVDECLARE_GETTOR(HVPersonalContactInfo, personalContact);

HVDECLARE_GETTOR(HVBasicDemographics, basicDemographics);

HVDECLARE_GETTOR(HVPersonalDemographics, personalDemographics);

@end