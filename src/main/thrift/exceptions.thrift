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
 * Exceptions that may occur when making calls to services. 
 */
namespace java com.pangramia.services.exceptions

/**
 * Common Error Codes
 */
enum PBErrorCode {
  /** No information available about the error */
  UNKNOWN = 1,

  /** The format of the request data was incorrect */
  BAD_DATA_FORMAT = 2,
  
  /** Not permitted to perform action */
  PERMISSION_DENIED = 3,
  
  /** Unexpected problem with the service */
  INTERNAL_ERROR = 4,
  
  /** A required parameter/field was absent */
  DATA_REQUIRED = 5,
  
  /** Operation denied due to data model limit */
  LIMIT_REACHED = 6,
  
  /** Operation denied due to user storage limit */
  QUOTA_REACHED = 7,
  
  /** Username and/or password incorrect */
  INVALID_AUTH = 8,

  /** Authentication token expired */
  AUTH_EXPIRED = 9,

  /** Change denied due to data model conflict */
  DATA_CONFLICT = 10,

  /** Content of submitted note was malformed */
  VALIDATION = 11,

  /** Service shard with account data is temporarily down */
  SHARD_UNAVAILABLE = 12,
  
  /** Operation denied due to data model limit, where something such
   *  as a string length was too short */
  LEN_TOO_SHORT = 13,

  /** Operation denied due to data model limit, where something such
   *  as a string length was too long */
  LEN_TOO_LONG = 14,

  /** Operation denied due to data model limit, where there were
   *  too few of something. */
  TOO_FEW = 15,

  /** Operation denied due to data model limit, where there were
   *  too many of something. */
  TOO_MANY = 16,

  /** Operation denied because it is currently unsupported. */
  UNSUPPORTED_OPERATION = 17,

  /** Operation denied because access to the corresponding object is
   *  prohibited in response to a take-down notice. */
  TAKEN_DOWN = 18,
  
  /**
   * Operation denied because the calling application has reached
   * its hourly API call limit for this user. */
  RATE_LIMIT_REACHED = 19,

  /** The given resource is not found */
  NOT_FOUND = 20
}

/**
* Basic Service exception, that occurs due to service malformed behaviour
**/
exception PBServiceException {
   1: required PBErrorCode errorCode,
   2: string message
}

/**
* Basic User exception, that triggered by user misuse of the service or  improper arguments
**/
exception PBUserException {
   1: required PBErrorCode errorCode,
   2: string message
}

 
