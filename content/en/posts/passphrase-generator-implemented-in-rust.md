---
title: "Rust로 구현하는 암호 문구 생성기"
date: 2026-08-13T14:16:25+09:00
categories: ["Programming"]
tags: ["Password", "Python", "Rust", "Cryptography"]
draft: false
---

예전에는 암호 하나 만들어서 모든 사이트에 다 썼지만 요즘도 그렇게 하는 사람이 있을까 싶다. 관리가 부실한 사이트에서 자신의 암호가 하나 털리면 그것으로 모든 계정의 뒷문이 다 열릴 테니 말이다. 그런데 각각의 사이트 또는 서비스마다 암호를 다르게 만들면 그걸 관리하는 것도 큰 부담이다. 그래서 암호 관리 앱을 쓰고 있긴 한데, 이것이 정말로 안전한지는 솔직히 말해 잘 모르겠다. 그래서 상황이 허락하는 한 2단계 인증, 패스키 인증 등으로 방어하려고 한다. 그것까지 뚫리면 어쩔 수 없고...

암호 생성도 어지간하면 암호 관리 앱에서 만들어주는 대로 쓰고 있긴 한데, 가끔씩 암호 관리 앱과 서비스를 연동하기 어려운 경우가 있고, 이럴 때면 손으로 암호를 넣고 로그인해야 한다. 그런데 특수문자까지 포함된 무작위의, 아무 뜻도 없는 암호를 도대체 어떻게 기억한단 말인가. 그래서 요즘은 그런 무작위 암호 대신 암호 문구를 만들어주는 암호 생성기도 있다. Cloudflare의 명령행 툴로 새 프로젝트를 만들거나 네트워크 터널링을 할 때면 그런 걸 볼 수 있다. 예를 들어 프로젝트 이름을 gentle-cell-23a1로 만든다거나 로컬 서비스를 외부로 노출할 때 https://society-ana-pas-head.trycloudflare.com, https://explosion-brief-hybrid-distances.trycloudflare.com 같은 URL을 부여하는 것이다.

확실히 무작위 암호보다는 이런 암호 문구를 기억하기 쉽다. 그런데 얻는 게 있으면 잃는 게 있는 법. 생각해 보면 무작위 암호에 비해 이미 정해진 단어장에서 몇 개의 단어를 순서대로 추출하는 것이 암호학적으로 덜 안전하리라는 것은 자명하다. 

### 핵심은 엔트로피이다

소문자 기준으로 암호 문구를 만들면 엔트로피가 얼마나 높아지는지를 생각해 보았다.

패스프레이즈의 안전성은 결국 이 공식으로 결정된다:

**전체 엔트로피 = 단어당 비트수 × 단어 개수**

단어당 비트수는 ```log2(단어장 크기)```로 계산된다. 예를 들어:

* 단어장이 7,776개 (유명한 diceware 단어장 크기, 6^5)라면 → 단어당 약 12.9비트
* 4단어 조합 → 약 51.6비트
* 5단어 조합 → 약 64.6비트
* 6단어 조합 → 약 77.5비트

일반적으로 **60비트 이상**이면 오프라인 브루트포스 공격에도 충분히 안전하다고 본다. 물론 어디에 쓰이느냐에 따라 다르지만. 그래서 diceware 계열은 보통 5~6단어 이상을 권장한다.

### 그런데 함정이 몇 가지 있다

1. **단어장이 너무 작은 경우** — 어떤 서비스는 "친숙한 단어"라는 명목으로 몇백 개짜리 단어장을 쓰기도 한다. 이러면 단어당 엔트로피가 확 줄어들어서, 3~4단어를 붙여도 실제로는 8자리 랜덤 비밀번호보다 약할 수 있다.

