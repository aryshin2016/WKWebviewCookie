//
//  UKJailbreak.m
//

#import "UKJailbreak.h"
#import <dlfcn.h>
#import <sys/stat.h>

@implementation UKJailbreak

+ (BOOL)isJailbreakDevice {
    
    return [self isCanAccessApplicationsFolder] ||
    [self isCanOpenCydia] ||
    [self isExistsJailBreakToolPath] ||
    [self isDYLDInsertlibraries];
}

+ (BOOL)isCanAccessApplicationsFolder
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]) {
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)isExistsJailBreakToolPath
{
    const char* jailbreakToolPathes[] = {
        
        "/Applications/Cydia.app",
        "/Library/MobileSubstrate/MobileSubstrate.dylib",
        "/bin/bash",
        "/usr/sbin/sshd",
        "/etc/apt"
    };
    
    for (int i=0; i<(sizeof(jailbreakToolPathes)/sizeof(jailbreakToolPathes[0])); i++) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreakToolPathes[i]]]) {
            
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isCanOpenCydia
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)isDYLDInsertlibraries
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    
    if (env) {
        
        return YES;
    }
    
    return NO;
}

@end
