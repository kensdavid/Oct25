//
//  View.m
//  Oct25
//
//  Created by Kenneth David on 10/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View
@synthesize string;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat xAxis =5.0;
    CGFloat myFontSize = 14.0;
    font = [UIFont systemFontOfSize: myFontSize];
    
    CGFloat titleOffset = myFontSize * 1.5;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(c, 0, 0, 0, 1);
    
    string = NSLocalizedString(@"Greeting", @"displayed with drawAtPoint:");
    point = CGPointMake(xAxis, 0.0);
    [string drawAtPoint:point withFont:font];

    NSString *mySymbols = @"AAPL,GOOG,YHOO,MSFT,VZ,GE";
    
    NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat: @"http://finance.yahoo.com/d/quotes.csv?s=%@&f=sl1t1j1",mySymbols]];
    int componentCount = 4; //component count determined by the f value on the query string below
    
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
                
        point = CGPointMake(xAxis, lineHeight * i / componentCount + titleOffset);
        
        string = [NSString stringWithFormat:@"%@: $%@ (%@) at %@",ticker,price, marketCap, time];
        
        [string drawAtPoint:point withFont:font];
    }
    
    UIDevice *device = [UIDevice currentDevice];	//There is only one object of this class.
    
	NSString *model = device.model;		//Is it an iPhone, iPod, or iPad?
	NSString *serial = device.uniqueIdentifier;	//serial number
	NSString *opSys = device.systemName;		//name of operating system, e.g. "iPhone OS"
	NSString *sysVer = device.systemVersion;	//version number of operating system, e.g., "5.0"
    
    NSString *infoString = [[NSString alloc] initWithFormat:
                           @"%@ - %@ %@",model,opSys,sysVer];
    
    // Drawing code
    CGFloat deviceInfoFontSize = 12.0;
    UIFont *deviceInfoFont = [UIFont italicSystemFontOfSize: deviceInfoFontSize];
    CGContextSetRGBFillColor(c, 1, 0, 0, 1);
    
    point = CGPointMake(xAxis, self.bounds.size.height - (deviceInfoFontSize * 1.5) * 2);
    [infoString drawAtPoint: point withFont:deviceInfoFont];
    
    CGPoint point2 = CGPointMake(xAxis, self.bounds.size.height - (deviceInfoFontSize * 1.5) * 1);
    [serial drawAtPoint: point2 withFont:deviceInfoFont];
    
}


@end