2. **선택 과정이 진짜 무작위인가** — 단어장이 커도, 선택 알고리즘이 예측 가능한 PRNG(예: `Math.random()`, 시드가 예측되는 방식)를 쓴다면 의미가 없다. 반드시 CSPRNG(암호학적으로 안전한 난수 생성기)를 써야 한다. Python으로 구현할 때에도 random 모듈은 절대 안 되고, 그 대신 secrets를 써야 한다.

3. **단어 개수가 표시된 것보다 적을 때** — 단어 개수가 딱 3개면 단어장이 아무리 커도 좀 아슬아슬하다. 7,776 단어장 기준으로 3단어면 약 38.7비트인데, 이건 오늘날 GPU 클러스터로는 그리 오래 걸리지 않고 뚫릴 수 있는 수준이라고 봐야 한다.

게다가 어떤 사이트는 영문 대소문자 + 숫자 + 특수문자 조합을 강제하므로, 암호 문구에 하이픈('-')이 들어간다고 해도, 최소 한 개 이상의 대문자와 한 개 이상의 숫자도 포함되어야 한다.

### 엔트로피 증가시키기

소문자와 하이픈에다가 대문자를 넣으면 엔트로피가 늘어날까?

답은 "규칙을 어떻게 적용하느냐"에 따라 완전히 달라진다.

**결론부터: 고정된 규칙이면 엔트로피 증가 없음**

만약 "모든 단어의 첫 글자를 항상 대문자로"라는 규칙을 일괄 적용하는 거라면, 엔트로피는 전혀 늘어나지 않는다.

왜냐하면 엔트로피는 "공격자가 모르는 정보의 양"을 뜻하는데, 이 규칙은 공격자도 알 수 있는 정보이기 때문이다. 공격자 입장에서는:

```Apple-River-Tiger-Cloud```

이걸 시도할 때, 대문자화 규칙이 뻔히 보이니까 그냥 `apple-river-tiger-cloud`를 사전에서 찾은 다음 규칙대로 변환만 하면 끝이다. 브루트포스 공간이 전혀 늘어나지 않는 거다.

**엔트로피를 실제로 늘리려면: 무작위성이 들어가야 한다.**

엔트로피가 늘어나려면 "예측 불가능한 선택"이 추가돼야 한다. 예를 들면:

**방법 1 — 단어별로 대문자 여부를 무작위로 결정**
```python

import secrets

def maybe_capitalize(word):
    return word.capitalize() if secrets.choice([True, False]) else word
```
이러면 단어 하나당 1비트가 추가된다. (대문자/소문자 = 2가지 경우의 수 = log2(2) = 1비트). 6단어면 총 6비트가 늘어나는 셈이다.

**방법 2 — 대문자 위치를 여러 후보 중 무작위로**

첫 글자만이 아니라 단어 내 임의의 한 글자를 무작위로 대문자화하면, 단어 길이에 따라 추가되는 비트수가 더 늘어날 수 있다. (예: 6글자 단어면 log2(6) ≈ 2.58비트).

**비교해보면**

6단어 EFF 암호 문구 기준으로:

| 방식 | 엔트로피 |
|---|---|
| 기본 (소문자만) | 약 77.5비트 |
| 모든 단어 첫글자 고정 대문자 | 약 77.5비트 (변화 없음) |
| 단어별 무작위 대문자화 | 약 83.5비트 |

### 더 효율적인 대안도 있다

사실 엔트로피를 늘리고 싶으시면, 대문자화보다 **숫자 하나를 무작위 위치에 삽입**하거나 **단어를 하나 더 추가**하는 게 훨씬 효율적이다. 예를 들어 단어 하나를 추가하면 (7,776 단어장 기준) 약 12.9비트가 통째로 늘어나는데, 이건 대문자화로 얻는 것보다 훨씬 크다.

만약 암호 문구를 `turkey1-3untagged-0copper-rust4` 처럼 만든다면:

- `turkey` + `1` (단어 뒤에 숫자)
- `3` + `untagged` (단어 앞에 숫자)
- `0` + `copper` (단어 앞에 숫자)
- `rust` + `4` (단어 뒤에 숫자)

