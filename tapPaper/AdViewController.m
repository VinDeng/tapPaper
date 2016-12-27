//
//  adViewController.m
//  tapPaper
//
//  Created by Vincent_D on 16/1/25.
//  Copyright © 2016年 Vincent_D. All rights reserved.
//

#import "AdViewController.h"
#import "adView.h"
#import "tapPaperBeginViewController.h"


#define pageSize 20

@interface AdViewController ()

@property NSMutableArray *jokes;
@property NSMutableArray *moreJokes;
@property NSString *myId;
@property NSInteger page;
@property NSInteger index;
@property bool isConnected;

@end

@implementation AdViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.jokes = [[NSMutableArray alloc] init];
        self.moreJokes = [[NSMutableArray alloc] init];
        self.myId = @"http://japi.juhe.cn/joke/content/text.from?&pagesize=20&key=21253a35e56a38ed033e105cc660471a&page=";
        self.page = 1;
        self.index = 0;
        self.isConnected = NO;
        
        self.view = [[AdView alloc] initWithFrame:[UIScreen mainScreen].bounds andDelegate:self];
        
    }
    return self;
}

- (void)viewDidLoad {  
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [JOYConnect getConnect:@"5696897932d0728c7a02d21cf4206dd2" pid:@"appstore" userID:@"VincentD"];
    [JOYConnect sharedJOYConnect].delegate=self;
    
    [(AdView *)self.view addSprite];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showJoke
{
    if (!self.isConnected) {
        [JOYConnect getConnect:@"5696897932d0728c7a02d21cf4206dd2" pid:@"appstore" userID:@"VincentD"];
        [JOYConnect sharedJOYConnect].delegate=self;
    }
    
    if (self.isConnected) {
        [self addBanner];
    }
    
    if (self.jokes.count && (self.index < pageSize)) {
        [((AdView*)self.view) showJoke:self.jokes[self.index]];
        
        if (self.index == 10) {  //是时候看广告了
            
            if (self.isConnected) {
                [JOYConnect showPop:self];
            }
        }
        
        if (self.index == 17) {  //看到一半
            [self requestMoreJoke];
        }
        
        if (self.index == 19) {  //看完了
            
            if (self.isConnected) {
                [JOYConnect showPop:self];
            }
            
            self.jokes = [NSMutableArray arrayWithArray:self.moreJokes];
            [self.moreJokes removeAllObjects];
            self.index = 0;
        }
        
        
        
        self.index += 1;
        
    }else{
        
        [self requestJoke];
         [((AdView*)self.view) showJoke:@"正在苦思冥想冷笑话中..请有空就摸摸我鼓励一下(人家要上网的说)"];
    }
}

- (void)requestJoke
{
    NSString *urlString = [self.myId stringByAppendingString:[NSString stringWithFormat:@"%ld",self.page]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [self updateJoke:(NSData *)data inArray:self.jokes];
    }];
}



- (void)requestMoreJoke
{
    NSString *urlString = [self.myId stringByAppendingString:[NSString stringWithFormat:@"%ld",self.page]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [self updateJoke:(NSData *)data inArray:self.moreJokes];
    }];
}

- (void)updateJoke:(NSData *)data inArray:(NSMutableArray *)jokes
{
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dic[@"result"]) {
//        NSLog(@"error_code = %@",dic[@"error_code"]);
            NSInteger error_code =[((NSNumber *)dic[@"error_code"]) integerValue];
            if (error_code == 0) {
                for (NSDictionary *contents in dic[@"result"][@"data"]) {
                    [jokes addObject:contents[@"content"]];
                    self.page += 1;
                }
            }
        }
}

}
- (void)onConnectSuccess
{
    self.isConnected = YES;
}

- (void)addBanner
{
    if (self.isConnected) {
    [JOYConnect showBan:self adSize:E_SIZE_480X75 showX:0 showY:50];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
