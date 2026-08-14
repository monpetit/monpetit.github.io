---
title: "Hugo 정적 페이지에 동적 요소 도입하기"
date: 2026-08-14T10:42:17+09:00
categories: ["Programming"]
tags: ["Hugo", "Javascript", "HTML"]
draft: false
---

### 정적 블로그에 동적 요소 욕심내기

기껏 블로그에 정적 사이트 생성기를 도입해 놓고, 거기에 동적인 요소를
도입한다는 것은 어찌 보면 모순적일 수 있다. 아니 솔직히 말해 모순이다.
그럴 거면 처음부터 React나 Svelte 같은 프레임워크를 사용하지 왜 굳이
Hugo 같은, 또 하나의 러닝 커브를 만드는 도구를 쓰느냐는 말이다.
최대한 가볍게, 가능하면 기술의 도움을 받지 않고 글을 쓰고 싶은 마음에 시작하는
것이지만, 인간의 마음은 간사하기 이를 데 없다.
만들어 놓고 보면 뭔고 이것저것 고치고 싶고, 자동화시키고 싶어지고,
동적인 요소를 넣어보고 싶어진다.


### 컴파일 타임의 한계와 자바스크립트

바라는 것은 단 하나, 메인 페이지의 헤드라인의 문구를 여러 개로 준비해 놓고,
페이지를 새로 고침하거나 일정한 시간 간격을 두고 무작위로 다른 문구로 바꾸는 것이다.
Hugo는 말 그대로 정적 사이트 생성기이기 때문에 설령 무작위 요소를 도입한다 하더라도
여러 개의 요소 중에서 무작위로 한 개를 선택하는 것 또한 컴파일 당시에
발생하는 것이다. 그렇다면 헤드라인을 바꾸기 위해서 사이트 전체를 다시 컴파일하고, 그것을
배포해야 한다는 얘기다. 이건 동적 요소가 아니다.

그래서 결국, 정적 사이트 생성기의 취지에 정면으로 반하는 작업을 해야만 했다.
그것은 HTML 템플릿에 Javascript를 추가해서 DOM을 직접 조작하는 수고를 들였다.


### Hugo와 Blowfish 테마 적용하기

메인 페이지의 헤드라인을 담당하는 템플릿을 살펴보니 `/layouts/partials/home/profile.html`을
수정해야만 했다. 물론 헤드라인이 들어가는 템플릿이 저것 하나만 있는 건 아니고 다른 것들도 있지만,
현재 내가 선택한 레이아웃이 `profile`이므로 저 파일 하나만 수정하면 된다.

```html
<div id="random-display-box">
{{ with .Site.Params.Author.headline }}
  <h2 class="text-xl text-neutral-500 dark:text-neutral-400">
    {{ . | markdownify }}
  </h2>
{{ end }}
</div>
```

헤드라인이 들어가는 `h2` 태그를 새로운 `div` 태그로 감싸주고 `random-display-box`라는 이름의 id를 부여했다.
그리고 DOM을 조작하는 스크립를 아래와 같이 추가했다.

```html
<script type="text/javascript">
  const headlines = [
    "Play is the highest form of research. - Johan Huizinga",
    "The play element in culture is a primary and necessary condition of the generation of culture. - Johan Huizinga",
    "Play is not \"ordinary\" or \"real\" life. - Johan Huizinga",
    "If we are to preserve culture we must continue to create it. - Johan Huizinga",
    "Play is a uniquely adaptive act, not subordinate to some other adaptive act, but with a special function of its own in human experience. - Johan Huizinga",
    "History is the interpretation of the significance that the past has for us. - Johan Huizinga",
    "The eternal gulf between being and idea can only be bridged by the rainbow of imagination. - Johan Huizinga",
    "You can deny, if you like, nearly all abstractions: justice, beauty, truth, goodness, mind, God. You can deny seriousness, but not play. - Johan Huizinga",
    "Life must be lived as play, playing certain games, making sacrifices, singing and dancing, and then a man will be able to propitiate the gods, and defend himself against his enemies, and win in the contest. - Johan Huizinga",
    "The outlaw, the revolutionary, the cabbalist or member of a secret society, indeed heretics of all kinds are of a highly associative if not sociable disposition, and a certain element of play is prominent in all their doings. - Johan Huizinga",
    "Play is battle and battle is play. - Johan Huizinga",
    "The Japanese samurai held the view that what was serious for the common man was but a game for the valiant. - Johan Huizinga"
  ];

  // Function to get a random headline from the array
  function getRandomHeadline() {
    const randomIndex = Math.floor(Math.random() * headlines.length);
    return headlines[randomIndex];
  }

  // Function to update the headline in the DOM
  function updateHeadline() {
    const headlineElement = document.querySelector("#random-display-box h2");
    if (headlineElement) {
      headlineElement.textContent = getRandomHeadline();
    }
  }

  // Update the headline on page load
  document.addEventListener("DOMContentLoaded", updateHeadline);

  // Change headline every 10 seconds
  setInterval(updateHeadline, 10000);
</script>
```

> **💡 적용한 자바스크립트 코드**
> * 배열에 여러 개의 요한 하위징아(Johan Huizinga)의 명언 문구들을 등록
> * `Math.random()`을 이용해 무작위로 하나의 문구를 선택하는 `getRandomHeadline` 함수 작성
> * `DOMContentLoaded` 시점과 `setInterval`을 활용해 10초마다 DOM의 헤드라인 텍스트를 동적으로 교체
>
>

### 어디까지 타협할 것인가

헤드라인 문구까지 API를 호출하거나 URL을 긁어올 수도 있지만, 그건 선을 너무 넘는 것 같아서 이 정도로 끝내기로 했다.
모르지 뭐. 내일쯤 API를 호출하는 식으로 바꿀지도...

Hugo 테마는 Blowfish 기준이라, 다른 테마에서는 템플릿도 다른 내용이 될 것이다. 따라서 이 코드의 유효 범위는 Hugo + Blowfish에 한정.

이러다가 정적 사이트에 로그인 기능을 붙인다고 팔을 걷어붙이는 건 아닌지... = _=
