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

/**
 * Base service definitions are declared in this files. 
 * The naming is originated from the original facebook fb303.thrift file. 
 * Means, pb303 is the shared root of all thrift services,  
 * pb303 => PangramiaBase303
 */ 
namespace java com.pangramia.services

/**
 * Common status reporting mechanism across all services
 * @seeAlso facebook fb303.thrift
 */
enum pb_status {
  DEAD     = 0,
  STARTING = 1,
  ALIVE    = 2,
  STOPPING = 3,
  STOPPED  = 4,
  WARNING  = 5,
}


/**
 *  Standard public API for base service
 */
service PBService {

  /**
   * Returns a descriptive name of the service
   * @return service name
   */
  string getName()

  /**
   * Returns the version of the service
   * @return service version
   */
  string getVersion()

  /**
   * Check  if the client current sdk version is ok to be used 
   * with the given service
   * or update is required due to incompatibility. Returns pair
   * if may use the current version, and if no, the reasons why
   *
   * @param clientVersion the version of a caller
   * @param lang the lang in which the message to client needs to be depicted if available
   * @return the pair (if clientVersion is compatible, message to client)
   */
  map<bool, string> checkVersion(1: string clientVersion, 2:string lang)

  /**
   * Gets the status of this service
   * @return service status
   */
  pb_status getStatus()

  /**
   * User friendly description of status, such as why the service is in
   * the dead or warning state, or what is being started or stopped.
   * @param lang a client preferred language
   * @return message to client in a given lang
   */
  string getStatusDetails(1:string lang)

  /**
   * Get an option, mostly used to query enabled features
   * @return option value
   */
  string getOption(1: string key)

  /**
   * Gets all options
   */
  map<string, string> getOptions()

}
