***`Who-Wants` 서비스 개발을 위한 Convention 정리 문서***

<br>

## Commit Message

* [CREATE] : 파일 생성한 경우, 리소스 추가한 경우
* [UPDATE] : 새로운 추가한 경우
* [DELETE] : 리소스를 삭제한 경우
* [BUGFIX] : 버그를 수정한 경우
* [WIP] : 현재 개발하고 있는 기능

<br>

## Coding Convention

### 코드 레이아웃

---

들여쓰기 및 띄어쓰기

- 들여쓰기에는 탭(tab)을 사용한다.
- 콜론(:)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.

줄바꿈

- 함수 정의가 최대 길이를 넘어가는 경우에는 아래와 같이 줄바꿈 합니다.
- 함수를 호출하는 코드가 최대 길이를 초과하는 경우에는 파라미터 이름을 기준으로 줄바꿈합니다.
  단, 파라미터에 클로저가 2개 이상 존재하는 경우에는 무조건 내려쓰기합니다.

- if let과 guard let 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다.

최대 줄 길이

- 한 줄은 최대 99자를 넘지 않아야합니다.

빈 줄

- MARK 구문 위에는 공백이 필요합니다.

  - MARK를 사용하는 경우

  1. Layout
  2. Action
  3. API
  4. Protocol
  5. Init

  - 작성법

  ```
  // MARK: - Layout
  
  // MARK: - Action
  ```

<br>

### 네이밍

---

클래스

- 클래스 이름에는 UpperCamelCase를 사용합니다.

함수

- 함수 이름에는 lowerCamelCase를 사용합니다.

변수

- 변수 이름에는 lowerCamelCase를 사용합니다.

