///////////////////////////////////////////////////////////////////////////////
//
// Project: BlockScore API wrapper for iOS
// File: BlockScoreWrapper.m
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
// Revision Notes:
//
//
///////////////////////////////////////////////////////////////////////////////

#import "BlockScoreWrapper.h"

@implementation BlockScoreWrapper

@synthesize key;
@synthesize name;
@synthesize date_of_birth;
@synthesize address;
@synthesize identification;

@synthesize verification_id;
@synthesize verifications_list_options;

@synthesize question_set_create_options;
@synthesize questions_and_answers_set;
@synthesize question_set_id;

@synthesize company_info;
@synthesize company_id;

@synthesize watchlist_candidate_id;
@synthesize watchlist_candidate_info;
@synthesize watchlist_candidate_info_updates;

@synthesize httpMethod;
@synthesize requestURL;

@synthesize POSTData;
@synthesize GETParams;

@synthesize requestType;
@synthesize delegate;
@synthesize authHeader;

@synthesize searchCriteria;



+ (BlockScoreWrapper*)sharedInstance
{
	
	
	static BlockScoreWrapper *_sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [[BlockScoreWrapper alloc] init];
		
		//Additional customization for static items:
		_sharedInstance.key = BLOCKSCORE_API_KEY;
		
		NSMutableString *basicAuthCredentials = [[NSMutableString alloc] initWithFormat:@"%@", _sharedInstance.key];
		NSData *encodedLoginData = [basicAuthCredentials dataUsingEncoding:NSASCIIStringEncoding];
		NSString *authHeader = [NSString stringWithFormat:@"Basic %@", [encodedLoginData base64EncodedStringWithOptions:nil]];
		_sharedInstance.authHeader = authHeader;
		
	});
	
	return _sharedInstance;
	
}




