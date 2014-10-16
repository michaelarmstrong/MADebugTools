//
//  UIWebView+MADebugTools.m
//  http://github.com/michaelarmstrong
//
//  Created by Michael Armstrong on 16/10/2014.
//  Copyright (c) 2013 Michael Armstrong. All rights reserved.
//
//  Just import this class into your project and add it into your Prefix.pch
//  More features are coming later... I have a day job and a night job... so whenever theres time :)
//  http://mike.kz / @italoarmstrong
//

#import "UIWebView+MADebugTools.h"
#import "MADebugTools.h"

@interface UIWebView()
@end

@implementation UIWebView (MADebugTools)
+ (void)load
{
    Swizzle(self, @selector(awakeFromNib), @selector(override_awakeFromNib));
}

- (void)override_awakeFromNib
{
    // run existing implementation
    [self override_awakeFromNib];
    
    // now run custom code
    
    if([self viewWithTag:100] != nil && [self viewWithTag:101] != nil){
        return;
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    CGFloat consoleTextFieldHeight = 33.0f;
    CGFloat consoleOutputTextViewHeight = (screenHeight * 0.3) > 100 ? (screenHeight * 0.3) : 100;
    
    UITextField *consoleTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, screenWidth, consoleTextFieldHeight)];
    consoleTextField.backgroundColor = [UIColor blackColor];
    consoleTextField.alpha = 0.9f;
    consoleTextField.textColor = [UIColor whiteColor];
   
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 88, consoleTextFieldHeight)];
    promptLabel.text = @" ~> #";
    promptLabel.textColor = [UIColor whiteColor];
    [consoleTextField setLeftViewMode:UITextFieldViewModeAlways];
    [consoleTextField setLeftView:promptLabel];
    
    consoleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter javascript" attributes:@{NSForegroundColorAttributeName: [UIColor lightTextColor]}];
    consoleTextField.font = [UIFont systemFontOfSize:11.0];
    
    UIButton *evalButton = [[UIButton alloc] initWithFrame:CGRectMake(consoleTextField.bounds.size.width-88, 0, 88, consoleTextFieldHeight)];
    
    [evalButton setTitle:@"eval" forState:UIControlStateNormal];
    [evalButton setBackgroundColor:[UIColor redColor]];
    [evalButton addTarget:self action:@selector(evalTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [consoleTextField setRightView:evalButton];
    [consoleTextField setRightViewMode:UITextFieldViewModeWhileEditing];
    
    UITextView *consoleOutputTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, consoleTextField.frame.origin.y+consoleTextField.frame.size.height, screenWidth, consoleOutputTextViewHeight)];
    
    consoleOutputTextView.backgroundColor = [UIColor darkGrayColor];
    consoleOutputTextView.textColor = [UIColor whiteColor];
    consoleOutputTextView.alpha = 0.8f;
    
    consoleTextField.tag = 100;
    consoleOutputTextView.tag = 101;
    consoleOutputTextView.text = @"";
    
    [self addSubview:consoleTextField];
    [self addSubview:consoleOutputTextView];
}

- (void)evalTapped:(id)sender {
    
    UITextView *consoleTextView = (UITextView *)[self viewWithTag:101];
    UITextField *consoleTextField = (UITextField *)[self viewWithTag:100];
    NSString *javascriptString = [NSString stringWithFormat:@"JSON.stringify(%@)",consoleTextField.text];
    
    NSString *output = [self stringByEvaluatingJavaScriptFromString:javascriptString];
    consoleTextView.text = [NSString stringWithFormat:@"%@\n%@",output,consoleTextView.text];
}

@end