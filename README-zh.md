## flutter_interceptor
## flutter dio 拦截器

库源码：https://github.com/smartbackme/flutter_interceptor

### 开始集成

```bash
dependencies:
  flutter_interceptor: ^0.0.1
```

dio添加拦截器

```bash
_dio.interceptors.add(UiNetInterceptor())
```

页面插入浮动窗体

```bash
Overlay.of(context)?.insert(InterceptorDraggable());
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

