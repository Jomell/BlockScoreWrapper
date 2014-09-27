///////////////////////////////////////////////////////////////////////////////
//
// Project: BlockScore API wrapper for iOS
// File: BlockScoreWrapper.h
//
// Copyright (c) 2014 Mobickus LLC. All rights reserved.
// Created by: Jomel Losorata
//
// MIT LICENSE:
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// Date: 9/20/14
//
// Version 1.0
//
// Description: Wrapper object for BlockScore APIs.  See the notes below on how
// to use this wrapper code. Mobickus LLC is not associated with BlockScore in any
// way and this software is provided as is under MIT license.
//
// This implementation is based on public information available  @
// http://docs.blockscore.com/v3.0/curl/
//
// Revision Notes:
//
//
///////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>


#define BLOCKSCORE_API_KEY			@"YOUR_BLOCKSCORE_API_KEY"



//BlockScore Endpoints:
#define BSE_BASE_URL				      @"https://api.blockscore.com/"
#define BSE_VERIFICATIONS			    @"verifications"
#define BSE_QUESTIONS				      @"questions"
#define BSE_QUESTIONS_SCORE		    @"questions/score"
#define BSE_COMPANIES				      @"companies"
#define BSE_WATCHLIST_CANDIDATES	@"watchlist_candidates"
#define BSE_WATCHLIST				      @"watchlists"


typedef enum{
	VERIFICATIONS_LIST,
	VERIFICATIONS_LIST_WITH_OPTIONS,
	VERIFICATION_NEW,
	VERIFICATION_BY_ID,
	QUESTION_SET_NEW,
	QUESTION_SET_SCORE,
	QUESTION_SET_BY_ID,
	QUESTION_SET_LIST,
	COMPANY_NEW,
	COMPANY_BY_ID,
	COMPANY_LIST,	
	WATCHLIST_CANDIDATE_NEW,
	WATCHLIST_CANDIDATE_EDIT,
	WATCHLIST_CANDIDATE_DELETE,
	WATCHLIST_CANDIDATE_BY_ID,
	WATCHLIST_CANDIDATE_LIST,
	WATCHLIST_CANDIDATE_HISTORY,
	WATCHLIST_CANDIDATE_HITS,
	WATCHLIST_SEARCH
}BSE_REQUEST_TYPES;



@protocol BlockScoreDelegate <NSObject>

//Implement this method whereever you are instantiating BlockScoreWrapper object.
-(void) didFinishBlockScoreRequestWithResponse:(NSData*) data response:(NSURLResponse*)response error:(NSError*) error;

@end


@interface BlockScoreWrapper : NSObject
{
	NSNumber						*requestType;
	
	NSString 						*key;							//API key as issued by BlockScore
	NSMutableDictionary				*name;							//expect this dictionary to have the following keys:first, middle and last
	NSString						*date_of_birth;					//string in the format of yyyy-mm-dd
	NSMutableDictionary				*address;						//expect this dictionary to have the following keys:
	NSMutableDictionary				*identification;
	NSMutableDictionary				*question_set_create_options;
	NSMutableDictionary				*questions_and_answers_set;
	NSMutableDictionary				*watchlist_candidate_info;  //property for storing various info when creating a new watchlist_candidate
	NSMutableDictionary				*watchlist_candidate_info_updates; //property for storing  key/value pairs for updates to an existing watchlist_candidate_id
	
	NSMutableDictionary				*searchCriteria;
	
	NSString						*verifications_list_options;
	NSString						*verification_id;
	NSString						*question_set_id;
	
	
	NSMutableDictionary				*company_info;
	NSString						*company_id;
	NSString						*watchlist_candidate_id;
	
	NSString						*httpMethod;
	NSString						*requestURL;
	
	
	NSData							*POSTData;					//temp container for POST data for blockScore requests
	NSMutableDictionary				*GETParams;					//temp container for GET params for blockscore requests
	
	
	__weak      					id delegate;
	NSString						*authHeader;
	
}


@property(nonatomic, retain) NSString 				*key;
@property(nonatomic, retain) NSMutableDictionary	*name;
@property(nonatomic, retain) NSString				*date_of_birth;
@property(nonatomic, retain) NSMutableDictionary 	*address;
@property(nonatomic, retain) NSMutableDictionary	*identification;
@property(nonatomic, retain) NSMutableDictionary	*question_set_create_options;
@property(nonatomic, retain) NSMutableDictionary	*questions_and_answers_set;
@property(nonatomic, retain) NSMutableDictionary	*watchlist_candidate_info;
@property(nonatomic, retain) NSMutableDictionary 	*watchlist_candidate_info_updates;
@property(nonatomic, retain) NSString				*verifications_list_options;
@property(nonatomic, retain)NSMutableDictionary		*searchCriteria;
@property(nonatomic, retain) NSString				*verification_id;
@property(nonatomic, retain) NSString				*question_set_id;
@property(nonatomic, retain) NSMutableDictionary	*company_info;
@property(nonatomic, retain) NSString				*company_id;
@property(nonatomic, retain) NSString				*watchlist_candidate_id;
@property(nonatomic, retain) NSData					*POSTData;
@property(nonatomic, retain) NSMutableDictionary	*GETParams;
@property(nonatomic, retain) NSNumber				*requestType;
@property(nonatomic, retain) NSString				*httpMethod;
@property(nonatomic, retain) NSString				*requestURL;
@property(weak, nonatomic)							id<BlockScoreDelegate> delegate;
@property(nonatomic, retain)NSString				*authHeader;




+(id)sharedInstance;

-(void) setNameWithValues:(NSString*) name;
-(void) setAddressWithValues:(NSString*) address;
-(void) setDOBWithValue:(NSString*) dob;  //date of birth
-(void) setIdentificationWithValues:(NSString*) identification;
-(void) setVerificationsListOptionsWithValues:(NSString*) verifications_list_options;

-(void) setQuestionSetCreateOptionsWithValues:(NSString*) new_questions_set_options;
-(void) requestTypeValue:(NSInteger)type;
-(void) sendRequest;
-(void) questionsAndAnswersForId:(NSString*)questionset_id questionsAndAnswers:(NSString*) questions_and_answers;

@end



