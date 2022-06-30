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
