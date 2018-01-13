//
//  ViewController.m
//  dontugitit-ios
//
//  Created by thomas wheeler 1 on 1/12/18.
//  Copyright © 2018 thomaswheeler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate, ARSessionDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CMMotionManager* motionManager;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set up location manager
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	[self enableLocationServices];
	
	// start motion updates
	self.motionManager = [[CMMotionManager alloc] init];
	[self startMotionUpdates];
	
    // Set the view's delegate
    self.sceneView.delegate = self;
//	self.sceneView.session.delegate = self;
	
    // Show statistics such as fps and timing information
    self.sceneView.showsStatistics = YES;
    
    // Create a new scene
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
	
    // Set the scene to the view
//    self.sceneView.scene = scene;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - NEHostspotConfig

- (void) connect: (NSString *)ssid_name completionHandler: (void(^)(NSError*error)) handler {
	NEHotspotConfiguration *configuration = [[NEHotspotConfiguration alloc] initWithSSID: ssid_name];
	configuration.joinOnce = YES;
	[[NEHotspotConfigurationManager sharedManager] applyConfiguration: configuration completionHandler: handler];
}

#pragma mark - CLLocationManagerDelegate

- (void) enableLocationServices {
	
	switch ([CLLocationManager authorizationStatus]) {
		case kCLAuthorizationStatusAuthorizedWhenInUse:
			// good to go
			NSLog(@"Yas");
			break;
		case kCLAuthorizationStatusNotDetermined:
			[self.locationManager requestWhenInUseAuthorization];
			break;
		default:
			NSLog(@"GPS Data restricted or denied.");
	}
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
	if (status != kCLAuthorizationStatusAuthorizedWhenInUse) {
		NSLog(@"WARNING: Not reading GPS data. Not authorized");
		return;
	}
	[manager startUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
	// manage gps update
	NSLog(@"did update location");
}

#pragma mark - CMMotionManager

- (void) startMotionUpdates {
	if ([self.motionManager isAccelerometerAvailable] == NO)
		return;
	
	ViewController * __weak weakSelf = self;
	
	[self.motionManager setAccelerometerUpdateInterval: 1.0 / 200];
	[self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
			// handle new motion data
			// self.handle it!
		if (error != nil) {
			NSLog(@"%@", [error localizedDescription]);
		}
		NSLog(@"got gyro data");
	}];
}

- (void) stopMotionUpdates {
	if ([self.motionManager isAccelerometerActive] == NO)
		return;
	// shut it!
	[self.motionManager stopGyroUpdates];
}

#pragma mark - ARSessionDelegate

- (void) session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
	
//	NSLog(@" session updated frame ");
//	ARPointCloud* pointCloud = [frame rawFeaturePoints];
//	NSUInteger npoints = pointCloud.count;
//	NSLog(@"%ul", npoints);
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
