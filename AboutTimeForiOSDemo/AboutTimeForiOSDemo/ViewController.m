//
//  ViewController.m
//  AboutTimeForiOSDemo
//
//  Created by JXT on 2018/1/25.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "ViewController.h"

@import Darwin.POSIX.sys.time;
@import Darwin.Mach.mach_time;
#include <sys/sysctl.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  [iOS关于时间的处理](http://blog.csdn.net/u011619283/article/details/53689076)
     */
    
    
    
    /**
     *  1.NSDate
        以UTC为标准的，2001年一月一日00：00：00这一刻的时间绝对值。
        NSDate是受手机系统时间控制的。也就是说，当你修改了手机上的时间显示，NSDate获取当前时间的输出也会随之改变。在我们做App的时候，明白这一点，就知道NSDate并不可靠，因为用户可能会修改它的值。
     */
    NSDate *date = [NSDate date];
    //The interval between the date object and 00:00:00 UTC on 1 January 2001.
    NSLog(@"1.current date interval: %f", [date timeIntervalSinceReferenceDate]);
    NSLog(@"1.years since reference date: %lf", [date timeIntervalSinceReferenceDate]/86400.0/365.0);
    NSLog(@"1.current date: %@", date);
    
    
    
    /**
     *  2.CFAbsoluteTimeGetCurrent()
        以GMT为标准的，2001年1月1日00：00：00这一刻的时间绝对值。
        同样CFAbsoluteTimeGetCurrent()也会跟着当前设备的系统时间一起变化，也可能会被用户修改。
     */
    NSLog(@"2.CFAbsoluteTimeGetCurrent: %lf", CFAbsoluteTimeGetCurrent());
    NSLog(@"2.years since reference date: %lf", CFAbsoluteTimeGetCurrent()/86400.0/365.0);

    
    
    /**
     *  3.gettimeofday
        Unix time是以UTC 1970年1月1号 00：00：00为基准时间，当前时间距离基准点偏移的秒数。上述API返回的值是1481266031，表示当前时间距离UTC 1970年1月1号 00：00：00一共过了1481266031秒。
        gettimeofday和NSDate，CFAbsoluteTimeGetCurrent()一样，都是受当前设备的系统时间影响。只不过是参考的时间基准点不一样而已。我们和服务器通讯的时候一般使用Unix time。
     */
    struct timeval now;
    struct timezone tz;
    gettimeofday(&now, &tz);
    NSLog(@"3.gettimeofday: %ld", now.tv_sec);
    NSLog(@"3.years since 1970: %lf", now.tv_sec/86400.0/365.0);
    NSLog(@"3.timeIntervalSince1970: %f", [date timeIntervalSince1970]);
    
    
    
    /**
     *  4.mach_absolute_time()
        CPU的时钟周期数（ticks）。这个tick的数值可以用来描述时间，而mach_absolute_time()返回的就是CPU已经运行的tick的数量。将这个tick数经过一定的转换就可以变成秒数，或者纳秒数，这样就和时间直接关联了。
        不过这个tick数，在每次手机重启之后，会重新开始计数，而且iPhone锁屏进入休眠之后tick也会暂停计数。
        mach_absolute_time()不会受系统时间影响，只受设备重启和休眠行为影响。
     */
    NSLog(@"4.mach_absolute_time: %lld", mach_absolute_time());
    
    
    
    /**
     *  5.CACurrentMediaTime()
        CACurrentMediaTime()就是将上面mach_absolute_time()的CPU tick数转化成秒数的结果。
        不会受系统时间影响，只受设备重启和休眠行为影响。
     */
    double mediaTime = CACurrentMediaTime();
    //开机后设备一共运行了(设备休眠不统计在内)多少秒
    NSLog(@"5.CACurrentMediaTime: %lf", mediaTime);
    
    NSTimeInterval systemUptime = [[NSProcessInfo processInfo] systemUptime];
    NSLog(@"5.systemUptime: %f", systemUptime);
    
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"5.CACurrentMediaTime: %lf", CACurrentMediaTime());
//    }];
    
    
    
    /**
     *  6.sysctl
        iOS系统还记录了上次设备重启的时间。
        这个API返回的值也会受系统时间影响，用户如果修改时间，值也会随着变化。
     */
    //返回的值是上次设备重启的Unix time
    NSLog(@"6.sysctl: %ld", [self bootTime]);
    
    
    
    /**
     *  7.gettimeofday和sysctl都会受系统时间影响，但他们二者做一个减法所得的值，就和系统时间无关了。这样就可以避免用户修改时间了。当然用户如果关机，过段时间再开机，会导致我们获取到的时间慢与服务器时间，真实场景中，慢于服务器时间往往影响较小，我们一般担心的是客户端时间快于服务器时间。
     */
    NSLog(@"7.%lf", [self uptime]);
    NSLog(@"7.%lf", [self uptime]/86400.0);
    
    
    
    /**
     *  8.CFAbsoluteTimeGetCurrent()深入 http://blog.sina.com.cn/s/blog_611b9d9d01015cfo.html
     */
    //1.这个返回的是CFTimeInterval类型，这个是timeInterval是针对于2001-01-01 00:00:00 GMT的时间。
    CFAbsoluteTime nowTime = CFAbsoluteTimeGetCurrent();
    
    //2.计算两个时间间隔
    CFTimeZoneRef timeZone = CFTimeZoneCopySystem();
    
//    CFCalendarUnit
    CFGregorianUnits startUnits = {-11, -5, 1, 0, 0, 0};
//    结构体，表示和任何一个时间的间隔
//    struct CFGregorianUnits {
//        SInt32 years;
//        SInt32 months;
//        SInt32 days;
//        SInt32 hours;
//        SInt32 minutes;
//        double seconds;
//    };
    
    CFAbsoluteTime nowAdd = CFAbsoluteTimeAddGregorianUnits(nowTime, timeZone, startUnits);
    CFGregorianUnits units = CFAbsoluteTimeGetDifferenceAsGregorianUnits
    (nowTime, nowAdd, NULL, (kCFGregorianUnitsHours | kCFGregorianUnitsMinutes));
    CFStringRef output = CFStringCreateWithFormat(NULL, 0, CFSTR("hours: %d; minutes: %d"), units.hours, units.minutes);
    CFShow(output);
    
    //3.表示这个时间是一个星期中的第几天
    int weekofday = CFAbsoluteTimeGetDayOfWeek(nowTime, CFTimeZoneCopySystem());
    NSLog(@"day:%d", weekofday);
    //4.表示这个时间是一年中的第几天
    NSInteger yearOfDay = CFAbsoluteTimeGetDayOfYear(nowTime, CFTimeZoneCopySystem());
    
}


- (long)bootTime
{
#define MIB_SIZE 2
    int mib[MIB_SIZE];
    size_t size;
    struct timeval boottime;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    size = sizeof(boottime);
    if (sysctl(mib, MIB_SIZE, &boottime, &size, NULL, 0) != -1)
    {
        return boottime.tv_sec;
    }
    return 0;
}


//get system uptime since last boot
- (NSTimeInterval)uptime
{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    struct timeval now;
    struct timezone tz;
    gettimeofday(&now, &tz);
    double uptime = -1;
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
    {
        uptime = now.tv_sec - boottime.tv_sec;
        uptime += (double)(now.tv_usec - boottime.tv_usec) / 1000000.0;
    }
    return uptime;
}

@end
