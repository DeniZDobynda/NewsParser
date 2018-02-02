//
//  Parser.h
//  myPod
//
//  Created by Denis Dobynda on 31.01.18.
//  Copyright © 2018 Denis Dobynda. All rights reserved.
//

#ifndef Parser_h
#define Parser_h


@interface News: NSObject
@property (nonatomic) NSString * sourceName;
@property (nonatomic) NSString * author;
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * text;
@property (nonatomic) NSString * url;
@property (nonatomic) NSString * urlToImage;
@property (nonatomic) NSDate * publishedAt;
@end

typedef void (^CompletionBlock)(NSArray<News *> *, NSError *);

@interface Parser : NSObject

- (void)getNewsByFetchingQuery:(NSString *)query withNumberOfResults:(NSInteger)count withCompletition:(CompletionBlock)complete;

@end


#endif /* Parser_h */
