/*
 * Copyright 2017 Pangramia Limited.
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

namespace java com.pangramia.enroll.services

include "exceptions.thrift"
include "pb303.thrift"
include  "types.thrift"


/**
 * Enrollment service
 */
service EnrollmentService extends pb303.PBService {

        /**
         * Language list in natives, i.e. English, Русский, Беларускi
         */
        list<types.Lang>                langs(1:string authToken )
                                                 throws (1: exceptions.PBServiceException serviceExp,
                                                         2: exceptions.PBUserException    userExp)

        /**
         * Available regions for education search
         */
        list<types.Region>              regions(
                                            1:string lang,
                                            2:string authToken)
                                                  throws (1: exceptions.PBServiceException serviceExp,
                                                          2: exceptions.PBUserException    userExp)
        /**
         * Campaigns for the given region
         */
        list<types.Campaign>            campaigns(
                                            1:string region,
                                            2:string lang,
                                            3:string authToken)
                                                    throws (1: exceptions.PBServiceException serviceExp,
                                                            2: exceptions.PBUserException    userExp)
        /**
         * Exams for given campaign
         */
        list<types.Exam>                exams(
                                          1:string region,
                                          2:string campaign,
                                          3:string lang,
                                          4:string authToken)
                                                 throws (1: exceptions.PBServiceException serviceExp,
                                                         2: exceptions.PBUserException    userExp)

        /**
         * Available suites
         */
        list<types.ExamSuite>          suites (
                                                1:string region,
                                                2:string campaign,
                                                3:string lang,
                                                4:string authToken)
                                                        throws (1: exceptions.PBServiceException serviceExp,
                                                                2: exceptions.PBUserException    userExp)
        /**
         * Suites by chosen exams
         */
        list<types.ExamSuite>          suitesByExams(
                                                1:string region,
                                                2:string campaign,
                                                3:list<string> exams,
                                                4:string lang,
                                                5:string authToken)
                                                        throws (1: exceptions.PBServiceException serviceExp,
                                                                2: exceptions.PBUserException    userExp)
        /**
         *  List of specialities centered by user grade
         */
        types.EnrollentThresholdPage thresholdsCentered(
                                            1: string region,
                                            2: string campaign,
                                            3: string suite,
                                            4: i32 gradeTotal,
                                            5: string lang,
                                            6: string authToken)
                                                  throws (1: exceptions.PBServiceException ex1,
                                                          2: exceptions.PBUserException    ex2)


        /**
         *  Paginated list of specialities
         */
        types.EnrollentThresholdPage thresholdsPaged(
                                            1: string region,
                                            2: string campaign,
                                            3: string suite,
                                            4: i32 gradeTotal,
                                            5: i32 page,
                                            6: string lang,
                                            7: string authToken)
                                                  throws (1: exceptions.PBServiceException ex1,
                                                          2: exceptions.PBUserException    ex2)
        /**
        * Threshold values per starts of each page of a given search result
        */
        list<i32>                    thresholdPerPageBounds(
                                            1: string region,
                                            2: string campaign,
                                            3: string suite,
                                            4: string lang,
                                            5: string authToken)
                                                  throws (1: exceptions.PBServiceException ex1,
                                                          2: exceptions.PBUserException    ex2)

        /** Thresholds by id */
        list<types.EnrollmentThreshold>    thresholds(
                                            1: string region,
                                            2: string campaign,
                                            3: list<string> thresholdIds,
                                            4: string lang,
                                            5: string authToken)
                                                   throws (1: exceptions.PBServiceException ex1,
                                                           2: exceptions.PBUserException    ex2)

        /**
        *  Paginated list of specialities
        */
        types.RequestLine thresholdsRequestLine(
                                                    1: string region,
                                                    2: string campaign,
                                                    3: list<string> thresholdIds,
                                                    4: string lang,
                                                    5: string authToken,
                                                    6: optional string updatedTime)
                                                          throws (1: exceptions.PBServiceException ex1,
                                                                  2: exceptions.PBUserException    ex2)
}
