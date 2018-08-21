//
// NSObject+YKSafeSelector.m
// Copyright (c) 2014 Yurii Kolesnykov, Oksana Kovalchuk
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

#import "NSObject+YKSafeSelector.h"

@implementation NSObject (YKSafeSelector)

- (void)safeSelector:(SEL)selector, ...
{
    if (![self respondsToSelector:selector])
        return;
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
    [inv setSelector:selector];
    [inv setTarget:self];
    
    
    va_list argumentList;
    if (selector) {
        va_start(argumentList, (SEL)selector);
        NSInteger idx = 2;
        id eachObject = nil;
        while ((eachObject = va_arg(argumentList, id))){
            [inv setArgument:(__bridge void *)(eachObject) atIndex:idx];
            idx++;
            
        }
        va_end(argumentList);
    }
    [inv invoke];
}


@end
