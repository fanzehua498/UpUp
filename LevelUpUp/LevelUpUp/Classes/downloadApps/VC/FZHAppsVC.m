//
//  FZHAppsVC.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/7/25.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

#import "FZHAppsVC.h"

#import <objc/message.h>

@interface FZHAppsVC ()
@property (nonatomic, strong) NSMutableArray  *appArrs;
@property (nonatomic, strong) NSMutableArray  *nameArrs;
@end

@implementation FZHAppsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getAll];
//    object_setIvar(<#id obj#>, <#Ivar ivar#>, <#id value#>)
    Class LSApplicationWorkspace = objc_getClass("LSApplicationWorkspace");
    for (LSApplicationWorkspace  in self.appArrs) {
        //这里可以查看一些信息
        NSString *bundleID = [LSApplicationWorkspace performSelector:@selector(applicationIdentifier)];
        NSString *version =  [LSApplicationWorkspace performSelector:@selector(bundleVersion)];
        NSString *shortVersionString =  [LSApplicationWorkspace performSelector:@selector(shortVersionString)];

        for (int i = 0; i <self.nameArrs.count; i ++) {


            if (![self.nameArrs[i] isEqualToString:@"bundleModTime"] && ![self.nameArrs[i] isEqualToString:@"isInstalled"] && ![self.nameArrs[i] isEqualToString:@"removedSystemApp"]&&![self.nameArrs[i] isEqualToString:@"whitelisted"]&&![self.nameArrs[i] isEqualToString:@"removeableSystemApp"]) {
                SEL nnnn = NSSelectorFromString(self.nameArrs[i]);
                NSLog(@" %@ nnn---%@",self.nameArrs[i],[LSApplicationWorkspace performSelector:nnnn]);
            }

//            NSLog(@"%@",[LSApplicationWorkspace performSelector:@selector(shortVersionString)]);
        }


        //        NSLog(@"bundleID：%@\n version： %@\n ,shortVersionString:%@\n aprivateDocumentIconNames:%@ \n", bundleID,version,shortVersionString,ar);
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.appArrs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
//    Class LSApplicationWorkspace = objc_getClass("LSApplicationWorkspace");
//    for (LSApplicationWorkspace  in self.appArrs) {
//        //这里可以查看一些信息
//        NSString *bundleID = [LSApplicationWorkspace performSelector:@selector(applicationIdentifier)];
//        NSString *version =  [LSApplicationWorkspace performSelector:@selector(bundleVersion)];
//        NSString *shortVersionString =  [LSApplicationWorkspace performSelector:@selector(shortVersionString)];
//
//        if (![self.nameArrs[indexPath.row] isEqualToString:@"bundleModTime"]) {
//            SEL nnnn = NSSelectorFromString(self.nameArrs[indexPath.row]);
//            NSLog(@"nnn---%@",[LSApplicationWorkspace performSelector:nnnn]);
//        }
//
//        NSLog(@"%@",[LSApplicationWorkspace performSelector:@selector(shortVersionString)]);
////        NSLog(@"bundleID：%@\n version： %@\n ,shortVersionString:%@\n aprivateDocumentIconNames:%@ \n", bundleID,version,shortVersionString,ar);
//    }

    cell.textLabel.text = [self.appArrs[indexPath.row] performSelector:@selector(applicationIdentifier)];
    cell.detailTextLabel.text = [self.appArrs[indexPath.row] performSelector:@selector(vendorName)];

    return cell;
}


