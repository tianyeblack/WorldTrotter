//
//  MapViewController.m
//  WorldTrotter
//
//  Created by Ye Tian on 25/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)loadView {
  self.mapView = [MKMapView new];
  self.view = self.mapView;
  
  NSArray *segItems = @[@"Standard", @"Hybrid", @"Satellite"];
  UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:segItems];
  segControl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
  segControl.selectedSegmentIndex = 0;
  
  segControl.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:segControl];
  
  [segControl addTarget:self action:@selector(mapTypeChanged:) forControlEvents:UIControlEventValueChanged];
  
  NSLayoutConstraint *topConstraint = [segControl.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor
                                                                           constant:8.0];
  UILayoutGuide *margins = self.view.layoutMarginsGuide;
  NSLayoutConstraint *leadingConstraint = [segControl.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor];
  NSLayoutConstraint *trailingConstraint = [segControl.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor];
  
  topConstraint.active = YES;
  leadingConstraint.active = YES;
  trailingConstraint.active = YES;
  
  UIButton *compass = [UIButton new];
  compass.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
  compass.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:compass];
  
  [compass addTarget:self action:@selector(compassPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  NSLayoutConstraint *bottomConstraint = [compass.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor
                                                                              constant:-8.0];
  NSLayoutConstraint *trailingButtonConstraint = [compass.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor];
  
  bottomConstraint.active = YES;
  trailingButtonConstraint.active = YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  _mapView.zoomEnabled = YES;
  _mapView.scrollEnabled = YES;
  _mapView.delegate = self;
  
  _locationManager = [CLLocationManager new];
  _locationManager.delegate = self;
  _locationManager.distanceFilter = kCLDistanceFilterNone;
  _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  [_locationManager requestWhenInUseAuthorization];
  [_locationManager startUpdatingLocation];
  
  NSLog(@"MapViewController loaded its view.");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - View

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  return nil;
}

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
  [_mapView setRegion: [_mapView regionThatFits: region] animated: YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Actions
- (void)mapTypeChanged: (UISegmentedControl *)sender {
  switch (sender.selectedSegmentIndex) {
    case 0:
      self.mapView.mapType = MKMapTypeStandard;
      break;
      
    case 1:
      self.mapView.mapType = MKMapTypeHybrid;
      break;
      
    case 2:
      self.mapView.mapType = MKMapTypeSatellite;
      break;
      
    default:
      break;
  }
}

- (void)compassPressed: (UIButton *) sender {
  _mapView.showsUserLocation = !_mapView.showsUserLocation;
  _mapView.userTrackingMode = !_mapView.showsUserLocation ? MKUserTrackingModeNone : MKUserTrackingModeFollow;
  NSLog(@"Tracking set to %s", _mapView.showsUserLocation ? "YES" : "NO");
  NSLog(@"Tracking mode set to %s", _mapView.userTrackingMode == MKUserTrackingModeNone ? "NONE" : "FOLLOW");
  NSLog(@"User location is %s: %@", _mapView.userLocationVisible ? "VISIBLE" : "INVISIBLE", _mapView.userLocation.location);
}

@end
