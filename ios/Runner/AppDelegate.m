#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"AIzaSyCoPnIZX3O-DS4nc8LFzRS3nIJoT2yDm74"];
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
          if (@available(iOS 10.0, *)) {
            [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
          }
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
