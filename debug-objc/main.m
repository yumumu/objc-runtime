//
//  main.m
//  debug-objc
//
//  Created by Closure on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import "NSObject+DLIntrospection.h"

#import "Student.h"

//
//struct NSObject_IMPL {
//    Class isa;
//};
//
//
//struct Student_IMPL {
//    struct NSObject_IMPL NSObject_IVARS;
//    int _ageeeeee;
//    int _noooooo;
//};

struct Student_IMPL {
    Class isa;
    int _ageeeeee;
    int _noooooo;
};
// 总结
// 内存对齐：结构体的大小必须是最大成员大小的倍数

// 一个 NSOjbect 对象占用多少内存

void objectInfo() {
    NSObject *obj = [NSObject new];
    size_t size1 = class_getInstanceSize([NSObject class]); // 实例对象所占内存大小
    size_t size2 = malloc_size((__bridge const void*)obj);  // 获得obj指针所指向内存的大小
    
    NSLog(@"NSObject class_getInstanceSize: %zu", size1);
    NSLog(@"NSObject malloc_size: %zu", size2);
    
    Student *student = [Student new];
    student->_noooooo = 3;
    student->_ageeeeee = 5;
    size_t size3 = class_getInstanceSize([Student class]);
    size_t size4 = malloc_size((__bridge const void*)student);
    NSLog(@"Student class_getInstanceSize: %zu", size3);
    NSLog(@"Student malloc_size: %zu", size4);
    NSLog(@"sizeof(int) is %zu", sizeof(int));
    
    struct Student_IMPL *stuImpl = (__bridge struct Student_IMPL *)student;
    NSLog(@"no is %d, age is %d", stuImpl->_noooooo, stuImpl->_ageeeeee);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        objectInfo();
        
        
//        NSLog(@"Hello, World! %@", [NSString class]);
    }
    return 0;
}
