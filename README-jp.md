## flutter_interceptor
## flutter dio 迎撃器

### 始める

```dart
dependencies:
  flutter_interceptor: ^0.0.1
```

dio 迎撃器を追加

```dart
_dio.interceptors.add(UiNetInterceptor())
```

ページに浮動フォームを挿入します。

```dart
Overlay.of(context)?.insert(InterceptorDraggable());
```

機能紹介：

1、可視化を要求する

2、要求内容をコピーできます。

統合後の効果は図のようです。

![](art/1.jpg)

![](art/2.jpg)

![](art/3.jpg)

![](art/4.jpg)

![](art/5.jpg)