-(void) sendRequest
{
	NSInteger thisRequest = [self.requestType integerValue];
	
	switch (thisRequest) {
			
		////  VERIFICATIONS APIs //////////
		case VERIFICATIONS_LIST:
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@", BSE_BASE_URL, BSE_VERIFICATIONS];
			break;
		
		case VERIFICATION_NEW:
		{
			self.httpMethod = @"POST";
			self.requestURL = [NSString stringWithFormat:@"%@%@", BSE_BASE_URL, BSE_VERIFICATIONS];
			
			//Construct postData
			NSMutableDictionary *postDataDictionary = [[NSMutableDictionary alloc]init];
			[postDataDictionary setObject:self.date_of_birth forKey:@"date_of_birth"];
			[postDataDictionary setObject:self.name forKey:@"name"];
			[postDataDictionary setObject:self.address forKey:@"address"];
			[postDataDictionary setObject:self.identification forKey:@"identification"];
			
			NSError *jsonSerializationError = nil;
			NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDataDictionary options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
			self.POSTData = jsonData;
			break;
		}
			
		
		case VERIFICATIONS_LIST_WITH_OPTIONS:
		{
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@%@", BSE_BASE_URL, BSE_VERIFICATIONS, self.verifications_list_options];
			break;
			
		}
			
		case VERIFICATION_BY_ID:
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@/%@", BSE_BASE_URL, BSE_VERIFICATIONS, self.verification_id];
			break;
			
		
		////  QUESTION SET APIs //////////
		case QUESTION_SET_NEW:
		{
			self.httpMethod = @"POST";
			self.requestURL = [NSString stringWithFormat:@"%@%@", BSE_BASE_URL, BSE_QUESTIONS];
			NSError *jsonSerializationError = nil;
			NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.question_set_create_options options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
			
			self.POSTData = jsonData;
			break;
		}
		
		case QUESTION_SET_LIST:
		{
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@",BSE_BASE_URL,BSE_QUESTIONS];
			break;
		}
			
		case QUESTION_SET_BY_ID:
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@/%@", BSE_BASE_URL, BSE_QUESTIONS, self.question_set_id];
			break;
			
		case QUESTION_SET_SCORE:
		{
			self.httpMethod=@"POST";
			self.requestURL = [NSString stringWithFormat:@"%@%@/%@/score", BSE_BASE_URL, BSE_QUESTIONS, self.question_set_id];

			NSError *jsonSerializationError = nil;
			NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.questions_and_answers_set options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
			self.POSTData = jsonData;
			break;
		}
			
						
		//COMPANY APIS
		case COMPANY_NEW:
		{
			self.httpMethod=@"POST";
			self.requestURL = [NSString stringWithFormat:@"%@%@",BSE_BASE_URL,BSE_COMPANIES];
			
			NSError *jsonSerializationError = nil;
			NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.company_info options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
			self.POSTData = jsonData;
			
			break;
			
		}
			
		case COMPANY_LIST:
		{
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@", BSE_BASE_URL, BSE_COMPANIES];
			break;
		}
			
		case COMPANY_BY_ID:
		{
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@/%@", BSE_BASE_URL,BSE_COMPANIES,self.company_id];
			break;
		}
		
		//WATCHLIST APIs
		case WATCHLIST_CANDIDATE_NEW:
		{
			self.httpMethod = @"POST";
			self.requestURL = [NSString stringWithFormat:@"%@%@", BSE_BASE_URL, BSE_WATCHLIST_CANDIDATES];
			
			NSError *jsonSerializationError = nil;
			NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.watchlist_candidate_info options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
			self.POSTData = jsonData;			
			break;
			
		}
		case WATCHLIST_CANDIDATE_EDIT:
		{
			self.httpMethod = @"PATCH";
			self.requestURL = [NSString stringWithFormat:@"%@%@/%@", BSE_BASE_URL, BSE_WATCHLIST_CANDIDATES, self.watchlist_candidate_id];
			NSError *jsonSerializationError = nil;
			NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.watchlist_candidate_info_updates options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
			self.POSTData = jsonData;
			break;
			
			
		}
			
		case WATCHLIST_CANDIDATE_DELETE:
		{
			self.httpMethod = @"DELETE";
			self.requestURL = [NSString stringWithFormat:@"%@%@/%@", BSE_BASE_URL, BSE_WATCHLIST_CANDIDATES, self.watchlist_candidate_id];
			break;
			
		}
		
		case WATCHLIST_CANDIDATE_LIST:
		{
			self.httpMethod = @"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@", BSE_BASE_URL,BSE_WATCHLIST_CANDIDATES];
			break;
		}
			
			
		case WATCHLIST_CANDIDATE_HITS:
		{
			self.httpMethod=@"GET";
			self.requestURL=[NSString stringWithFormat:@"%@%@/%@/hits", BSE_BASE_URL, BSE_WATCHLIST_CANDIDATES,self.watchlist_candidate_id];
			break;
		}
		
			
		case WATCHLIST_CANDIDATE_HISTORY:
		{
			self.httpMethod=@"GET";
			self.requestURL=[NSString stringWithFormat:@"%@%@/%@/history", BSE_BASE_URL, BSE_WATCHLIST_CANDIDATES,self.watchlist_candidate_id];
			break;
		}
		
		case WATCHLIST_SEARCH:
		{
			self.httpMethod=@"POST";
			self.requestURL = [NSString stringWithFormat:@"%@%@", BSE_BASE_URL, BSE_WATCHLIST];
			NSError *jsonSerializationError = nil;
			NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.searchCriteria options:NSJSONWritingPrettyPrinted error:&jsonSerializationError];
			self.POSTData = jsonData;
			break;
			
			break;
		}
			
		 case WATCHLIST_CANDIDATE_BY_ID:
		{
			self.httpMethod=@"GET";
			self.requestURL = [NSString stringWithFormat:@"%@%@/%@", BSE_BASE_URL, BSE_WATCHLIST_CANDIDATES,self.watchlist_candidate_id];
			break;
			
		}
			
		default:
			break;
			

			
	}

	NSURL *thisURL = [NSURL URLWithString:self.requestURL];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:thisURL
														   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	[request setHTTPMethod:self.httpMethod];
	[request setValue:@"application/vnd.blockscore+json;version=3" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:authHeader forHTTPHeaderField:@"Authorization"];
	
	if ([self.httpMethod isEqualToString:@"POST"] || [self.httpMethod isEqualToString:@"PATCH"]) {
	 	[request setHTTPBody:self.POSTData];
	}
	
	NSError *error;
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:(id)self delegateQueue:nil];
	
	
	NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
										  {
											  NSURLResponse *thisResponse = [[NSURLResponse alloc] init];
											  thisResponse =response;
											  NSError *thisError = [[NSError alloc]init];
											  thisError = error;
											  
												[self.delegate didFinishBlockScoreRequestWithResponse:(NSData*) data response:(NSURLResponse*)response error:(NSError*) error];
											  
										  }];
	
	[postDataTask resume];
		
}

-(void) requestTypeValue:(NSInteger)reqType
{
	self.requestType = [NSNumber numberWithInteger:reqType];
	
}


/**
 Convenience/Helper methods:
 Users of BlockScoreWrapper don't necessarily need to call any of the methods below. User can alloc/init their own name, address or identification thru a new NSMutableDictionary.
 However, using the convenience methods below provides convenient and easier way of setting name, address or id as input to blockscore object.
 
 The only caveat is, users must follow the sequence of the string segments as documented on each of the methods below where applies. See specific requirements/documentations within the various
 methods.

 **/

-(void) setNameWithValues:(NSString*) thisName
{
	/**
	 Notes:
	 This is a helper/convenience method that constructs an NSMutableDictionary that then gets assigned to the
	 blockscore object's person name property.
	 
	 Important: It expects that the name string has the following sequence:
	 segment0 = first name
	 segment1 = middle name
	 segment2 = last name
	 **/
	
	NSArray *nameSegments = [thisName componentsSeparatedByString:@","];
	self.name = [NSMutableDictionary dictionaryWithObjectsAndKeys:	[nameSegments objectAtIndex:0], @"first",
				 													[nameSegments objectAtIndex:1], @"middle",
				 													[nameSegments objectAtIndex:2], @"last",
																	 nil];
	
}

