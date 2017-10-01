/*
 * Copyright 2014 Pangramia Limited.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * This file contains the definitions of the Pangramia Enrollment data model.
 */
namespace java com.pangramia.enroll

/**
 * Milliseconds since the standard base "epoch" of January 1, 1970, 00:00:00 GMT
 * or the period of times in millis from last event
 */
typedef i64 Timestamp


/**
 * Lang
 */
struct Lang {
    /** Locale or derivative from the locale */
    1: string id

    /** Lang translated for the given requested language, or the native one*/
    2: string name

    /** Lang in which the name  is presented */
    3: optional string lang

    /** If name is listed in native */
    4: optional bool isListedInNative
}

/**
 * Education Region
 */
struct Region {
    /** Identifier, domain zone mostly like by, ru, ch or reverse university domain:  by.bsu */
    1: string id

    /** Region / County shortname , i.e. Russia, China or the certain China province  */
    2: string name

    /** Lang in which the region name  is presented */
    3: string lang

    /** Further detalization on the region expecially convient for China province or subregion */
    4: optional string detailsUrl
}


/**
 * Education Region
 */
struct Campaign {
    /** Identifier */
    1: string id

    /** Year of the campaign */
    2: i32 year

    /**
    * Region identifier to which this campaign belong to.
    * This allows to pass only campaign without specifying region for most methods
    */
    3: string region

    /** Translated Name, i.e. "Приемная кампания 2014"*/
    4: string name

    /** Lang in which the name  is presented */
    5: string lang

    /** Further detalization on the region expecially convient for China province or subregion */
    6: optional string detailsUrl

    /** How much exams are bounded to this campaign */
    7: optional i32 examsCount

}


/** 
 * Help to figure out which exams needs to be passed by default, 
 * and which may be added in addition to  the normal  exam list (3 exams). 
 */
enum EXAM_OBLIGATION {
    /** strictly required to be passed, i.e.  "russian / belorussian language" */
    MANDATORY_FOR_ALL 
    /** additional exam that may be added on top of normal exams list, i.e, art */
    ADDITIONAL_NON_COUNTED
    /** user may choose the exam **/
    USER_CHOICE
    /** just for parsing problems or uncomplete data */
    UNKOWN
}

/**
 * Help to distinguish which exams are real, like math
 * and which are fictional ones like russian /belorussian language or art,
 * that normally is expanded into rusiian_language, belorussian_language, or art_paintings,
 * art_composition, art_sculpture and so on correspondently.
 */
enum EXAM_GENERALIZATION {
    REAL
    GENERALIZED
    /** just for parsing problems or uncomplete data */
    UNKNOWN
}

/** The place where the exam is passed */
enum EXAM_PASSING_PLACE {
    /** Centralized test*/
    CENTRALIZED
    /** Educational organization test (in place) */
    IN_PLACE
    /** School based certificate */
    SCHOOL
    /** just for parsing problems or uncomplete data */
    UNKNOWN
}

/**
 * Exam that pupils needs to pass before enrollment
 */
 struct Exam {
    /** Exam identifier, e.g. 'math' */
    1: string id
    
    /** Full name in origin (native, official) language,
     *  e.g. 'Mathematic' (if the exam declaration  is 
     *  officially issued in English) 
     */
    2: string name

    /** Language of the origin name expressed as locale,
     *  e.g. ru_RU, or en_US 
     */
    3: string lang

    /** Mandatory of the exam */
    4: EXAM_OBLIGATION obligation

    /** Type to determine if the exam is real, or fictional (generalized) with parent-child rels */
    5: EXAM_GENERALIZATION generalization

    /** The place where the exam needs to be passed */
    6: EXAM_PASSING_PLACE  passingPlace

    /** The pupils popularity of the exam, correlated or equal with the number of registered person,
    *  The higher value then the more popular exam seems to be. May use to reorder exams by this param
    **/
    7: optional i32 popularity

    8: optional string parentExam

    /**
     * Url for further details, that may list full text description
     * on the item
     */
     9: optional string detailsUrl
   
    /** Omit this exam from list */ 
    10: optional bool omitted
 }

