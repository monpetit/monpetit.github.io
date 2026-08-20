---
title: "함수형 프로그래밍 언어: OCaml/F#/Haskell"
date: 2026-08-19T23:12:04+09:00
categories: ["Programming"]
tags: ["Functional", "Programming Language", "Rust", "OCaml", "F#", "Haskell"]
draft: false
---

요즘은 예전과 달리 실무에 적용해도 충분할 만큼 잘 정비된 함수형 언어들도 많다. 하지만 여전히 대부분의 개발자가 먹고 사는 데에는 절차형 언어들을 붙들고 있다. 그러면서 늘 생각한다. "언젠가는 내가 함수형 언어로 개발을 해 보겠다"고.

특히 개발 프로젝트에 지칠 때에는 더욱 그런 생각이 드는데, 절차형 언어를 쓰다 보면 왠지 모르게 공장의 조립 라인에 서서 나사만 조이는 단순 조립공이 된 것 같은 기분이 든다. 그래서 오늘도 먹고 사는 데에는 아무런 쓸모 없어 보이는 것들에 다시금 눈길을 주게 된다.

## 1. 몇 가지 함수형 언어들

절차형 언어만 사용한다고 하지만, 2026년도 현재 순수한 함수형 언어도, 순수한 절차형 언어도 없다. 대부분의 주류 프로그래밍 언어들은 이미 함수형 언어에서 많은 개념을 도입해서 쓰고 있다. 그리고 많은 개발자들이 자신도 모르게 함수형 언어의 개념에서 온 것들을 쓰고 있다.

그럼에도 함수형 언어라고 하면 생각나는 것들을 몇 가지 나열해보면, 함수형 프로그래밍을 주된 패러다임으로 사용하는 순수 함수형 언어와, 객체 지향 등 다른 기능과 결합된 멀티 패러다임 함수형 언어로는 ==Haskell, Scala, Clojure, Erlang, Elixir, F#, OCaml== 등이 있다.
### a. 순수 함수형 언어

수학적 함수를 엄격하게 따르며 상태 변경을 허용하지 않는 대표적인 언어다.

- Haskell: 가장 대표적이고 정통적인 순수 함수형 언어
- Erlang: 병행성과 분산 처리에 강한 통신 시스템용 언어
- Elixir: Erlang 가상 머신(BEAM) 위에서 동작하는 모던 함수형 언어
- OCaml: 강력한 타입 시스템을 갖춘 실용적인 언어
- Agda: 의존 타입을 지원하는 증명 보조 시스템 겸 언어

### b. 멀티 패러다임 함수형 언어

함수형 특징을 메인으로 삼거나, 객체 지향 및 범용 문법과 결합된 언어다.

- Scala: 자바 가상 머신(JVM)에서 돌아가는 객체지향 + 함수형 언어
- Clojure: 자바 기반의 모던 Lisp 방언
- F#: 닷넷(.NET) 플랫폼에서 사용하는 함수형 중심 멀티 패러다임 언어

### c. 함수형 문법을 지원하는 주요 언어

원래는 다른 패러다임이 중심이지만 람다 식과 고차 함수 등 강력한 함수형 기능을 지원하는 언어다.

- Kotlin
- Swift
- JavaScript / TypeScript
- Python
- Java (Java 8 이후)

---

## 2. OCaml과 F#은 얼마나 다른가

이들 중에서도 ML 계열의 언어들이 예전부터 내 관심을 많이 끌었다. 그리고 위의 목록에서 OCaml과 F#은 다른 범주에 들어가 있으면서도 얼핏 보면 같은 언어인가 싶을 정도로 문법적으로 닮았다. 그리고 그건 우연이 아니다. **F#은 OCaml과 같은 ML 계열 언어에서 출발했기 때문에 문법과 언어 철학을 상당 부분 공유한다.**

특히 처음 보면 이런 부분들이 아주 비슷다다.

```ocaml
(* OCaml *)
let square x = x * x

let result =
    match value with
    | Some x -> x
    | None -> 0
```

```fsharp
// F#
let square x = x * x

let result =
    match value with
    | Some x -> x
    | None -> 0
```

둘 다

- `let`으로 값을 정의하고
- 함수가 기본적으로 1급 객체이며
- 타입 추론을 강하게 사용하고
- algebraic data type을 사용하고
- `match ... with` 패턴 매칭을 사용하고
- `Some` / `None` 같은 option 타입을 사용하고
- immutable 데이터를 선호하는

**ML 계열의 특징**을 공유한다.

참고로 ML 언어들의 계보를 보면 이렇다.

