//
//  ViewController.m
//  LocalNotificationDemo
//
//  Created by pro on 16/5/10.
//  Copyright © 2016年 Goyakod. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSDictionary *_notiDic;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
 
    _notiDic = [[NSDictionary alloc] initWithObjects:@[@"欢迎来到英雄联盟",@"断剑重铸之日骑士归来之时",@"我们的狂怒已驾驭不住"] forKeys:@[@"1",@"2",@"3"]];
}

- (IBAction)sendNotificationButtonPress:(UIButton *)sender {
    
    [self sendNotificationKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];

}

- (void)sendNotificationKey:(NSString *)notiKey
{
    //本地通知
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    //时区
    localNoti.timeZone = [NSTimeZone defaultTimeZone];
    //触发时间
    localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
    //重复间隔
    localNoti.repeatInterval = kCFCalendarUnitSecond;
    //通知内容
    localNoti.alertBody = [_notiDic objectForKey:notiKey];
    //通知声音
    localNoti.soundName = UILocalNotificationDefaultSoundName;
    //通知徽标
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    //通知参数
    localNoti.userInfo = [NSDictionary dictionaryWithObject:[_notiDic objectForKey:notiKey] forKey:notiKey];
    //发送通知:
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
}

- (IBAction)lookupNotificationButtonPress:(UIButton *)sender {
    
    [self cancelLocalNotificationWithKey:[NSString stringWithFormat:@"%ld",sender.tag-100]];
}

- (void)cancelLocalNotificationWithKey:(NSString *)key
{
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                //图标的数字清零
                ([UIApplication sharedApplication].applicationIconBadgeNumber > 1) ?([UIApplication sharedApplication].applicationIconBadgeNumber -= 1):0 ;
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
