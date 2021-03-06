//
//  ShowReportRequest.m
//  Watermeters
//
//  Created by Radu Cojocaru on 12Feb//09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ShowReportRequest.h"
#import "Report.h"
#import "RestfulObject.h"

@implementation ShowReportRequest

@synthesize reportId, locationId;

- (id)initWithReport:(NSInteger)report_id location:(NSInteger)location_id {
	if (self = [super init]) {
		self.reportId = report_id;
		self.locationId = location_id;
	}
	return self;
}

- (void)generateUrlString {
	[self.urlString setString:[NSString stringWithFormat:@"%@/locations/%d/reports/%d.xml", WEBSERVICE_HOSTNAME, self.locationId, self.reportId]];
}

- (NSArray *)parseDictionary:(NSDictionary *)dictionary {
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	NSDictionary *reportDict = [dictionary objectForKey:@"report"];
	Report *report = [Report reportFromDictionary:reportDict];

	NSArray *reads = [reportDict objectForKey:@"reads"];
	NSDictionary *readDict;
	for (readDict in reads) {
		Read *read = [Read readFromDictionary:readDict];
		[report addRead:read];
	}

	[results addObject:report];
	[report release];
	
	return results;
}

@end
