BlockScoreWrapper
=================

iOS helper/wrapper for www.blockscore.com identity management API/Platform

BlockScoreWrapper is an object for BlockScore APIs.  See the notes below on how
to use this wrapper code. Mobickus LLC is not associated with BlockScore in any
way and this software is provided as is under MIT license.


To use BlockScoreWrapper follow these steps:

 1. Sign up and obtain a BlockScore API Key from http://www.blockscore.com
 2. Edit BlockScoreWrapper.h and replace BLOCKSCORE_API_KEY definition with your own key
 3. Implement one delegate method on the object where you are instantiating BlockScoreWrapper.  This method receives the response from blockscore.com
 
 -(void) didFinishBlockScoreRequestWithResponse:(NSData*) data response:(NSURLResponse*)response error:(NSError*) error;
 
 4. That's it!
 
 
 
 
 SAMPLE USAGE:

 Note: No need to call [BlockScoreWrapper sharedInstance] multiple times if you are calling it several times in the
 same object.  It's repeated here so you can easily cut and paste the code chunks as working, independent code block,
 ready to be used.

 Where an id is needed, replace the sample below with your own valid IDs.
 
 
		 VERIFICATION LIST:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 [bs requestTypeValue:VERIFICATIONS_LIST];
			 bs.delegate = (id)self;
			 [bs sendRequest];
 
		 VERIFICATION_NEW
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 [bs setNameWithValues:@"Joel,Percy,Jackson"];
			 [bs setDOBWithValue:@"1980-01-01"];
			 [bs setAddressWithValues:@"1 Main Street,,San Francisco,CA,95154,US"];
			 [bs setIdentificationWithValues:@"532144449"];
			 [bs requestTypeValue:VERIFICATION_NEW];
			 [bs sendRequest];
 
 		VERIFICATIONS_LIST_WITH_OPTIONS:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 [bs setVerificationsListOptionsWithValues:@"count:10,offset:0,start_date:1399462730,end_date:1411601664"];
			 [bs requestTypeValue:VERIFICATIONS_LIST_WITH_OPTIONS];
			 [bs sendRequest];
 
 
		VERIFICATION_BY_ID:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 bs.verification_id = @"542200e53565350002930400";
			 [bs requestTypeValue:VERIFICATION_BY_ID];
			 [bs sendRequest];
 
		 QUESTION_SET_NEW:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = (id)self;
			 [bs setQuestionSetCreateOptionsWithValues:@"542200e53565350002930400,300"];
			 [bs requestTypeValue:QUESTION_SET_NEW];
			 [bs sendRequest];
 
		 QUESTION_SET_LIST
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = (id)self;
			 [bs requestTypeValue:QUESTION_SET_LIST];
			 [bs sendRequest];
 
 
 		QUESTION_SET_BY_ID
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = (id)self;
			 bs.question_set_id=@"542633bb3266350002c20400";
			 [bs requestTypeValue:QUESTION_SET_BY_ID];
			 [bs sendRequest];
 
 
	 	QUESTION SET SCORE
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
 			 bs.delegate = self;
			 [bs questionsAndAnswersForId:@"542368eb3135370002ae0500" questionsAndAnswers:@"1:3,2:1,3:4,4:3"];
			 [bs requestTypeValue:QUESTION_SET_SCORE];
			 [bs sendRequest];
 
		COMPANY_NEW:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 [bs setAddressWithValues:@"1 Main Street,,San Francisco,CA,95154,US"]; //make sure to set this first, sequence is important!
			 NSMutableDictionary *co_info =[NSMutableDictionary dictionaryWithObjectsAndKeys:
						 @"CompanyX", @"entity_name",
						 @"100223344", @"tax_id",
						 @"2013-01-01", @"incorp_date",
						 @"CA", @"incorp_state",
						 @"US", @"incorp_country_code",
						 @"corporation", @"incorp_type",
						 @"Foo123", @"dbas",
						 @"111222333", @"registration_number",
						 @"john@companyx.com", @"email",
						 @"http://www.companyx.net", @"url",
						 @"1-800-888-8888", @"phone",
						 @"67.160.8.190", @"ip_address",
						 bs.address, @"address",
						 nil];
			 bs.company_info = co_info;
			 [bs requestTypeValue:COMPANY_NEW];
			 [bs sendRequest];
 
 	
 		COMPANY_BY_ID:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 bs.company_id = @"5424e2593963660002730400";
			 [bs requestTypeValue:COMPANY_BY_ID];
			 [bs sendRequest];
 
 
		 WATCHLIST_CANDIDATE_NEW:
			BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			NSMutableDictionary *new_watchlist_candidate_info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
						@"note_here", @"note",
						@"001", @"ssn",
						@"1940-08-11", @"date_of_birth",
						@"Peter", @"first_name",
						@"John", @"midle_name",
						@"Lennon", @"last_name",
						@"1 Main Street", @"address_stree1",
						@"San Franscisco", @"address_city",
						@"US", @"address_country_code",
						nil];

			bs.watchlist_candidate_info = new_watchlist_candidate_info;
			[bs requestTypeValue:WATCHLIST_CANDIDATE_NEW];
			[bs sendRequest];
 
 
 		WATCHLIST_CANDIDATE_EDIT:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 NSMutableDictionary *wl_updates	= [[NSMutableDictionary alloc]initWithObjectsAndKeys:
														 @"UPDATED NOTES",@"note",nil];
			 bs.watchlist_candidate_info_updates = wl_updates;
			 bs.watchlist_candidate_id=@"54250a493963660002e20400";
			 [bs requestTypeValue:WATCHLIST_CANDIDATE_EDIT];
			 [bs sendRequest];
			 
 
 
		WATCHLIST_CANDIDATE_LIST:
			 BlockScoreWrapper *bs  = [BlockScoreWrapper sharedInstance];
			 bs.delegate = self;
			 [bs requestTypeValue:WATCHLIST_CANDIDATE_LIST];
			 [bs sendRequest];
 
 
		WATCHLIST_CANDIDATE_HITS:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate=self;
			 bs.watchlist_candidate_id=@"54250a493963660002e20400";
			 [bs requestTypeValue:WATCHLIST_CANDIDATE_HITS];
			 [bs sendRequest];
 
 
		WATCHLIST_CANDIDATE_HISTORY:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate=self;
			 bs.watchlist_candidate_id=@"54250a493963660002e20400";
			 [bs requestTypeValue:WATCHLIST_CANDIDATE_HISTORY];
			 [bs sendRequest];
 
 
		WATCHLIST_SEARCH:
			 BlockScoreWrapper *bs = [BlockScoreWrapper sharedInstance];
			 bs.delegate = (id)self;
			 NSMutableDictionary *criteria = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
													 @"5425c7613130610002700200", @"watchlist_candidate_id",
													 @"person",@"match_type",
													 nil];
			 bs.searchCriteria=criteria;
			 [bs requestTypeValue:WATCHLIST_SEARCH];
			 [bs sendRequest];
 
 
 
 LIMITATIONS:
 It would be nice if entities such as name/person, company and address are all objects.
 However, this is just a quick and dirty implementation as a starter.
 
 Another area for improvements: Validation, however right now we are relying on the
 BlockScore backend to do the validation.