{{< mermaid >}}
flowchart TD
    ML[ML] --> SML["Standard ML<br/>(SML/NJ, Poly/ML, Moscow ML, SML#)"]
    SML --> AliceML[Alice ML]
    SML --> ConcurrentML[Concurrent ML]
    SML --> CakeML[CakeML]
    ML --> OCaml[OCaml]
    OCaml --> FSharp[F#에 상당한 영향을 줌]
{{< /mermaid >}}

F#은 특히 **OCaml의 영향을 강하게 받은 .NET용 함수형 언어**라고 생각하면 이해하기 쉽다. F#의 초기 설계에는 OCaml의 영향을 받은 부분이 상당히 많다.

그런데 두 언어를 실제로 오래 사용하다 보면 "**문법은 비슷한데 느낌은 꽤 다르다**"는 것도 느끼게 된다.

예를 들어 OCaml은 전통적인 ML 계열의 문법을 좀 더 강하게 유지한다.

```ocaml
type person = {
  name : string;
  age : int;
}

let greet p =
  Printf.printf "Hello, %s\n" p.name
```

F#은 .NET 생태계와 C#의 영향을 받으면서 조금 더 현대적인 .NET 언어다운 모습을 보인다.

```fsharp
type Person = {
    Name: string
    Age: int
}

let greet p =
    printfn "Hello, %s" p.Name
```

그리고 **모듈/객체/라이브러리 생태계** 쪽으로 가면 차이가 상당히 커진다.

OCaml:

```ocaml
module User = struct
  type t = {
    name : string;
    age : int;
  }

  let create name age = { name; age }
end
```

F#:

```fsharp
module User =
    type Person = {
        Name: string
        Age: int
    }

    let create name age =
        { Name = name; Age = age }
```

또 F#은 .NET의 객체지향 세계와 아주 자연스럽게 섞인다.

```fsharp
let text = System.String.Join(", ", ["A"; "B"; "C"])
```

이런 식으로 **C# 라이브러리를 그대로 가져다 쓸 수 있다는 점**이 F#의 엄청난 장점이다.

반대로 OCaml은 **독자적인 언어 생태계와 컴파일러/런타임을 가진 언어**이고, 함수형 프로그래밍 언어로서의 정체성이 좀 더 강하다.

그리고 요즘 많이 쓰는 Rust나 Elixir를 쓰는 개발자라면 재미있는 공통점도 많이 발견할 수 있다.

{{< mermaid >}}
flowchart LR
    OCaml[OCaml] --> Common[함수형 + 정적 타입 + 패턴 매칭]
    FSharp[F#] --> Common
    Rust[Rust] --> Common
    Elixir[Elixir] --> Common
{{< /mermaid >}}

물론 Rust는 ML 언어가 아니고 Elixir는 동적 타입이므로 같은 계열이라고 할 수는 없다. 하지만 **대수적 데이터 타입, 패턴 매칭, 함수 중심 설계, 불변성** 같은 개념을 접하다 보면 서로 통하는 부분이 상당히 많다.

특히 **Rust의 enum + match에 익숙하다면 OCaml/F#은 굉장히 친숙하게 느껴질 가능성이 높다.**

```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}

match result {
    Ok(value) => println!("{}", value),
    Err(e) => println!("error: {}", e),
}
```

이 사고방식 자체가 ML 계열의 전통과 아주 가깝기 때문이다.

그래서 한마디로 정리하면 "**F#은 OCaml과 닮은 게 아니라, 실제로 OCaml과 같은 ML 계보에서 파생된 언어**"라고 보는 게 가장 정확하다. 다만 F#은 .NET/C# 세계에 적응하면서 꽤 독자적인 방향으로 발전한 언어라고 보면 된다.


---

## 3. 산업적으로 실패한 Haskell?

그리고 함수형 언어 이야기를 할 때 빠지지 않는, 함수형 언어의 끝판왕 Haskell이 있다. 그런데 주위에 Haskell 쓰는 사람 본 적 있나? 찾기 어려울 거다. 그래서 Haskell을 말할 때 실무적으로는 실패한 언어라고 말하는 사람들도 있다.

![Haskell Logo](/img/haskell-logo.webp)

그렇다. **Haskell은 ML 계열과 상당히 가까운 친척이지만, 체감 진입장벽은 확실히 더 높다.** 그렇지만 "실무적으로 실패했다"는 평가에는 나는 **"실패한 언어라고 하기엔 너무 많은 영향을 끼쳤지만, 범용 산업 언어로서는 기대만큼 성공하지 못했다"** 정도가 가장 정확하다고 본다.

### 1) 평가 모델의 차이

**Haskell이 왜 더 어렵게 느껴지는가?**

OCaml/F#과 Haskell의 가장 큰 차이는 사실 문법보다는 **평가 모델과 함수형 프로그래밍의 강도**이다.

OCaml은 기본적으로 이런 언어다.

```ocaml
let x = expensive_function ()
```

하면 `expensive_function ()`이 평가된다.

그런데 Haskell은 **lazy evaluation이 기본**이다.

```haskell
let x = expensiveFunction ()
```

여기서 `x`는 당장 계산되지 않을 수 있다. 실제로 값이 필요해지는 순간까지 계산을 미룬다.

이것 하나만으로도 프로그램의 실행을 머릿속으로 추적하는 방식이 상당히 달라진다.

그리고 Haskell은 함수형 프로그래밍을 단순히 "함수를 많이 쓰는 스타일" 정도로 받아들이지 않는다.

**부작용 자체를 타입 시스템으로 관리**한다.

```haskell
pureFunction :: Int -> Int
ioFunction   :: Int -> IO Int
```

`IO Int`는 단순히 "Int를 반환하는 함수"가 아니라, **I/O라는 effect를 수행하는 계산**이라는 의미를 타입에 포함한다.

이게 Haskell의 아주 중요한 철학이다.

---

### 2) Haskell의 학습 곡선

Haskell을 조금 깊게 들어가면 다음과 같은 것들을 만나게 된다.

- lazy evaluation
- higher-order function
- algebraic data type
- typeclass
- parametric polymorphism
- monad
- applicative
- functor
- higher-kinded type
- monad transformer
- type family
- GADT
- kind system

특히 **Monad**에서 많은 사람들이 좌절한다.

그런데 재미있는 것은 Haskell에서 Monad가 굉장히 중요한 개념인 반면, OCaml에서는 똑같은 문제를 해결하는 데 반드시 Monad라는 개념을 전면에 내세울 필요가 없다는 것이다.

그래서 같은 함수형 언어라도 학습 곡선이 상당히 다르다.

---

### 3) 정말로 실패했나?

**그런데 Haskell이 "실패했다"고 하기는 좀 억울하다.** 물론 상업적인 범용 프로그래밍 언어로서 보면 실패했다는 느낌이 완전히 틀린 건 아니다.

Haskell은 현재도 상당히 훌륭한 언어지만,

> "그래서 기업들이 Java/C#/Python을 버리고 Haskell을 대규모로 채택했느냐?"

라고 하면 **그렇지 않다.**

OCaml이나 F#도 주류는 아니지만, Haskell은 그보다도 더 niche하다. 특히 Haskell의 문제는 **언어 자체의 우수성과 산업적 성공 사이에 상당한 간극이 있다는 것**이다.

그런데 Haskell의 영향력을 보면 이야기가 완전히 달라진다.

---

### 4) Haskell이 끼친 영향

오히려 Haskell은 현대 프로그래밍 언어에 엄청난 영향을 끼쳤다. Haskell에서 발전한 아이디어들이 다른 언어에 굉장히 많이 들어갔다.

예를 들어:

**Rust**

```rust
match value {
    Some(x) => ...,
    None => ...
}
```

이런 패턴 매칭과 algebraic data type의 사고방식은 ML 계열과 매우 가깝다.

**Scala**

Haskell의 함수형 프로그래밍 아이디어를 상당 부분 받아들였다.

**Swift**

enum + associated value와 패턴 매칭 등에서 ML 계열의 영향을 볼 수 있다.

**Kotlin**

sealed class와 pattern-like 처리 방식 등에서 함수형 언어의 영향을 강하게 받았다.

그리고 요즘 TypeScript에서도

```typescript
type Result<T> =
  | { ok: true; value: T }
  | { ok: false; error: Error };
```

같은 식으로 **sum type을 흉내 내는 설계**가 굉장히 흔하다.

즉,

> **Haskell 자체는 주류가 되지 못했지만 Haskell이 퍼뜨린 아이디어는 주류가 됐다.**

이게 상당히 아이러니한 부분이다.

---

### 5) Haskell 도입 사례들

그리고 Haskell이 "실무 언어"로서 완전히 실패한 것도 아니다. 실제로 Haskell을 사용하는 회사들도 있다.

대표적으로 Meta가 Haskell을 상당히 오래 사용했고, 특히 **Haxl** 같은 시스템이 유명하다.

Well-Typed처럼 Haskell을 전문적으로 사용하는 생태계도 있다.

금융권에서도 Haskell이 사용된 사례가 있다.

다만 중요한 것은 **"사용되는 회사가 있다"와 "산업 표준이다"는 전혀 다른 이야기**라는 점이다.

Haskell은 전자에는 해당하지만 후자에는 해당하지 않는다.

---

### 6) Haskell의 단점

오히려 Haskell의 가장 큰 문제는 매우 역설적이다. 나는 Haskell의 장점이 동시에 단점이 되었다고 생각한다.

Haskell은

> "프로그램을 어떻게 작성하면 오류를 줄일 수 있을까?"

를 굉장히 진지하게 고민한 언어다. 그래서 강력한 타입 시스템과 순수 함수, immutable data, effect 관리 등을 제공한다.

그런데 기업 입장에서는 다른 문제가 생긴다. **개발자를 구하기 어렵다.** 그리고 기존 개발자가 Haskell을 배우는 데도 시간이 걸린다.

팀 전체가 Haskell을 사용하기로 결정하면:

{{< mermaid >}}
flowchart TD
    A[언어 학습] --> B[라이브러리 학습]
    B --> C[함수형 사고방식 학습]
    C --> D[typeclass / Monad / effect 이해]
    D --> E[Haskell 특유의 idiom 학습]
{{< /mermaid >}}

이라는 비용을 치러야 한다.

반면 Go 같은 언어는 대략

```go
func foo(x int) int {
    return x * 2
}
```

하고 시작할 수 있다.

기업 입장에서는 굳이 Haskell의 장점을 얻기 위해 그 비용을 지불할 이유가 많지 않다.

---

### 7) Rust

그래서 언어들을 이렇게 정리해보자.

| 언어         | 함수형 성향 | 타입 시스템 | 산업적 위치      |
| ---------- | -----: | -----: | ----------- |
| Haskell    |  ★★★★★ |  ★★★★★ | 매우 강한 niche |
| OCaml      |  ★★★★☆ |  ★★★★★ | niche       |
| F#         |  ★★★★☆ |  ★★★★☆ | .NET의 niche |
| Scala      |  ★★★★☆ |  ★★★★★ | 주류          |
| Rust       |  ★★★★☆ |  ★★★★★ | 빠르게 성장      |
| Kotlin     |  ★★★☆☆ |  ★★★★☆ | 강한 주류       |
| TypeScript |  ★★☆☆☆ |  ★★★☆☆ | 주류          |

그런 의미에서 **Rust가 재미있는 케이스**다.

Rust는 Haskell 같은 순수 함수형 언어는 아니지만, 현대적인 타입 시스템과 algebraic data type, pattern matching, immutability 등을 가져오면서도 C/C++의 성능과 시스템 프로그래밍 영역을 잡았다.

그래서

> **Haskell이 "좋은 언어를 만들면 사람들이 알아서 사용할 것이다"라는 접근의 한계를 보여줬다면, Rust는 "좋은 언어 + 명확한 산업적 문제 해결"이 얼마나 강력한지를 보여주는 사례**

라고 볼 수도 있다.

만약 개발자가 **Rust → OCaml/F# → Haskell** 순으로 관심이 가지면 꽤 재미있는 여행이 될 거다. 특히 Rust를 어느 정도 알고 있는 상태에서 Haskell을 배우면 예전보다 훨씬 덜 낯설게 느껴질 수 있다. 다만 **Monad부터 붙잡고 씨름하지 말고, Haskell의 lazy evaluation과 typeclass부터 이해하는 게 훨씬 낫다.**

---

## 4. 순수 함수와 입출력 함수

그런데 Haskell 언어를 처음 접하면 재밌는 게 있다. 위에서 잠깐 나왔던 코드를 다시 보자.

```haskell
pureFunction :: Int -> Int
ioFunction   :: Int -> IO Int
```

다른 언어에서는 정수형 파라미터를 받아 작업을 수행한 뒤에 정수형 값을 돌려주면 다 똑같다. 그러나 Haskell에서는 순수 함수와 입출력 함수가 구별된다. `Int -> Int`와 `Int -> IO Int`는 다른 함수다. 그럼 순수 함수 내에선 입출력이 금지된다는 건가? 그 반대는 허용하고? 그렇다면 실무적으로 같은 결과를 출력하는데 두 개의 함수를 만들라는 얘긴가?

그렇다. **바로 그게 Haskell의 핵심적인 사고방식 중 하나다.**

결론부터 말하자면:

> **`Int -> Int`와 `Int -> IO Int`는 완전히 다른 타입이고, 순수 함수에서는 `IO`를 수행할 수 없다.**
>
> 하지만 **프로그램 전체에서 순수 함수와 I/O를 별개의 함수로 나눠야 한다는 뜻이지, 같은 로직을 두 번 구현하라는 뜻은 아니다.**

### 1) `Int -> Int`

이건 정말 단순하다.

```haskell
double :: Int -> Int
double x = x * 2
```

`double 10`은 반드시 `20`이다.

그리고 이 함수는 아무것도 출력할 수 없다.

```haskell
double :: Int -> Int
double x = do
    print x
    x * 2
```

이런 건 안 된다.

왜냐하면 `print x`의 타입이 대략

```haskell
print :: Show a => a -> IO ()
```

이기 때문이다.

즉 `print` 자체가 **IO를 발생시키는 계산**이다.

---

### 2) `Int -> IO Int`

이건

```haskell
doubleAndPrint :: Int -> IO Int
doubleAndPrint x = do
    print x
    pure (x * 2)
```

같은 것이 가능하다.

여기서 중요한 차이가 있다.

```text
Int -> Int
```

는

> Int를 받아서 Int를 계산한다.

이고,

```text
Int -> IO Int
```

는

> Int를 받아서 **IO를 수행할 수 있는 계산**을 만들어낸다.

이다.

즉 `IO Int`는 그냥 `Int`가 아니다.

---

### 3) 순수 함수와 부작용의 분리

그런데 "그럼 IO가 순수 함수의 반대 방향으로만 허용되나?" 그렇다. 거의 정확하다.

Haskell은 개념적으로 프로그램을 이렇게 나눈다.

{{< mermaid >}}
flowchart TD
    subgraph Pure[순수한 세계]
        P1[Int -> Int]
        P2[String -> Bool]
        P3["[Int] -> Int"]
    end
    subgraph IOBox[IO]
        IO1[파일 / 네트워크]
        IO2[화면 / 키보드]
    end
    Pure --> IOBox
{{< /mermaid >}}

**순수한 함수 → IO를 직접 수행할 수 없음**

하지만

**IO를 수행하는 함수 → 순수 함수를 호출할 수 있음**

이다.

예를 들어 아주 전형적인 Haskell 프로그램은 이런 모양이다.

```haskell
double :: Int -> Int
double x = x * 2

main :: IO ()
main = do
    x <- readLn
    print (double x)
```

여기서 `double`은 완전히 순수하다.

`main`은 IO를 담당한다.

{{< mermaid >}}
flowchart TD
    A[사용자 입력] --> B[IO]
    B --> C[Int 값]
    C --> D[double :: Int -> Int]
    D --> E[Int 값]
    E --> F[IO]
    F --> G[화면 출력]
{{< /mermaid >}}

이게 Haskell이 말하는 **순수성과 부작용의 분리**다.

---

### 4) 역할의 분리

그래서 "함수를 두 개 만들어야 한다"는 건 아니다.

이 부분이 아주 중요하다.

예를 들어 웹 서버에서 DB를 조회한다고 해보자.

나쁜(?) 구조는 모든 로직이 DB에 직접 접근하는 것이다.

{{< mermaid >}}
flowchart TD
    A[DB 조회] --> B[계산]
    B --> C[조건 판단]
    C --> D[DB 조회]
    D --> E[계산]
    E --> F[HTTP 응답]
{{< /mermaid >}}

Haskell에서는 이런 식으로 나누는 것을 권장한다.

{{< mermaid >}}
flowchart TD
    IO1[IO 영역<br/>DB에서 데이터 가져옴] --> Pure[순수 함수들에게 전달]
    Pure --> CalcA[계산 A]
    Pure --> CalcB[계산 B]
    CalcA --> Result[결과]
    CalcB --> Result
    Result --> IO2[IO 영역<br/>HTTP 응답]
{{< /mermaid >}}

그러니까 **비즈니스 로직은 순수 함수로 만들고, 외부 세계와 접촉하는 부분만 IO로 만든다**는 것이다.

이렇게 하면 오히려 함수가 재사용하기 쉬워진다.

예를 들어:

```haskell
calculatePrice :: Int -> Int -> Int
calculatePrice price quantity = price * quantity
```

이 함수는

- 웹 서버에서도
- CLI에서도
- 테스트 코드에서도
- 배치 작업에서도

그냥 그대로 사용할 수 있다.

DB에서 가격을 가져오는 부분만 `IO`이다.

---

**그리고 여기서 Haskell의 진짜 재미있는 부분이 나온다.**

대부분의 개발자들이 아마 다음 질문을 할 것 같다.

> "그런데 `IO Int`가 결국 실행 결과로 Int를 주는 거라면, 그냥 Int로 만들고 내부에서 I/O 하면 안 되나?"

바로 **그걸 못 하게 하는 게 Haskell의 타입 시스템**이다.

예를 들어:

```haskell
getNumber :: IO Int
```

가 있으면,

```haskell
x :: Int
```

로 그냥 바꿀 수 없다.

반드시 `IO` 세계 안에서 받아야 한다.

```haskell
main :: IO ()
main = do
    x <- getNumber
    print (double x)
```

여기서

```haskell
x <- getNumber
```

의 `x`는 `Int`가 된다.

즉,

{{< mermaid >}}
flowchart TD
    IOInt[IO Int] -->|실행| Int[Int]
{{< /mermaid >}}

라는 관계가 있다.

하지만 **순수한 코드에서 임의로 `IO Int`를 실행해서 `Int`를 뽑아낼 수는 없다.**

---

### 5) 입출력의 의미

그래서 Haskell의 `IO`는 상당히 독특하다.

`IO Int`를 "Int를 담은 상자"라고 생각하면 조금 편하지만, 정확하게는 그것보다는

> **"Int를 만들어내는 외부세계와의 상호작용을 표현한 값"**

에 가깝다.

그래서 Haskell에서는 놀랍게도 이런 것도 가능하다.

```haskell
main :: IO ()
main = do
    putStrLn "Hello"
    putStrLn "World"
```

`main` 자체가 뭔가를 출력하는 특별한 함수라기보다, **"이런 IO 작업을 수행하라"는 값을 만들어내는 것**에 가깝다. 그리고 런타임이 그 `IO`를 실제 세계에서 실행한다.

---

이게 처음 접하면 굉장히 이상한데, 사실 Haskell의 철학은 꽤 일관된다.

**"부작용을 없애자"가 아니라**

> **"부작용이 어디에서 일어나는지를 타입으로 명확하게 표시하자."**

에 가깝다.

그래서

```haskell
f :: Int -> Int
```

를 보면 "**이 함수는 외부 세계에 손댈 수 없구나**"라고 믿을 수 있고,

```haskell
f :: Int -> IO Int
```

를 보면 "**아, 이 함수는 실행할 때 외부 세계와 상호작용할 수 있겠구나**"라고 즉시 알 수 있다.

이게 Haskell의 상당히 무서운(?) 장점이다.

그리고 이 관점에서 보면 **Rust의 `Result<T, E>`나 `Option<T>`보다 한 단계 더 나아가서, 프로그램의 effect 자체를 타입으로 끌어올린 것**처럼 보이기도 한다. 물론 Rust와 Haskell의 모델은 정확히 같지는 않지만.

---

## 5. Lazy evaluation

그런데 Haskell이 Lazy evaluation을 채택하면 개념적으로는 우아함이 넘치지만 결국 런타임에서 패널티를 물고 가는 것은 아닌가 하고 비판하는 사람들이 많다. 산업 현장에서 Haskell이 채택되지 않는 이유가 아니냐고 말이다.

그렇다. **그것도 Haskell이 산업 현장에서 주류가 되기 어려웠던 중요한 이유 중 하나라고 볼 수 있다.** 다만 "lazy evaluation이라서 느리다"고 단순화하면 조금 부정확하다.

핵심은 **평균적인 실행 성능 자체보다 성능을 예측하기 어렵게 만든다는 것**에 있다.

### 1) 런타임 비용

Lazy evaluation에는 실제 런타임 비용이 있다.

예를 들어 Haskell에서

```haskell
let x = expensiveComputation
```

이라고 하면 `x`를 당장 계산하지 않고 나중에 필요할 때 계산할 수 있다. 그런데 런타임에서는 단순히 "계산을 미룬다"로 끝나지 않는다. 계산되지 않은 값을 표현하기 위해 **thunk**라는 것을 만들어 놓는다.

대략:

{{< mermaid >}}
flowchart TD
    X[x] --> Thunk[thunk<br/>computation]
    Thunk -->|실제 값이 필요해짐| Calc[계산 실행]
    Calc --> Result[결과 저장]
{{< /mermaid >}}

여기에는

- thunk 생성 비용
- thunk를 따라가는 간접 참조
- 메모리 사용량 증가
- garbage collector 부담
- 평가 시점의 추가 비용

등이 생길 수 있다.

특히 **cache locality** 측면에서도 CPU가 좋아할 만한 구조는 아니다.

---

### 2) 비용 발생 시점

그런데 더 골치 아픈 것은 "언제 계산되는가"이다.

strict한 언어에서는:

{{< mermaid >}}
flowchart TD
    Foo["foo()"] --> Calc[계산] --> Result[결과] --> Next[다음 코드]
{{< /mermaid >}}

라는 실행 흐름을 생각하기 쉽다.

그런데 lazy 언어에서는:

{{< mermaid >}}
flowchart TD
    Foo["foo()"] --> Thunk[일단 thunk] --> Dots1[...] --> Dots2[...] --> Need[어느 순간 값이 필요함] --> Sudden[갑자기 계산]
{{< /mermaid >}}

이 될 수 있다. 따라서 성능 문제가 **코드에서 보이는 위치와 실제 비용이 발생하는 위치가 달라질 수 있다.** 이게 상당히 중요하다.

---

### 3) space leak

Haskell에서 악명 높은 문제가 **space leak**이다.

예를 들어 엄청난 양의 계산을 "나중에 하자"고 미뤄놓으면,

{{< mermaid >}}
flowchart TD
    A[작은 값] --> T1[thunk] --> T2[thunk] --> T3[thunk] --> T4[thunk] --> Dots[...]
{{< /mermaid >}}

이런 식으로 아직 계산하지 않은 것들이 메모리에 계속 살아 있을 수 있다.

결국

> "계산을 안 했는데 왜 메모리를 이렇게 많이 먹지?"

라는 상황이 발생할 수 있다.

그리고 이 문제를 해결하려면 **strict evaluation이 필요한 지점을 프로그래머가 이해하고 있어야 한다.**

즉 Haskell을 제대로 최적화하려면 역설적으로

> **lazy evaluation을 쓰는 언어에서 언제 강제로 평가할 것인지까지 알아야 한다.**

---

### 4) Lazy evalution의 순기능

그렇다고 Lazy evaluation이 무조건 성능에 나쁜 것도 아니다.
여기서 재미있는 반전이 있다.
Lazy evaluation은 **불필요한 계산 자체를 없앨 수 있다.**

예를 들어 무한 리스트가 가능하다.

```haskell
naturals = [1..]
```

하지만 이것은 실제로 무한한 리스트를 메모리에 만드는 게 아니다. 실제로 물리적인 리스트를 만들지 않기 때문에 선언할 수 있는 것이다.

```haskell
take 10 naturals
```

라고 하면 필요한 10개만 계산한다.

```text
[1, 2, 3, ..., 10]
```

만 얻는다.

이런 '**computation의 조합(composition)**'에서는 lazy evaluation이 굉장히 우아하다.

예를 들어:

```haskell
result =
    take 10
    . filter isPrime
    . map expensiveFunction
    $ hugeData
```

이런 코드는 중간 결과 전체를 만들어 놓지 않고 **필요한 만큼만 파이프라인을 흘려보내는 방식**으로 동작할 수 있다.

따라서 경우에 따라서는 오히려 상당히 효율적이다.

---

### 5) 예측 가능성의 문제

하지만 산업 현장에서는 "성능 예측 가능성"이 굉장히 중요하다.
이게 산업 현장에서 Lazy evalution을 채택하기를 꺼리는 더 본질적인 문제다.

예를 들어 서버 프로그램에서:

{{< mermaid >}}
flowchart TD
    A[request] --> B[DB] --> C[JSON serialization] --> D[network]
{{< /mermaid >}}

이런 경로의 latency를 관리해야 한다고 생각해 보자.

개발자가 원하는 것은 대략:

> "이 코드가 여기서 5ms 정도 걸린다."

라는 식의 예측 가능성이다.

그런데 lazy evaluation에서는 실제 계산이 나중으로 밀릴 수 있어서

{{< mermaid >}}
flowchart TD
    A[함수 A] --> B[10ms라고 생각했음] --> C[실제로는 thunk만 생성] --> D[함수 B] --> E[여기서 갑자기 A의 계산 발생] --> F[B가 40ms 걸림]
{{< /mermaid >}}

같은 일이 생길 수 있다.

물론 Haskell을 잘 아는 개발자는 이것을 충분히 관리할 수 있다. 하지만 **팀 전체가 알아야 하는 개념의 양이 증가한다.**

---

### 6) 최적화의 문제

그래서 Haskell은 이 문제를 해결하기 위해 꽤 많은 도구를 발전시켰다.
대표적인 것이 strictness annotation이나 `seq`, `$!`, strict data structure 등이다.

즉 Haskell 세계에서도

> "lazy니까 그냥 내버려두면 된다."

라고 생각하지 않는다.

오히려 실전에서는

> **"어디까지 lazy하게 하고 어디부터 strict하게 할 것인가"**

가 중요한 최적화 문제가 된다.

이것도 Haskell의 진입장벽을 높이는 요인이다.

---

### 7) OCaml/F#의 해결책

그래서 Haskell의 문제를 조금 더 정확하게 표현하면 이렇게 정리할 수 있다.

> **Lazy evaluation은 성능을 반드시 희생시키는 설계가 아니라, 성능 모델을 복잡하게 만드는 설계다.**

그리고 산업 현장에서는 이 차이가 굉장히 크다.

특히

- latency가 중요한 서버
- 실시간 시스템
- 메모리가 제한된 환경
- CPU/cache 효율이 중요한 시스템
- predictable performance가 중요한 시스템

에서는 **strict evaluation이 훨씬 이해하기 쉽고 관리하기 쉽다.**

그래서 OCaml이 꽤 흥미로운 위치에 있다.

OCaml은 ML의 강력한 타입 시스템과 ADT, pattern matching 등을 가져오면서도 **기본적으로 strict evaluation**이다.

즉,

{{< mermaid >}}
flowchart TD
    A[ML의 타입 시스템 / 함수형 프로그래밍] --> OCaml[OCaml]
    B[전통적인 strict evaluation] --> OCaml
{{< /mermaid >}}

이라는 선택을 한 셈이다.

F#도 기본적으로 strict이고...

반면 Haskell은

{{< mermaid >}}
flowchart TD
    A[ML 계열] --> Haskell[Haskell]
    B[순수성] --> Haskell
    C[lazy evaluation] --> Haskell
    D[effect를 타입으로 표현] --> Haskell
{{< /mermaid >}}

이라는 훨씬 더 급진적인 방향으로 갔다.

그래서 "**Haskell은 이론적으로 더 우아하지만 현실적인 비용이 커졌다**"는 개발자들의 지적은 상당히 타당하다.

다만 **lazy evaluation 하나만으로 Haskell의 산업적 한계를 설명하기보다는, `lazy evaluation + 강한 순수성 + 고급 타입 시스템 + 상대적으로 작은 생태계 + 높은 학습 비용`이 서로 겹친 결과**라고 보는 게 더 정확하다고 생각한다.

그리고 이 관점에서 보면 **F#이 왜 Haskell보다 기업 친화적으로 느껴지는지도 아주 잘 설명된다.** F#은 함수형 언어의 좋은 아이디어를 상당히 많이 가져오면서도, .NET이라는 거대한 산업 생태계와 **strict evaluation, 명령형/객체지향 코드와의 자연스러운 혼용**을 포기하지 않았으니까.

---
## 6. 마치며

학교 다닐 때 Haskell을 공부하면서 들었던 생각은, "현장에서 쓰일 일은 절대 없겠구나"였다. 그리고 실제로 그렇게 되었다. 하지만 Haskell을 보면서 느꼈던 신선한 충격, 그리고 절차형 언어에 도입했으면 좋을 것 같은 멋진 개념들이 기억에 오래 남았다.

OCaml은 거의 실제로 써먹을 수도 있었던 언어였다. 하지만 유니코드 처리를 위해서 따로 패키지를 설치해야 한다는 점이 발목을 잡았다. 문자열 "안녕하세요"의 길이를 5로 표시하는 것은 현대 프로그래밍 언어의 기본 덕목이다. 그런데 OCaml은 전통적인 언어들과 마찬가지로 문자열을 binary로 취급하기 때문에 15로 표시한다. 그렇다면 C/C++이랑 다른 게 무엇인가 하는 의구심이 들었다. 이미 설계를 그렇게 해 놓았으니 이제 와서 바꿀 수는 없을 테지.

그런 면에서 여러모로 멋진 개념들을 잘 버무려 놓은 F#이 갖고 놀기에 딱 좋다. .NET 생태계에 올라탈 수 있는 것도 좋고.

Elixir는 정말로 실무에 적용하기 좋은 언어다. 함수형 언어인데도 타입을 강제하지 않는 유연성을 보인다.
뭔가 모순적인 것 같지만, 실제로 써 보면 놀라울 정도로 부드럽게 두 개념이 서로를 밀어내지 않고 결합된다.
지금은 Elixir를 쓸 일이 없지만, 필요한 일이 생기면 언제든 현장에 투입할 준비가 되어 있다.
특히 실시간 무장애 네트워크 서비스를 만들 일이 있다면 무조건이라도 생각해도 좋다.

다시 F#을 가지고 놀아볼까?

그런데 F#을 손에 들고 대체 뭘 하지? 정작 좋은 도구를 가지고도 딱히 만들고 싶은 게 없다는 것이 함정이네...