즉 **각 단어마다 숫자 하나(0~9)를 무작위 위치(앞/뒤)에 삽입**하는 방식이다. 이건 실제로 엔트로피를 늘리는 좋은 방법이다. 왜냐하면 두 가지 무작위 선택이 추가되기 때문이다.

단어 하나당 추가되는 정보:
1. **숫자 선택** (0~9 중 하나) → log2(10) ≈ 3.32비트
2. **위치 선택** (앞 또는 뒤) → log2(2) = 1비트

**단어당 추가 엔트로피 ≈ 4.32비트**

4단어 기준으로 비교하면:

| 방식 | 엔트로피 |
|---|---|
| 기본 4단어 (EFF, 소문자만) | 약 51.6비트 |
| + 숫자 삽입 방식 (질문 예시처럼) | 약 51.6 + 4×4.32 ≈ **68.9비트** |

거의 6단어짜리 기본 패스프레이즈(약 77.5비트)에 육박하는 수준으로 올라간다. 꽤 효율적인 방법이다.

### 주의할 점 몇 가지

1. **패턴이 "매 단어마다 숫자 하나씩"으로 고정**되어 있다는 것 자체는 공격자도 알 수 있다 (Kerckhoffs의 원칙: 알고리즘은 공개되어도 안전해야 함). 하지만 그건 문제 없다 — 핵심은 숫자 자체와 위치가 예측 불가능하다는 거니까.

2. **숫자를 진짜 무작위로 뽑아야 한다.** 예를 들어 "단어 길이"나 "단어 순서"에서 유도된 숫자라면 (`turkey`가 6글자라서 뒤에 6을 붙인다든가) 엔트로피가 전혀 늘지 않는다. 반드시 별도의 무작위 소스여야 한다.

3. **구현 코드 예시:**

```python
import secrets

def add_random_digit(word):
    digit = str(secrets.choice(range(10)))
    if secrets.choice([True, False]):
        return digit + word  # 앞
    else:
        return word + digit  # 뒤

def generate_passphrase(wordlist, num_words=4, separator="-"):
    words = [secrets.choice(wordlist) for _ in range(num_words)]
    words = [add_random_digit(w) for w in words]
    return separator.join(words)
```

### 정리

이 방식은 대문자화보다 **엔트로피 기여도가 훨씬 크다** (단어당 1비트 vs 4.32비트). 그리고 사람이 기억하기에도 "단어 뒤에 숫자가 붙는다" 정도의 구조는 파악하기 쉬워서 사용성도 나쁘지 않아 보인다. 좋은 설계 방향이라고 생각한다.

정리하면, "형태를 바꾸는 규칙"이 아니라 "무작위 선택지를 하나 더 만드는 것"이 핵심이다. 대문자화도 무작위로만 넣는다면 의미가 있지만, 가장 가성비 좋은 방법은 역시 단어 개수를 늘리는 거다.

하지만... 단어 개수가 늘어나면 날수록 외워야 하는 부담도 커진다.

그래서 이 정도 선에서 타협하자.

### 실제 구현

실제로 코드 구현은 Rust로 했다. 파이썬으로 해도 되는데, 실행 파일 하나만 가지고 배포하기 좋도록 Rust를 썼다.
단어장은 누구나 쓰는 [EFF 단어장](https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt)을 사용했다.

Cargo.toml
```toml
[package]
name = "passphrase-generator"
version = "0.2.0"
edition = "2024"

[dependencies]
clap = { version = "4.6.5", features = ["derive"] }
getrandom = "0.4"
thiserror = "2.0"
```

