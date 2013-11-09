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


int main(int argc, char * argv[])
{
    @autoreleasepool {
        printBinaryImages();

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([YGAppDelegate class]));
    }
}
