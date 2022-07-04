# WeatherAppScrolling
## 앱 이미지
![X - 6](https://user-images.githubusercontent.com/68142821/177065508-364ccd75-4863-4da2-ab6f-fffba7dc76a0.png)

## 프로젝트 배경 / 목표
- `Staggered grid` : 엇갈림 격자
- 핀터레스트같은 사이트를 보면 일정한 사진 규격에 맞게 정리되어 있는 것이 아닌, 각자의 사진 규격에 맞게 올라갈 수 있도록 지원하고 있다. 우리는 만들어보도록 한다.
- 2차원 배열에 대해 알아본다.
- 사용자 지정 `Grid`를 제작해보고, 우리가 받아야 하는 인자 값들로는 어떤 것들이 있는지 파악해본다.

## 개발 / 배포 환경

- `MacOS Monterey 12.4(16형 2021년 모델)`
- `Xcode version 13.4.1 SwiftUI`

## 활용 / 참고 정보
[YouTube](https://www.youtube.com/watch?v=f-qtPzp8X0s)

## 핵심 포인트
### StaggeredGrid의 핵심 분석
```swift
struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    
    var list: [T]
    var content: (T) -> Content
    var showIndicators: Bool
    var spacing: CGFloat
    var columns: Int
    
    init(showIndicators: Bool = false, spacing: CGFloat = 10, list: [T], columns: Int, @ViewBuilder content: @escaping (T) -> Content) {
        self.list = list
        self.content = content
        self.spacing = spacing
        self.showIndicators = showIndicators
        self.columns = columns
    }
```

- `Content`는 `View`의 형식을 지원한다. 즉, `Content`라는 반환 형식이 다른 `Int` 또는 `String`과 같은 형태가 아닌 `View`의 형식만을 지원한다는 이야기이다.
- `T`는 `Identifiable`이다. `T`로 들어오는 값의 형태는 어떤 고유한 식별자가 존재해야 한다는 의미이다. 즉, `list`와 `content`의 인자로 들어오는 값은 식별 가능한 값이 들어와야 한다.
- `showIndicators`는 스크롤이 보이는지에 대한 여부, `spacing`은 간격 공백이다. 여기서 우리는 이 두 변수에 대해 값을 넘겨줄 필요가 없다. 그것은 `init`에서 괄호 안에 이미 초기화되어있기 때문이다. 만약 값으로 넘어온다고 한다면 **그들은 우리가 넘겨준 값으로 초기화를 진행한다.**
- `content`는 `@ViewBuilder`이며, `Identifiable`한 인자를 받고 값을 반환한다. 즉, 여기서의 `content`는 각각의 post를 받고, 그것이 어떤 `View`를 갖고 있는지에 대해 `content`로 구현되어 있을 것이며, 우리는 이것을 `data`로써 뿌려줄 것이다.

### 2차원 배열

```swift
func setUpList() -> [[T]] {
    
    var gridArray: [[T]] = Array(repeating: [], count: columns)
    
    var currentIndex: Int = 0
    
    for object in list {
        gridArray[currentIndex].append(object)
        
        if currentIndex == (columns - 1) {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    return gridArray
}
```

- 1차원 배열을 만드는 방법은 다음과 같다.
`var array = Array(repeating: 0, count: 3) //[0, 0, 0]`
`var array = [Int](repeating: 0, count: 3) //[0, 0, 0]`

우리는 여기서 첫 번째 만드는 법에 집중해본다. 이와 같은 형태로 2차원 배열을 제작하는 방법은 다음과 같다.
- `var array: [[Int]] = Array(repeating: [], count: 3)`

즉 배열안에 배열을 반복해서 넣는것이다. 이는 총 3개의 배열을 갖고 있는 배열이다.

그래서 setUpList를 분석하면 다음과 같다.
![X - 7](https://user-images.githubusercontent.com/68142821/177067294-748aeba9-c966-494f-81f1-ffe8131b4a70.png)

- 먼저 `columns`가 3으로 들어온다면, 빈 배열을 3개 선언하는 것이다.
- `for object in list`를 통해서 `list`의 개수만큼 순환하는데, 여기서 `gridArray[0]`에 가장 초기값을 집어 넣고, 그 다음은 `gridArray[1]`에 두 번째 값을 집어 넣는 순서로 간다.
- 그러나 `column`값이 그 이상으로 넘어간다면, 다시 `currentIndex`값을 0으로 초기화하여 다시 첫 번째 배열의 배열에 값을 넣는다.
- 반복한다.

> 이러한 2차원 배열을 사용하는 방법은, 다른 언어에서와 같이 `for`을 두 번 사용하는 것이다.

```swift
var body: some View {
    ScrollView(.vertical, showsIndicators: showIndicators) {
        HStack(alignment: .top) {
            ForEach(setUpList(), id: \.self) { columnsData in
                // for optimized using LazyStack
                LazyVStack(spacing: spacing) {
                    ForEach(columnsData) { object in
                        content(object)
                    }
                }
            }
        }
    }
}
```

- `첫 번째 ForEach`는 `setUpList`로 반환되어 나온 배열을 집어 넣고, 여기서의 `columnsData`는 하나의 컬럼 배열을 의미한다.
- `두 번째 ForEach`를 통해 해당 컬럼에서 하나의 `object`를 추출하여 그것을 `content(object)`으로 집어 넣는것이다. 여기서 `content`는 무엇이 되어야 할까.
- -> `object`는 하나의 이미지에 지나지 않는다. 즉, 그것을 사용자가 보기에 가공된 모습으로 `View`를 제공해야 한다. `corner`의 각도는 몇인지, 이미지를 흐리게 할 것인지, `fill`인지 `fit`인지에 대한 정보들이 필요하다는 것이다.
- 이것은 이 `Grid`에서 하지 않으며, 이것을 `content`으로써 받아온 이유이다.

### matchedGeometryEffect
```swift
@Namespace var animation

PostCardView(post: post)
    .matchedGeometryEffect(id: post.id, in: animation)
    .onAppear {
        print(post.imageURL)
    }
```

- `matchedGeometryEffect`는 `id`와 `in`이라는 키워드를 가지고 있다.
- `in`이라는 키워드 안에는 `animation`이 있으며 해당 변수는 위에서 선언되어 있다.
- `id`이라는 키워드 안에는 `post.id`가 들어가 있다.

-> 결론 : 같은 `namespace`안에서 같은 `id`를 갖고 있는 요소는 위치 및 크기가 조정될 때에 `animation`효과를 가지게 된다.

![ezgif com-gif-maker (1)](https://user-images.githubusercontent.com/68142821/177068425-228a124d-a9fc-4dc2-b995-c4698468b389.gif)

즉, + 또는 -를 클릭하여 `GridView`가 조정될 때에 각 `post.id`를 동일하게 갖고있는 카드들은 변환될 때에 `animation`을 가질 수 있다는 이야기이다.
