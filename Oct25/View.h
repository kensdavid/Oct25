//
//  View.h
//  Oct25
//
//  Created by Kenneth David on 10/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View : UIView {
    NSString *string;
    CGPoint point;
    UIFont *font;
}

@property (nonatomic, copy) NSString *string;

@end
