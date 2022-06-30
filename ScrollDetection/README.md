# ScrollDetection App
## 앱 이미지
![X - 2](https://user-images.githubusercontent.com/68142821/176578022-b5b15659-b688-4998-96f1-5a9a65f11230.png)

## 프로젝트 배경 / 목표
- PreferenceKey의 사용, onPreferenceChange의 동작 방식을 알아본다.
- proxy.frame 내의 .named와 coordinateSpace를 활용하여 좌표찾는 방식을 알아본다.
- Color.clear.preference가 무엇인지 알아본다.
- mask가 무엇인지 알아본다.
- overlay, background의 차이를 알아본다.
- ViewModifier, ViewBuilder을 알아본다.
- CGSize와 CGRect의 차이를 알아본다.

## 동작 방식
### Model : letter
- letter에 대한 기초적인 정보를 갖고 있음

### Home View
- Model로부터 letter을 사용, ForEach로 3개의 letter 제작

### PreferenceKey
- 각 letter에 OffsetModifier을 달고, 해당 좌표를 추적한다
- 스크롤을 통해 OffsetKey의 값이 바뀔 때마다 value로 좌표를 받으며, 해당 좌표에 맞게 ScrolledLetterShape의 크기를 조정, padding의 크기 조정이 이루어진다.


## 개발 / 배포 환경
- MacOS Monterey 12.4(16형 2021년 모델)
- Xcode version 13.4.1 SwiftUI

## 활용 / 참고 정보
[YouTube](https://www.youtube.com/watch?v=DuU7zP07bks)

## 핵심 포인트
### OffsetModifier.swift
```swift
struct OffsetModifier: ViewModifier {
    
    @Binding var rect: CGRect
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    Color
                        .clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self) { value in
                self.rect = value
            }
    }
}

// Offset Preference Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
```

> PreferenceKey?
- `Preference`는 `key-value`의 형태로 하위 뷰 정보를 상위 뷰에게 전달할 수 있는 수단이다.
- reduce 메소드는 `sizeKey`를 사용하는 하위 뷰들을 순회하며, 상위 뷰가 접근할 수 있는 값을 만들기 위해 이들의 값을 취합하는 역할을 한다.
- 위의 `Modifier`에서 `Color.clear.preference` … 의 문구를 사용한 이유는, Color 또한 `View`의 프로토콜을 따르면서 사용자가 볼 수 없는 특징을 가지고 있기 때문에 `Preference`으로 `proxy.frame`의 `.named`를 제공하고 있는 것이다.
- `onPreferenceChange`는 `OffsetKey`의 값이 변경될 때마다 실행되는 일종의 **트리거**역할을 하며, 이렇게 반환된 `value`는 `@Binding`된 `rect`변수에 넣어주는 역할을 한다.

> Modifier?
- 기존에 어떤 특정 `View`가 많이 사용되는 것에 있어서 하나의 뷰로 만들어 놓고 사용할 수 있게 분리해둔 것들이 있다.
- 이와 비슷하게 기존에 생성한 뷰를 꾸며주는 이를테면 `.font(.title).padding()` 등의 것들을 미리 만들어놓고 재사용할 수 있도록 도와준다.

```swift
struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 30))
    }
}
```

- 이와 같이 사용되며, 여기서 `content`는 해당 구문을 사용하는 `View`에 적용하는 모든 `content`가 위의 인수로 받아져 들어오는 것이다.
- 특징으로는 `func`로 구현된다는 점. `content`를 사용하여 해당 `content`가 어디에 있어야 하는지 결정할 수 있다는 점 등이 있다.

### coordinateSpace
```swift
ScrollView(.vertical, showsIndicators: false) {
    VStack(spacing: 30) {
        ForEach(letters) { letter in
            LetterCardView(letter: letter)
        }
    }
    .padding(.horizontal)
    .padding(.bottom)
}
// setting coordinate name space
.coordinateSpace(name: "SCROLL")
```

- 위의 내용에서 우리는 `SCROLL`을 `proxy.frame(in .named(“SCROLL”)`으로 보내주었다.
- 즉, `modifier`으로 상위 뷰에게 `proxy의 기준을 어디로 세울까요?` 라고 질문한 것이고, `coordinateSpace는 자신의 이름을 알리면서, 자신이 가리키고 있는 ScrollView의 기준점 부터 시작하세요.` 라고 알려준 것이다.
- 앞으로 `OffsetKey`는 빨간 점을 기준으로 잡을것이다.
<img width="321" alt="스크린샷 2022-06-30 오후 8 48 10" src="https://user-images.githubusercontent.com/68142821/176670094-c38a1b7a-f1b7-497e-a138-e8af01f7792e.png">

### mask
```swift
.mask(
    Rectangle()
        .padding(.top, rect.minY < (getIndex() * 50) ? -(rect.minY - getIndex() * 50) : 0)
)
```

- `mask`는 해당 뷰에서 이 만큼만 보겠습니다! 라고 생각하면 편하다.
- 즉, `mask`안에 우리는 `Rectangle`을 구현했고, 전체 뷰에서 어느 부분만 볼지 설정하는 것이다.
- 우리는 `rect`라는 `State`변수를 지정했는데, 여기서 어떻게 활용하는지 잠깐 보고 넘어가자.

### CGRect
- 간단하게 CGSize와의 차이를 설명하겠다.
- CGSize는, width와 height를 가지고 있어 도형을 그릴 수 있지만, CGRect는 기준이 되는 기준점과 CGSize를 가지고 있다. **즉, 어디서부터 시작해서 그려야하는지에 대한 정보를 가질 수 있다.**

![image](https://user-images.githubusercontent.com/68142821/176673241-927fe8b1-19da-4a2e-997f-42fdfacdf8be.png)

- `CGRect`에서 사용할 수 있는 변수는 다음과 같이 지정되어 있다. 즉 `mask`에서 사용한 `padding`안의 값을 자세히 해석하자면 이렇다.

```swift
// padding을 top에만 준다.
.padding(.top, 

// padding을 얼만큼 줄거냐 하면
// rect가 가리키는 맨 윗줄이 만약 (getIndex() * 50)보다 작아진다면
rect.minY < (getIndex() * 50) 

// -(rect.minY - getIndex() * 50) 이만큼만 갈 것이고
// 그게 아니라면 0만큼만 패딩을 줄 것이다.
? -(rect.minY - getIndex() * 50) : 0))
```

- 여기서`getIndex` 메소드는 해당 `letter`가 몇번 째 있는지에 대한 정보이다.
- 따라서 모든 `offset`정보가 없다고 가정하고, mask만 남아있으면 다음과 같다.
<img width="265" alt="스크린샷 2022-06-30 오후 9 19 34" src="https://user-images.githubusercontent.com/68142821/176675489-0acf07f1-8a5c-49a6-aaad-cce79592ab14.png">

그런데 여기에 이 `offset`이 포함되면 어떨까?

```swift
.offset(y: rect.minY < (getIndex() * 50) ? (rect.minY - (getIndex() * 50)) : 0)
```

덕분에 mask때문에 잘리는 부분 없이 아래로 밀려날 수 있게 되었다.

### ViewBuilder
- 우리는 `ScrolledLetterShape`에서 `ViewBuilder`를 사용했다. 이는 `Closure`에서 `View`룰 구성하는 `custom parameter attribute`이다.
- 즉 클로저에서 뷰를 구성한다고 생각하면 된다.

- ViewBuilder를 구성하는 방법에는 두 가지가 있다.
1. ViewBuilder를 후행클로저로 사용
```swift
public init(@ViewBuilder content: () -> Content) {
    // Implementation here
}

struct ContentView: View {
    var body: some View {
        // 마지막 매개변수는 ViewBuilder이므로 다음과 같이 생성 가능
        Group {
            Text("I'm in the group")
            Text("Me too")
        }
    }
}
```

2. ViewBuilder를 함수로 사용
```swift
struct ContentView: View {
    var body: some View {
        Group(content: contentBuilder)
    }

    @ViewBuilder
    func contentBuilder() -> some View {
        Text("I'm viewBuilder")
        Text("Just stack the views")
    }
}
```

이 말고도 자체적으로 다음과 같이 사용할 수도 있다.

```swift
struct ContentView: View {
    var body: some View {
        GreenGroup {
            Text("first text")
            Text("second text")
        }
    }
}

struct GreenGroup<Content>: View where Content: View {
    var views: Content

    init(@ViewBuilder content: () -> Content) {
        self.views = content()
    }

    var body: somd View {
        Group {
            views.foregroundColor(.green)
        }
    }
}
```
