//
//  UIViewController+MADebugTools.m
//  http://github.com/michaelarmstrong
//
//  Created by Michael Armstrong on 17/04/2013.
//  Copyright (c) 2013 Michael Armstrong. All rights reserved.
//
//  Just import this class into your project and add it into your Prefix.pch
//  More features are coming later... I have a day job and a night job... so whenever theres time :)
//  http://mike.kz / @italoarmstrong
//

#import "UIViewController+MADebugTools.h"
#import "MADebugTools.h"

static UIFont *debugLabelFont;
static CGFloat debugLabelFontSize = 12.0f;

// shouldn’t pollute the class’s namespace => static funtion (inline to not declare, and then define with -Wpedantic)
static inline NSString *s_DebugDescriptionForViewController(UIViewController *controller)
{
    NSMutableString *instanceDescription = [NSMutableString stringWithUTF8String:class_getName ([controller class])];
    if([controller.nibName length] > 0) {
        [instanceDescription appendString:@" (NIB: "];
        [instanceDescription appendString:controller.nibName];

        NSString *storyboardDescription = [controller.storyboard description];
        if([storyboardDescription length] > 0) {
            [instanceDescription appendString:@", Storyboard: "];
            [instanceDescription appendString:storyboardDescription];
        }

        [instanceDescription appendString:@")"];
    }

    return [instanceDescription copy];
    return @"";
}

@implementation UIViewController (MADebugTools)

+ (void)load
{
    Swizzle(self, @selector(viewDidLoad), @selector(override_viewDidLoad));
}

- (void)override_viewDidLoad
{
    // run existing implementation
    [self override_viewDidLoad];
    
#ifndef MA_DEBUG_TOOLS_DISABLE_VIEW_DEBUG
    // now run custom code
    UILabel *debugLabel = [[UILabel alloc] init];
    debugLabel.text = s_DebugDescriptionForViewController(self);
    if(!debugLabelFont){
        debugLabelFont = [UIFont systemFontOfSize:debugLabelFontSize];
    }
    [debugLabel setFont:debugLabelFont];
    [debugLabel sizeToFit];
    [self.view addSubview:debugLabel];
#endif
}


@end