src/main.rs
```rust
use std::process::ExitCode;

use clap::Parser;
use thiserror::Error;

/// Generate cryptographically secure passphrases from the EFF large wordlist.
#[derive(Parser, Debug)]
#[command(version = env!("CARGO_PKG_VERSION"), about)]
struct Cli {
    /// Number of words in the passphrase
    #[arg(short, long, default_value_t = 5)]
    count: usize,

    /// Capitalize the first letter of roughly half the words
    #[arg(short = 'C', long)]
    capitalize: bool,

    /// Append a random digit (0-9) to roughly half the words
    #[arg(short, long)]
    number: bool,

    /// Delimiter between words
    #[arg(short, long, default_value = "-")]
    delimiter: String,
}

/// The embedded EFF large wordlist (compiled into the binary).
const WORDLIST: &str = include_str!("../data/eff_large_wordlist.txt");

// Compile-time validation of the wordlist is done in build.rs

/// Errors that can occur during passphrase generation.
#[derive(Error, Debug)]
enum PassphraseError {
    #[error("--count must be at least 1")]
    InvalidCount,
    #[error("RNG error: {0}")]
    Rng(String),
    #[error("malformed wordlist line")]
    MalformedWordlist,
}

/// A cryptographically secure random number generator backed by OS entropy.
struct SecureRng;

impl SecureRng {
    /// Returns a uniformly distributed integer in the range `0..bound`.
    fn below(bound: u32) -> Result<u32, PassphraseError> {
        debug_assert!(bound > 0);
        // Rejection sampling to avoid modulo bias.
        let threshold = (u32::MAX / bound) * bound;
        loop {
            let value = getrandom::u32().map_err(|e| PassphraseError::Rng(e.to_string()))?;
            if value < threshold {
                return Ok(value % bound);
            }
        }
    }
}

/// Parses the embedded wordlist once into a list of words.
fn load_words() -> Result<Vec<&'static str>, PassphraseError> {
    WORDLIST
        .lines()
        .map(|line| {
            line.split_once('\t')
                .map(|(_, word)| word)
                .ok_or(PassphraseError::MalformedWordlist)
        })
        .collect()
}

/// Runs the passphrase generation and prints the result.
fn run(cli: &Cli) -> Result<(), PassphraseError> {
    if cli.count == 0 {
        return Err(PassphraseError::InvalidCount);
    }

    let words = load_words()?;
    let word_count = words.len() as u32;

    let mut parts = Vec::with_capacity(cli.count);
    for _ in 0..cli.count {
        let index = SecureRng::below(word_count)?;
        let mut word = String::from(words[index as usize]);

        if cli.capitalize && SecureRng::below(2)? == 1
            && let Some(first) = word.get_mut(0..1)
        {
            first.make_ascii_uppercase();
        }

        if cli.number && SecureRng::below(2)? == 1 {
            let digit = char::from(b'0' + SecureRng::below(10)? as u8);
            word.push(digit);
        }

        parts.push(word);
    }

    println!("{}", parts.join(&cli.delimiter));
    Ok(())
}

fn main() -> ExitCode {
    let cli = Cli::parse();

    match run(&cli) {
        Ok(()) => ExitCode::SUCCESS,
        Err(err) => {
            eprintln!("error: {err}");
            ExitCode::FAILURE
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_load_words() {
        let words = load_words().expect("wordlist should load");
        assert_eq!(words.len(), 7776);
        assert!(words.iter().all(|w| !w.is_empty()));
    }

    #[test]
    fn test_secure_rng_below() {
        for bound in [1, 2, 10, 100, 1000, 7776] {
            let val = SecureRng::below(bound).expect("RNG should work");
            assert!(val < bound, "value {val} should be less than bound {bound}");
        }
    }

    #[test]
    fn test_run_basic() {
        let cli = Cli { count: 5, capitalize: false, number: false, delimiter: "-".into() };
        assert!(run(&cli).is_ok());
    }

    #[test]
    fn test_run_zero_count_fails() {
        let cli = Cli { count: 0, capitalize: false, number: false, delimiter: "-".into() };
        assert!(matches!(run(&cli), Err(PassphraseError::InvalidCount)));
    }
}
```

