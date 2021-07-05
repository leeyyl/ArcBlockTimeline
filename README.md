# ArcBlockTimeline
展示多种信息类型列表和详情

## 运行环境

* macOS Big Sur 11.4
* Swift 5.3.2
* Xcode 12.4

## 第三方库

> 使用`Cocoapods 1.10.0`管理第三方库，正式项目需要运行`pod instal`来安装所有的第三方库。
>
> 这里出于演示的目的将`Pods`文件夹上传到仓库，所以可以省略`pod install`步骤。

1. RxSwift，RxCocoa，RxDataSource 支持函数响应式编程
2. SnapKit 链式语法，代码实现界面自动布局
3. Kingfisher 自带异步加载，图片缓存等功能的图片处理
4. ObjectMapper 模型对象和JSON字符串映射
5. JXPhotoBrowser 带有动效的图片浏览器
6. UIColor_Hex_Swift 颜色16进制Swift扩展

## 下载运行

~~~shell
git clone https://github.com/leeyyl/ArcBlockTimeline.git
cd ArcBlockTimeline
open ArcBlockTimeline
~~~

在Xcode中选择模拟器，并使用快捷键`CMD+R`运行项目。

## 项目结构

> 本项目纯Swift编写，采用`MVVM`架构
>
> 没有使用UIStoryboard，而是纯手工代码编写界面

* Common

  存放全局共用的一些东西，比如模型基类，可复用的UI组件，枚举，以及宏定义等。

* Extension

  Swift标准库类型的扩展

* Module

  项目所有的业务模块，每个模块都按照`MVVM`架构进行组织管理，为以后组件化做好准备。

* Resource

  存放普通文件，音频，视频或者其它一些资源。

* Services

  提供服务的一些类，比如网络请求，数据转化等。

## 友情提醒

列表展示纯文本类型，会根据纯文本大小自动调整高度，也就是说纯文本在列表始终可以显示完整，所以点击不需要进入详情页。