/** 
 *  A suite of the exams (the set of the exams grouped together) to be passed.
 *  It  basically determines the direction or fields
 *  of knowledge of the speciality where pupils may pretend to be enrolled
 *  later.  
 */
struct ExamSuite {
    /** The identification of the suite, e.g. 'Physics and Mathematics' */
    1: string id

    /** Full name in origin (native, official) language,
     *  e.g. 'Mathematic' (if the exam declaration  is
     *  officially issued in English)
     */
     2: string name

    /** Language of the origin name expressed as locale,
     *  e.g. ru_RU, or en_US
     */
     3: string lang


     /** The list of exam identifiers, that are supposed to be passed in  this suite
        e.g. {'math', 'physics',  'native_language'}  */
     4: list<string> exams

     /** Url for further details, that may list full text description
        on the item */
     5: optional string furtherDetailsUrl

}

/**
 * Auxiliary Condition, like
 * geograpic_minorities_village, national_minorities, winners_subject_contest
 */
struct AuxiliaryCondition {
    /** Condition identifier */
    1: string id

    /** Full name in original language of the identifier */
    2: string name

    /** Lang */
    3: string lang

    /** Details url */
    4: optional string furtherDetailsUrl
}

/**
 *  The individual result for the passed exam
 *  (or supposed grade for future exam)
 */ 
struct ExamResult {
    /** The identification of the exam, e.g. 'math', or 'school_grade' */
    1: string id

    /** The grade, e.g. a certain natural number in [0,100] */
    2: i32    grade

    /** Confidents Bounder, i.e. user stands that he supposes to get 75 grade for the exam. 
    * Here is the confindents bounders
    * <pre>
    * [45  56]  75  [80 85]
    * LE   LA   T    HA  HE
    * </pre>
    * (LE) LowExtreme  means the lower bound user supposed to get for the exam
    * (T)  Target is the expected grade for the exam */
    3: optional i32   gradeLowExtreme

    /** (LA) LowAverage  means the average worse result that may be experienced.  */
    4: optional i32   gradeLowAverage

    /** (HA) HighAverage  means that user may get this result really in average curcumstances */
    5: optional i32   gradeHighAverage

    /** (HE) HighExtreme means the maximum grade user may get with realistic supposes. */
    6: optional i32   gradeHighExtreme

    /** whether the passed grade is known, or just predicted by user */
    7: optional bool isExactGrade;
}

/**
 *  Enrollment request, that contains most of target data
 *  needs to be taken into account for enroll.
 *  No personal data is included here
 */
struct EnrollmentRequest {
    1: string suite

    /** Total graduation, that used to be up to 400 or 500 */
    2: i32              gradeTotal

    /** List of exams with appropriate grades
    * The size of this list tends to be 4 (3 exams + school_grade),
    * or 5 (3 exams + school_grade + special_exam)
    */
    3: optional list<ExamResult> results

    /** List of possible auxiliary conditions valid against the pupil
    * to usually apply special rules during enrollment, or recalculate grades
    * e.g. geograpic_minorities_village, national_minorities, winners_subject_contest
    */
    4: optional list<string>     auxiliaryConditions

    /**
     * (LE) LowExtreme  means the lower bound user supposed to get as total grade 
     */
    5: optional i32   gradeTotalLowExtreme

    /** (LA) LowAverage  means the average worse total result that may be experienced.  */
    6: optional i32   gradeTotalLowAverage

    /** (HA) HighAverage  means that user may get this result really in average curcumstances */
    7: optional i32   gradeTotalHighAverage

    /** (HE) HighExtreme means the maximum total grade user may get with realistic supposes. */
    8: optional i32   gradeTotalHighExtreme
}

/**
 *  Speciality in a certain university 
 */