- (void)getAll{

    NSMutableArray *selArr = [NSMutableArray array];
    Class fzhLSApplicationProxy = objc_getClass("LSApplicationProxy");
    //    //属性
    unsigned int outCount = 0;
    objc_property_t *pros = class_copyPropertyList(fzhLSApplicationProxy, &outCount);
    //    NSLog(@"%d",outCount);
    for (int j = 0; j<outCount; j++) {
        objc_property_t p = pros[j];
        const char *proName = property_getName(p);
        NSString *ocName = [NSString stringWithUTF8String:proName];
        //        NSLog(@"ocName:%@-%d",ocName,outCount);
        //        @selector(<#selector#>)
        //        Method method = methods[k];

//        SEL name = NSSelectorFromString(ocName);
        [selArr addObject:ocName];

    }
    [self.nameArrs addObjectsFromArray:selArr];
    free(pros);



    Class LSApplicationWorkspace = objc_getClass("LSApplicationWorkspace");
    NSObject *workspace = [LSApplicationWorkspace performSelector:@selector(defaultWorkspace)];
    NSArray *allApps = [workspace performSelector:@selector(allApplications)];
//    NSLog(@"%@",allApps);
    [self.appArrs addObjectsFromArray:allApps];



    for (LSApplicationWorkspace  in allApps) {
        //这里可以查看一些信息
//        for (int i = 0; i < selArr.count; i ++) {
//            SEL se = NSSelectorFromString(selArr[0]);
//
////            NSLog(@"aaa:%@",selArr[i]);
//        }
//        NSString *bundleID = [LSApplicationWorkspace performSelector:@selector(applicationIdentifier)];
//        NSString *version =  [LSApplicationWorkspace performSelector:@selector(bundleVersion)];
//        NSString *shortVersionString =  [LSApplicationWorkspace performSelector:@selector(shortVersionString)];

//        NSLog(@"bundleID：%@\n version： %@\n ,shortVersionString:%@\n", bundleID,version,shortVersionString);

           }




//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([fzhLSApplicationProxy class], &count);
//
//    for (int i = 0; i < count; i ++) {
//
//        Ivar ivar = ivars[i];
//        const char *name1 = ivar_getName(ivar);
//        const char *type = ivar_getTypeEncoding(ivar);
//        NSString *typeOc = [NSString stringWithUTF8String:type];
//        NSString *key = [NSString stringWithUTF8String:name1];
////        if (![fzhLSApplicationProxy valueForUndefinedKey:key]) {
////            NSString *nameValue = [fzhLSApplicationProxy valueForKey:key];
////            NSLog(@"%@",nameValue);
////        }
////        if ([key isEqualToString:@"_deviceIdentifierVendorName"]) {
//////            NSString *nameValue = [fzhLSApplicationProxy valueForKey:key];
//////                        NSLog(@"%@",nameValue);
//////            id nameValue = object_getIvar(fzhLSApplicationProxy, ivar);
//////            NSLog(@"%@",nameValue);
////        }
////        NSString *nameValue = [fzhLSApplicationProxy valueForUndefinedKey:key];
////        [LSApplicationWorkspace performSelector:@selector(key)];
//        SEL name = NSSelectorFromString(key);
//        NSLog(@"value:%@",[LSApplicationWorkspace performSelector:name]);
//        NSLog(@"%@--%@--%d",typeOc,key,count);
//    }
//


}
/**
 *@"NSString"--_deviceIdentifierVendorName--
 @"NSArray"--_pluginUUIDs--
 @"NSNumber"--_versionID--
 B--_userInitiatedUninstall--
 i--_bundleModTime--
@"NSArray"--_plugInKitPlugins--
 @"NSString"--_companionApplicationIdentifier--
@"NSDate"--_registeredDate--
@"NSNumber"--_itemID--
 @"NSString"--_vendorName--
@"NSString"--_itemName--
 @"NSString"--_genre--
@"NSNumber"--_genreID--
@"NSString"--_minimumSystemVersion--
@"NSString"--_sdkVersion--
@"NSString"--_shortVersionString--
 @"NSString"--_preferredArchitecture--
 @"_LSDiskUsage"--_diskUsage--
@"_LSApplicationState"--_appState--
 @"NSNumber"--_purchaserDSID--
 @"NSNumber"--_downloaderDSID--
@"NSNumber"--_familyID--
 Q--_installType--
 Q--_originalInstallType--
 @"NSArray"--_deviceFamily--
 @"NSArray"--_activityTypes--
 @"NSString"--_teamID--
 @"NSNumber"--_storeFront--
 @"NSNumber"--_ratingRank--
 @"NSString"--_ratingLabel--
@"NSString"--_sourceAppIdentifier--
@"NSString"--_applicationVariant--
  @"NSString"--_watchKitVersion--
 @"NSString"--_complicationPrincipalClass--
 @"NSArray"--_supportedComplicationFamilies--
 @"NSArray"--_privateDocumentIconNames--
 @"LSApplicationProxy"--_privateDocumentTypeOwner--

 *
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSMutableArray *)appArrs
{
    if (!_appArrs) {
        _appArrs = [NSMutableArray array];
    }
    return _appArrs;
}
-(NSMutableArray *)nameArrs
{
    if (!_nameArrs) {
        _nameArrs = [NSMutableArray array];
    }
    return _nameArrs;
}
@end
