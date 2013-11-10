//
//  main.m
//  proPorject
//
//  Created by sunyanguo on 13-10-25.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <string.h>
#import <mach-o/loader.h>
#import <mach-o/dyld.h>
#import <mach-o/arch.h>

#import "YGAppDelegate.h"

void printImage(const struct mach_header *header)
{
    uint8_t *header_ptr = (uint8_t*)header;
    typedef struct load_command load_command;
    
    const NXArchInfo *info = NXGetArchInfoFromCpuType(header->cputype, header->cpusubtype);
    
    //Print the architecture ex. armv7
    printf("%s ", info->name);
    
    header_ptr += sizeof(struct mach_header);
    load_command *command = (load_command*)header_ptr;
    
    for(int i = 0; i < header->ncmds > 0; ++i)
    {
        if(command->cmd == LC_UUID)
        {
            struct uuid_command ucmd = *(struct uuid_command*)header_ptr;
            
            CFUUIDRef cuuid = CFUUIDCreateFromUUIDBytes(kCFAllocatorDefault, *((CFUUIDBytes*)ucmd.uuid));
            CFStringRef suuid = CFUUIDCreateString(kCFAllocatorDefault, cuuid);
            CFStringEncoding encoding = CFStringGetFastestEncoding(suuid);
            
            //Print UUID
            printf("<%s> ", CFStringGetCStringPtr(suuid, encoding));
            
            CFRelease(cuuid);
            CFRelease(suuid);
            
            break;
        }
        
        header_ptr += command->cmdsize;
        command = (load_command*)header_ptr;
    }
}

void printBinaryImages()
{
    printf("Binary Images:\n");
    //Get count of all currently loaded DYLD
    uint32_t count = _dyld_image_count();
    
    for(uint32_t i = 0; i < count; i++)
    {
        //Name of image (includes full path)
        const char *dyld = _dyld_get_image_name(i);
        
        //Get name of file
        int slength = strlen(dyld);
        
        int j;
        for(j = slength - 1; j>= 0; --j)
            if(dyld[j] == '/') break;
        
        //strndup only available in iOS 4.3
        char *name = strndup(dyld + ++j, slength - j);
        printf("%s ", name);
        free(name);
        
        const struct mach_header *header = _dyld_get_image_header(i);
        //print address range
        printf("0x%X - ??? ", (uint32_t)header);
        
        printImage(header);
        
        //print file path
        printf("%s\n",  dyld);
    }
    printf("\n");
}


#import <mach-o/ldsyms.h>

NSString *executableUUID()
{
    const uint8_t *command = (const uint8_t *)(&_mh_execute_header + 1);
    for (uint32_t idx = 0; idx < _mh_execute_header.ncmds; ++idx) {
        if (((const struct load_command *)command)->cmd == LC_UUID) {
            command += sizeof(struct load_command);
            return [NSString stringWithFormat:@"%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X",
                    command[0], command[1], command[2], command[3],
                    command[4], command[5],
                    command[6], command[7],
                    command[8], command[9],
                    command[10], command[11], command[12], command[13], command[14], command[15]];
        } else {
            command += ((const struct load_command *)command)->cmdsize;
        }
        
    }
    return nil;
}


int main(int argc, char * argv[])
{
    
    //获取应用 cpu type
    NSLog(@"%@\n\n",executableUUID());
    
    //获取应用 cpu type
    const struct mach_header* header = _dyld_get_image_header(0);
    const NXArchInfo* info = NXGetArchInfoFromCpuType(header->cputype, header->cpusubtype);
    NSString*typeName = [NSString stringWithFormat:@"%s",info->name];
    NSLog(@"%@",typeName);
    NSLog(@"========%@============\n\n",[[UIDevice currentDevice] systemName]);
    ;
    
    @autoreleasepool {
        printBinaryImages();

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([YGAppDelegate class]));
    }
}