struct Speciality {
      /** Speciality full name, e.g. "Computer mathematic"*/
      1: string name
    
      /** University full name, e.g. 'Belorussian State University'*/
      2: string universityName
    

      /** Faculty full name, e.g. 'Mechanic and Mathematic Faculty',*/
      /** 'Institute of Journalizm'*/
      3: string departmentName
    

      /** Language of the origin name, e.g. locale ru_RU*/
      4: string lang

      /** Url for further details, that may list full text description
       * on the item, including the line of all applicantsPerVacancyNumber,
       * address, phones*/
      5: string furtherDetailsUrl
      
      6: optional string departmentShortName

      7: optional string universityShortName

}

/**
 *  Speciality in a certain university 
 */
struct Specialization {
     /** Speciality Identifier */
     1: string id

     /** Specialization name, e.g. "Internet Marketing" */
     2: string name

     /** Language of the origin name, e.g. locale ru_RU*/
     3: string lang

     /** Url for further details */
     4: optional string furtherDetailsUrl
}

/**
 *  Enrollment threshold for the speciality at the given graduation campaign
 *  This is the target (end-user)  information listed in different search and filtering 
 *  scenarious. 
 */
struct EnrollmentThreshold {
	/** Identifier, e.g.  by.bsu.mmf@compmath.1998/by-2013 */
    1: string id

    /** Speciality */
	2: Speciality speciality

	/** Enrollment Campaign identifier, e.g. by-2013*/
	3: string campaign

 	/** Lower bounder threshold on the enrollment, i.e.
	    pupils with the exact same  graduation total were been enrolled for sure*/
	5: double threshold

        /** The number of applicants really enrolled for the given speciality
         * at the end of the certain campaign */
	6: optional i32 applicantsEnrolled

        /** The number of declared vacancy usually at the start of campaign */
	7: optional i32 declaredVacancies

	/** The number of vacancies after all person with noExams, noContents, target are been enrolled.  */
	8: optional i32 effectiveVacancies

    /** The list of exams identifiers needs to be passed, including
     * a so called special (e.g. art, music) exams taked exclusively in
     * the university, so the original ExamSuite includes 'art', while
     * the exams listed here may expose 'art_freestyle', 'art_composition',
     * 'art_drawing' */
	9: optional list<string> exams


	/** Chances to be enrolled, that may be depicted as a certain color*/
        /*  0 till 1 low chances, 1 till 2 normal chances, 2 till 3 high changes to be enrolled */
	10: optional double enrollmentChances

	11: string lang

}

/** Page of thresholds list */
struct EnrollentThresholdPage {
    1: i32 currentPage
    2: i32 totalPages
    3: list<EnrollmentThreshold> thresholds;
}

/**
 * University details on the enrollment 
 * mostly to inform user on contact persons
 */
struct EnrollmentCommetee {
    /** University or department identifier*/
    1: string id

    /** Enrollemnt service phone number*/
    2: optional string phone

    /** University Web site*/
    3: optional string site

    4: optional string description

    5: optional string lang
}

/** If the given request with the  threshold value (e.g. 380) is passed for enrollment,
     semipassed, or out of passing */
enum ENROLL_LEVEL {THRESHOLD_PASSED, THRESHOLD_PARTIAL,THRESHOLD_OUT }

struct RequestLineCellItem {
    /** Depends on a number of compared specialities, normally from 1 to 3 */
    1: i32 columnPosition
    2: string value
    3: optional string diff
    4: optional ENROLL_LEVEL enrollLevel
}

struct RequestLineRowItem {
    1: list<RequestLineCellItem> cells
    /** Identifier by position betwee requestline rows */
    2: i32 position
    3: optional string name
    4: optional string lang
    5: optional string updatedTime
    6: optional list<RequestLineCellItem> diffs
}

struct RequestLine {
    1: list<string> specialitiesColumnIds
    2: list<RequestLineRowItem> rows
    3: optional list<string> specialitiesColumnNames
}


