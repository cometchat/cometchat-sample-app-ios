//
//  ExceptionWrapper.h
//  Chat.WebSync4
//
//  Created by Frozen Mountain Software on 2016-10-25.
//  Copyright © 2016 Frozen Mountain Software. All rights reserved.
//

#ifndef ExceptionWrapper_h
#define ExceptionWrapper_h

@interface  ExceptionWrapper: NSObject

+ (BOOL)catchException:(void(^)())tryBlock error:(__autoreleasing NSError **)error;
@end


#endif /* ExceptionWrapper_h */
