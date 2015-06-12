//
//  ViewController.m
//  ArchiverAndFMDB
//
//  Created by Dee on 15/6/12.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "DeeShop.h"
#import "FMDB.h"
@interface ViewController ()

@property(nonatomic,strong)FMDatabase *db;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * path =[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"shops.data"];
   self.db = [FMDatabase databaseWithPath:path];
       [self.db open];
    
    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, shop blob NOT NULL);"];
    
    [self addShop];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self readShops];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)readShops
{
//    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *aPath =[path stringByAppendingPathComponent:@"dee.data"];
//    NSMutableArray *shops =[NSKeyedUnarchiver unarchiveObjectWithFile:aPath];
//    
//    NSLog(@"%@",[shops subarrayWithRange:NSMakeRange(20, 10)]);
    FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_shop;"];
    while (set.next) {
        
      NSData *data = [set objectForColumnName:@"shop"]
        ;
       DeeShop *shop = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"%@",shop);
        
    }
    
    
}

-(void)addShop{
//    
//    NSMutableArray *shops =[NSMutableArray array];
//    for (int i = 0 ; i<100; i++) {
//        DeeShop *shop = [[DeeShop alloc]init];
//        shop.name = [NSString stringWithFormat:@"com--%d",i];
//        shop.price = arc4random() % 10000;
//        [shops addObject:shop];
//    }
//    
//    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *aPath =[path stringByAppendingPathComponent:@"dee.data"];
//    
//    [NSKeyedArchiver archiveRootObject:shops toFile:aPath];

        for (int i = 0 ; i<100; i++) {
            DeeShop *shop = [[DeeShop alloc]init];
            
            shop.name = [NSString stringWithFormat:@"-%d",i];
            shop.price = arc4random() % 10000;
           
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shop];
          
            [self.db executeUpdateWithFormat:@"insert into t_shop(shop) values (%@);",data];
            
        }
    
    
}

@end
