# iOS SDK Bluapp

1) Copiar el directorio sdkbeacons a su proyecto.

2) Incluir los siguientes framework en su proyecto.

   CoreLocation
   CoreBluethool 

   libkontakt-ios-sdk.a   (va dentro del directorio)

3) En el info.plist en la sección “Required background modes” añadir 

App communicates using CoreBluetooth
App shares data using CoreBluetooth
App downloads content from the network
App registers for location updates

4) En appdelegate.h importar el modulo BluappManager, agregando la siguiente linea al inicio del código
	#import "BluappManage.h"

5) En appdelegate.m  sobreescribir sus dos métodos idFinishLaunchingWithOptions y didReceiveLocalNotification
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    bluapp= [BluappManage alloc];
    [bluapp startWithCustomer:@"suCuentaDeveloper@bluapp.cl"]; //Adquiera una cuenta para usar este SDK
    
    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    [bluapp setToken:[oNSUUID UUIDString]];


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSMutableDictionary *r = [[NSMutableDictionary alloc] init];
    
    if ( application.applicationState == UIApplicationStateActive ) {
        [r setObject:@YES forKey:@"show"];
        [r setObject:notification.userInfo forKey:@"userInfo"];
    } else {
        [r setObject:@NO forKey:@"show"];
        [r setObject:notification.userInfo forKey:@"userInfo"];
        [bluapp reciveRemoteNotification:r andshow:FALSE];
    }
}
