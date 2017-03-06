//
//  NSValue+MKMapPoint.m
//  TrumpPunch
//
//  Created by Ryan Coyne on 2/26/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

#import "NSValue+MKMapPoint.h"

@implementation NSValue (MKMapPoint)

+ (NSValue *)valueWithMKMapPoint:(MKMapPoint)mapPoint {
    return [NSValue value:&mapPoint withObjCType:@encode(MKMapPoint)];
}

- (MKMapPoint)MKMapPointValue {
    MKMapPoint mapPoint;
    [self getValue:&mapPoint];
    return mapPoint;
}

@end
