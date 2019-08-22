//
//  NSDictionary+GetValue.h
//  DictionaryCategory
//
//  Created by 丁强 on 2019/8/21.
//  Copyright © 2019 丁强. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (GetValue)
- (id)getValueWithProperty:(NSString *)property;
@end

NS_ASSUME_NONNULL_END
