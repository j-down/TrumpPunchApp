//
//  NSValue+MKMapPoint.h
//  TrumpPunch
//
//  Created by Ryan Coyne on 2/26/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface NSValue (MKMapPoint)

+ (NSValue *)valueWithMKMapPoint:(MKMapPoint)mapPoint;
- (MKMapPoint)MKMapPointValue;

@end
