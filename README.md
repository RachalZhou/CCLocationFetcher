# CCLocationFetcher
Customized location manager for Objective-C

### 说明
对CoreLocation的封装。

将定位相关的代码从 **Controller** 中分离，封装到 **NSObject** 对象中。采用 **block** 回调的方式降低代码的分散度，方便调用亦易于获取位置信息。

### 使用方法
**CCLocationFetcher** 对象调 ***startWithCompletionHandler:*** 方法，返回一个存储定位信息的 **LocationModel** 对象，所需信息直接用点语法获取。以名为location对象为例，包含：
* **location.longitude**   经度
* **location.latitude**   纬度
* **location.province**   省/直辖市
* **location.city**   市
* **location.subCity**   区/县
* **location.street**   街道/路
* **location.address**   详细地址（从省开始到街道）

#### 方法一（推荐）
用单例初始化对象并调用 ***startWithCompletionHandler:*** 方法即可。随用随调。
```
[[CCLocationFetcher sharedInstance] startWithCompletionHandler:^(LocationModel *location) {

NSLog(@"经度:%@--纬度:%@--地址:%@",location.longitude,location.latitude,location.address);
}];
```

#### 方法二
传统初始化一个对象，调 ***startWithCompletionHandler:*** 方法。对象必须是实例变量。
```
_fetcher = [[CCLocationFetcher alloc] init];
[_fetcher startWithCompletionHandler:^(LocationModel *location) {

NSLog(@"经度:%@--纬度:%@--地址:%@",location.longitude,location.latitude,location.address);
}];
```

### 注意
* 定位信息转模型用到了MJExtension，若无可自行导入
* 方法一暂无局限性，随用随调，推荐。
* 方法二需将对象设置为实例变量，存在局限性。
