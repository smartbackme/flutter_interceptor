## flutter_interceptor
## flutter dio 拦截器

### 开始集成

```dart
dependencies:
  flutter_interceptor: ^0.0.2
```

dio添加拦截器

```dart
_dio.interceptors.add(UiNetInterceptor())
```

页面插入浮动窗体

```dart
Overlay.of(context)?.insert(InterceptorDraggable());
```

本地化

```dart

InterceptorLocalizations.delegate
```

功能介绍：
1、请求可视化
2、可以复制请求内容

集成后的效果如图

![](art/1.jpg)

![](art/2.jpg)

![](art/3.jpg)

![](art/4.jpg)

![](art/5.jpg)

