# WeatherAppScrolling
## 앱 이미지
![X - 4](https://user-images.githubusercontent.com/68142821/176987763-730e0d56-74d9-4478-86fd-dfcc59c475f4.png)

## 프로젝트 배경 / 목표
- `offset`을 극한으로 활용한다
- `ViewBuilder`을 클로저로 받아서 사용해본다.
- `ViewModifier`을 통해 `offset`을 구해본다.
- `Shape`에서 활용할 UIBezierPath을 알아본다.
- `zIndex`의 개념을 알아본다.
- `Custom struct View`를 제작해본다.

## 동작 방식
![X - 5](https://user-images.githubusercontent.com/68142821/176987769-e42b852d-fde2-40f0-93da-fa5badf98b76.png)

### Model : forecast
- 날씨에 대한 정보를 갖는다.

### HomeView
- 레이아웃의 골격을 갖춘다.
- `CustomStackView`를 활용하여 각 컴포넌트를 불러온다.
- `WeatherDataVIew`를 배치하여 아래 날씨 데이터에 대한 정보들을 불러온다.

### CustomStackView
- 사용처로부터 `titleView`와 `contentView`를 `ViewBuilder`으로 받는다.
- 넘어온 `ViewBuilder`을 통해 컴포넌트를 제작한다.

### WeatherDataView
- `CustomStackView`를 사용하여 날씨 데이터를 컴포넌트로 제작한다.

즉, TripModel로부터 Home View의 객체를 얻는다.

## 개발 / 배포 환경

- `MacOS Monterey 12.4(16형 2021년 모델)`
- `Xcode version 13.4.1 SwiftUI`

## 활용 / 참고 정보

[YouTube](https://www.youtube.com/watch?v=LcjI3K78xpI&t=889s)

## 핵심 포인트
### offset
```swift
@State var offset: CGFloat = 0

ScrollView {

}
.overlay(
    GeometryReader { proxy -> Color in
        let minY = proxy.frame(in: .global).minY
        DispatchQueue.main.async {
            self.offset = minY
        }
        return Color.clear
  }
)

func getTitleOffset() -> CGFloat{
    if offset < 0 {
        // setting one max height for whole title
        // consider max as 120
        let progress = offset / 120
        
        // since top padding is 25
        let newOffset = (progress >= -1.0 ? progress : -1) * 20
        
        return newOffset
    }
    
    return 0
}
```
- 현재 `ScrollView`는 화면 전체에 대한 크기를 가지고 있다.
- `minY`는 크기의 가장 위의 좌표를 자기고 있으며, 로컬 변수로 만들었다.
- `DispatchQueue`는 작업 항목의 실행을 관리하는 클래스이다.
- `main.async`를 활용하면 그 클로저 안에 있는 실행문을 비동기로 처리할 수 있도록 도와주며, 이는 2가지 `task`를 동시에 가능하게끔 할 수 있다!

- `Color.clear`을 `return`해야 하는 이유는 `overlay()`안에 들어가는 것은 View로 예상되어 있지만, 단순 `GeometryReader`만 사용될 경우 `void`를 `return`하기 때문에 `Color.clear`을 `return`할 수 있도록 한 것이다.

> `getTitleOffset`의 해석
> - `offset < 0`이라는 것은 스크롤을 위로 스와이프 할 때 올라감을 의미한다.
> - 즉, 기준점보다 위로 올라갔을 때 `offset / 120`을 잡으며, `offset이 120`보다 작을 때에는 기존의 `progress`로, `120`보다 더 작아지면 `-1`으로 고정값을 갖는다!
> - `progress`의 탄생 배경은 스크롤의 속도를 `120`만큼 더 줄게하기 위해서 이다.

> `offset`에 관해..
![ezgif com-gif-maker](https://user-images.githubusercontent.com/68142821/176989090-c45e77ad-df76-47f9-a725-448b2f864a7a.gif)

```swift
// 1.
.offset(y: -offset)
// 2.
.offset(y: offset > 0 ? (offset / UIScreen.main.bounds.height) * 100 : 0)
// 3.
.offset(y: getTitleOffset())
```

여기서 한번 의미를 해석해보자.
1. 우리는 `getTitleOffset()`을 만들었기 때문에, 이 요소에 대해서는 어떤 스와이프의 영향도 받으면 안된다. 따라서 `y축`이 고정되어 있는 상태로 제작하기 위해 1번의 문구를 추가한다.
2. 이는 아래로 당길 때 생기는 모션을 추가하기 위함이다. `offset`이 `0`보다 커질경우(아래로 당길 경우), `offset`을 전체 높이로 나눈 값에 `100`을 곱한다. -> 이는 스와이프로 전체 아래로 당길 경우 `100`만큼의 `height`만 내려간다는 의미이다.
3. 1번에서 우리는 `y축`에 대해 고정을 시켜놓았으니, 우리가 커스터마이징한 `offset`을 직접 대입시키면 된다!

### ViewBuilder의 활용
```swift
VStack(spacing: 8) {
    CustomStackView {
    
    } contentView: {
    
    }
}
```

우리는 다음과 같은 구문을 볼 수 있다.
`CustomStackView`는 직접 만들어서 사용하는 것이므로 우리가 원하는 인수만 받아 사용할 수 있는데 이는 두 개의 클로저를 받아 View를 형성하는 것 같아 보인다.

실제로는 이렇다.
```swift
struct CustomStackView<Title: View, Content: View>: View {
    var titleView: Title
    var contentView: Content
    init(@ViewBuilder titleView: @escaping () -> Title, @ViewBuilder contentView: @escaping () -> Content) {
        self.titleView = titleView()
        self.contentView = contentView()
    }
}
```

- `titleView`의 변수는 `Title`이라는 뭔가 없을 듯한 클래스의 형식으로 받는다. -> 이는 사용자가 지정한 특별한 반환형이며 `struct`이름 오른쪽에 넣어줌으로써 `swift`가 해석한다.
- `@escaping`은 간단하게 설명하자면, `func`로 선언된 함수는 위에서부터 아래로 순차적으로 실행되지만 `closure`으로 생성된 것은 비동기 작업을 많이 수행하기 때문에 바로 `return`을 하지 않는다. 즉, 우리는 이를 먼저 꺼내기 위해 `@escaping`를 사용한다.

### frame
```swift
.frame(maxWidth: .infinity, alignment: .leading)
```

- `frame`에 대해 잠깐 짚고 넘어가려고 한다.
- `frame`은 `width`와 `height`를 가질 수 있지만, `maxWidth`와 `minWidth`, `maxHeight`와 `minHeight`를 가질 수 있다.
- 만약 `view`가 아무런 문제 없이 크기를 가질 수 있으면 일반적으로 정의된 크기를 이용하지만, **최대 제약 조건이 정의된 상태에서 부모가 제안한 크기가 이보다 크다면 해당 뷰는 `maxWidth` 및 `maxHeight`를 따르게 된다.**

### clipped, zIndex
```swift
VStack {
    Divider()
    
    contentView
        .padding()
        
}
.background(.ultraThinMaterial, in: CustomCorner(corners: [.bottomLeft, .bottomRight], radius: 12))
// moving content upward
.offset(y: topOffset >= 120 ? 0 : -(-topOffset + 120))
.zIndex(0)
.clipped()
```

`titleView`와 `contentView`가 있는 `CustomStackView`의 한 부분이다.

- `contentView`가 올라가면서 `titleView`의 뒤쪽으로 이동하게 되는데, 겹쳐져서 올라가기에 뒤에 희미하게 비치게된다.
- 따라서 `clipped`을 선언하여 잘리는 부분이 없어지게끔 설정한다.

- 없어지면서 `contentView`가 `titleView`의 뒤쪽으로 이동해야 하기 때문에 `zIndex`를 줄 수 있다. 기본 값은 0이기 때문에 사실 상 위로 올리고 싶은 뷰를 `zIndex(1)`로 선언해주어도 된다.
