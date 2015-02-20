//
//  Deck.h
//  Stacked
//
//  Created by Stephen Sherwood on 2/19/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
