//
//  View.m
//  Oct25
//
//  Created by Kenneth David on 10/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat myFontSize = 14.0;
    UIFont *font = [UIFont systemFontOfSize: myFontSize];
    
    int componentCount = 4; //component count determined by the f value on the query string below
    
    NSString *mySymbols = @"AAPL,GOOG,YHOO,MSFT";
    NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat: @"http://finance.yahoo.com/d/quotes.csv?s=%@&f=sl1t1j1",mySymbols]];
    NSError *error;
    NSString *priceList = [[NSString alloc] 
                           initWithContentsOfURL:url 
                           encoding:NSUTF8StringEncoding 
                           error:&error];
    
    if (priceList == nil) {
        priceList = [error localizedDescription];
    }
    //NSArray *stockPrices = [priceList componentsSeparatedByString:@"\n"];
    NSArray *stockPrices = [priceList componentsSeparatedByCharactersInSet:
                            [NSCharacterSet characterSetWithCharactersInString:@"\n,"]];
    
    int lineHeight = myFontSize * 1.5;
    
    for (int i = 0; i<[stockPrices count]-1; i=i+componentCount) {
        NSString *marketCap = [stockPrices objectAtIndex:i+3];
        NSString *time = [stockPrices objectAtIndex:i+2];
        time = [time stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString *price = [stockPrices objectAtIndex:i+1];
        NSString *ticker = [stockPrices objectAtIndex:i];
        ticker = [ticker stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        CGPoint point = CGPointMake(0.0, lineHeight * i / componentCount);
        NSString *string = [NSString stringWithFormat:@"%@: $%@ (%@) at %@",ticker,price, marketCap, time];
        [string drawAtPoint:point withFont:font];
    }
}


@end