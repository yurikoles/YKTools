//
// YKProgressView.m
// Copyright (c) 2014 Yurii Kolesnykov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "YKProgressView.h"

static YKProgressView* sharedInstance = nil;

@interface YKProgressView ()

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@end

@implementation YKProgressView

+ (YKProgressView *)sharedInstance {
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
		sharedInstance = [self new];
        sharedInstance.frame = [UIScreen mainScreen].bounds;
        sharedInstance.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        sharedInstance.activityIndicator.center = sharedInstance.center;
        sharedInstance.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.f];
        sharedInstance.activityIndicator.color = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [sharedInstance addSubview:sharedInstance.activityIndicator];
    });
    return sharedInstance;
}

+ (void)show
{
	dispatch_async(dispatch_get_main_queue(), ^{
		YKProgressView* instance = [YKProgressView sharedInstance];
		[[[UIApplication sharedApplication] keyWindow] addSubview:instance];
		[instance.activityIndicator startAnimating];
	});
}

+ (void)hide
{
	dispatch_async(dispatch_get_main_queue(), ^{
		YKProgressView* instance = [YKProgressView sharedInstance];
		[instance removeFromSuperview];
		[instance.activityIndicator stopAnimating];
	});
}

- (void)showInView:(UIView *)parent
{
    [parent addSubview:self];
    [self.activityIndicator startAnimating];
}

- (void)hide
{
	[self removeFromSuperview];
    [self.activityIndicator stopAnimating];
}

@end
