//
//  Parser.m
//  myPod
//
//  Created by Denis Dobynda on 31.01.18.
//  Copyright © 2018 Denis Dobynda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import <API/API.h>
#import <API/APIRequest.h>

// http://webhose.io/filterWebContent?token=da6346b9-57af-4a5d-af61-e4693ad3024c&format=json&ts=1517311561250&sort=crawled&q=%@%20is_first%3Atrue
// http://127.0.0.1/load.php?version=%@
// https://newsapi.org/v2/everything?q=%@&sortBy=publishedAt&apiKey=d51f3beed0f743c9901b851be771aaa4


@implementation Parser: NSObject

- (void)getNewsByFetchingQuery:(NSString *)query withNumberOfResults:(NSInteger)count withCompletition:(CompletionBlock)complete{

    NSString *url = [NSString stringWithFormat:@"https://newsapi.org/v2/everything?q=%@&sortBy=publishedAt&apiKey=d51f3beed0f743c9901b851be771aaa4", query];
    NSDictionary *params = [[NSDictionary alloc] init];
    NSDictionary *headers = [[NSDictionary alloc] init];
    APIRequest *request = [[APIRequest alloc] initWithURL:url params:params header:headers];

    [request GET:^(APIResponseObject *response, NSError *error) {
        if (error) {
//            NSLog(@"%@", error.description);
            complete(NULL, error);
        } else {
            NSDictionary *dict = response.successData;
            NSString *status = dict[@"status"];
            if (status != NULL && [status isEqualToString:@"ok"]) {
                NSArray<NSDictionary *> *articles = dict[@"articles"];
                NSInteger availableCount = MIN(count, [articles count]);
                if ( availableCount > 0 ) {
                
                    NSMutableArray<News *> *array = [[NSMutableArray alloc] init];
                    
                    for (int i = 0; i < availableCount; ++i) {
                        News *n = [[News alloc] init];
                        NSDictionary *article = dict[@"articles"][i];
                        n.sourceName = article[@"source"][@"name"];
                        n.author = article[@"author"];
                        n.title = article[@"title"];
                        n.text = article[@"description"];
                        n.url = article[@"url"];
                        n.urlToImage = article[@"urlToImage"];
                        NSString *published = article[@"publishedAt"];
                        NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
                        n.publishedAt = [formatter dateFromString:published];
                        [array addObject:n];
                    }
                    
                    complete(array, NULL);
                } else {
                    complete(NULL, NULL);
                }
            }
            
        }
    }];
    
}

@end

@implementation News: NSObject
- (NSString * )description {
    return [NSString stringWithFormat:@"Source: %@\nAuthor: %@\n\"%@\"\n\t%@", self.sourceName, self.author, self.title, self.text];
}
@end
