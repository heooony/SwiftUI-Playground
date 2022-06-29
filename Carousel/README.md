# Carousel App
## 앱 이미지
![Untitled](https://user-images.githubusercontent.com/68142821/176414268-56c07faf-dd8a-4534-91a5-87e8786a6376.png)
![image](https://user-images.githubusercontent.com/68142821/176414287-f94aaf42-98b8-4dea-90cc-bd0a5d1e0d80.png)

## 프로젝트 배경 / 목표
- SwiftUI 기반이되, SwiftUI와 UIKit을 동시에 활용하는 방법을 알아본다.
- Image 컴포넌트의 활용을 알아본다.
- GeometryReader의 활용을 알아본다.
- TabView 와 tag의 활용을 알아본다.
- firstIndex의 사용법을 알아본다.
- Shape를 사용하여 도형을 바꾸는 방법에 대해 알아본다.

## 동작 방식
### Model : trip
- trip에 대한 id, image, title등 기본적인 이미지 갖기
- trips 배열로 trip에 대한 임시적 데이터 배열 갖기

### Home View
- Model로부터 View를 제작

### PageControl
- UIKit을 사용하여 Home View가 풍부한 활용을 할 수 있도록 도움
- UIViewRepresentable상속 / makeUIView, updateUIView의 활용

### CustomShape
- Home View에서 다채로운 활용을 위한 shape

즉, TripModel로부터 Home View의 객체를 얻는다.

## 개발 / 배포 환경
- MacOS Monterey 12.4(16형 2021년 모델)
- Xcode version 13.4.1 SwiftUI

## 활용 / 참고 정보
https://www.youtube.com/watch?v=tlas2AE_Few

## 핵심 포인트
### UIKit과 연결하는 방법
- UIViewRepresentable을 상속받아야 한다.
- 그러면 오류가 생긴다. 이 오류는 makeUIView, updateUIView를 선언해줌으로써 사라진다.
- 
```swift
import SwiftUI

struct PageControl: UIViewRepresentable {
 
    func makeUIView(context: Context) -> UIPageControl {

    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
    }
    
}

```

### TabView
<img width="483" alt="스크린샷 2022-06-29 오후 7 42 07" src="https://user-images.githubusercontent.com/68142821/176417892-d124beee-16ad-41d1-b2cd-2fe98b40f529.png">

- TabView는 selection이라는 인수를 가지는데, 인수로 들어오는 변수는 @State 값을 가지고 있어서 앞에 $를 선언해주어야 한다.
- 각 안의 내용물은 ForEach로 구현될 경우 tag()를 가지고 있어야 한다. 이는 각각을 구분하기 위함이다.

### GeometryReader 에서 frame활용
```swift
GeometryReader { proxy in
    let frame = proxy.frame(in: .global)
}
```

- .global을 사용하면 전체 뷰를 기준으로 좌표를 잡는다.
- .local을 사용하면 자신이 포함되어 있는 컨테이너를 기준으로 좌표를 잡는다.