-(void) setAddressWithValues:(NSString*) thisAddress
{
	/**
	 Notes:
	 This is a helper/convenience method that constructs an NSMutableDictionary that then gets assigned to the
	 blockscore object's address property.
	 
	 Important: It expects that 'thisAddress' string has the follwoing segments per the sequence below:

	 **/
	
	NSArray *addressSegments = [thisAddress componentsSeparatedByString:@","];
	self.address = [NSMutableDictionary dictionaryWithObjectsAndKeys:	[addressSegments objectAtIndex:0], @"street1",
				 														[addressSegments objectAtIndex:1], @"street2",
				 														[addressSegments objectAtIndex:2], @"city",
																		[addressSegments objectAtIndex:3], @"state",
																		[addressSegments objectAtIndex:4], @"postal_code",
																		[addressSegments objectAtIndex:5], @"country_code",
																		 nil];
	
}


-(void) setIdentificationWithValues:(NSString*) thisID
{
	//This may include 'passport' in the future..
	
	NSArray *idSegments = [thisID componentsSeparatedByString:@","];
	self.identification = [NSMutableDictionary dictionaryWithObjectsAndKeys:[idSegments objectAtIndex:0] ,@"ssn", nil];
	
}


-(void) setDOBWithValue:(NSString *)dob
{
	
	self.date_of_birth = dob;
	
}


-(void) setQuestionSetCreateOptionsWithValues:(NSString*) new_questions_set_options
{
	NSArray *createOptions = [new_questions_set_options componentsSeparatedByString:@","];
	NSMutableDictionary *createOptionsDictionary = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
																	[createOptions objectAtIndex:0],@"verification_id",
																	[createOptions objectAtIndex:1],@"time_limit",nil];

	
	self.question_set_create_options = createOptionsDictionary;
		 
}



-(NSString*) convertToURLParams:(NSMutableDictionary*)params
{

	NSMutableString *tempParams = [[NSMutableString alloc] initWithString:@"?"];
	
	for (NSString* k in params) {
		[tempParams stringByAppendingString:[NSString stringWithFormat:@"%@=%@", k, [params objectForKey:key]]];
		 
	}
	
	/**
	 Notes:
	 Per BlockScore API v3.0, we are NOT URLEncoding the params as they look fairly basic at this time.
	 However, reviese this method if there's a clear need for URLEncodign in the future.
	 **/
	
	return [tempParams copy];
}


-(void) setVerificationsListOptionsWithValues:(NSString*) options
{
	
	NSString *params = [self convertAsURLParams:options];
	self.verifications_list_options = params;
	
}



-(NSString *)convertAsURLParams:(NSString*) optionString
{
	/**
	 Notes:
	 
	 Helper/convenience method that expects a string of options in this format:
	 @"count:3, offset:20, start_date:1399462730,end_date:1399462730"
	 
	 It then breaks it down and returns a URL string param like this:
	 
	 "?count=3&offset=3&start_date=1399462730&end_date=1399462730"
	 
	 ready to be appended to an end point URL..
	 **/

	
	NSArray *options = [optionString componentsSeparatedByString:@","];
	
	NSMutableString *urlParams = [[NSMutableString alloc]initWithString:@"?"];
	
	for (NSString *thisOption in options) {
		NSArray* oKeyValue = [thisOption componentsSeparatedByString:@":"];
		urlParams = (NSMutableString*)[urlParams stringByAppendingString:[NSMutableString stringWithFormat:@"%@=%@&",[oKeyValue objectAtIndex:0],[oKeyValue objectAtIndex:1]]];
		
	}
	//Strip the '&' at the end of urlPararms
	if ( [urlParams length] > 0){
		urlParams = (NSMutableString*)[urlParams substringToIndex:[urlParams length] - 1];
	}
	
	
	/**
	 Notes:
	 Per BlockScore API v3.0, we are NOT URLEncoding the params as they look fairly basic at this time.
	 However, revise this method if there's a clear need for URLEncoding in the future, e.g., params with string chars instead of numeric.
	 **/
	
	return [urlParams copy];
	
}


-(void) questionsAndAnswersForId:(NSString*)questionset_id questionsAndAnswers:(NSString*) questions_and_answers
{
	
	/**
	 Notes:
	 This is a helper function that makes it easy to set up the needed POST data for preparing for
	 question scoring.
	 
	 **/
	
	self.question_set_id = questionset_id;
	
	//Break down and process questions_and_anwers
	NSArray *qa_list = [questions_and_answers componentsSeparatedByString:@","];
	
	NSMutableArray *final_qa_list = [[NSMutableArray alloc]init];
	
	for (NSString *qa_item in qa_list) {
		NSArray *qa = [qa_item componentsSeparatedByString:@":"];
		NSDictionary *qaKeyValues = [NSDictionary dictionaryWithObjectsAndKeys:
										 	[qa objectAtIndex:0],@"question_id",
										 	[qa objectAtIndex:1],@"answer_id", nil];
		
		[final_qa_list addObject:qaKeyValues];		
	}
	
	self.questions_and_answers_set = [[NSMutableDictionary alloc]initWithObjectsAndKeys:final_qa_list,@"answers", nil];
	
}

@end
