/**
 * Blowfish 테마 Mermaid 설정 오버라이드.
 *
 * 테마 기본 설정을 기준으로 하되, 다이어그램이 너무 크게 렌더링되는 것을
 * 방지하기 위해 글꼴 크기와 노드/랭크 간격을 축소하고,
 * 사이트 커스텀 폰트(SuitMixed/Pretendard)를 사용하도록 조정한다.
 */

/** 다이어그램 레이아웃을 컴팩트하게 만드는 공통 값들 */
const _compact = {
  fontSize: "14px",
  nodeSpacing: 30,
  rankSpacing: 40,
};

/**
 * CSS 변수 값을 읽어 "rgb(...)" 문자열로 반환한다.
 *
 * @param {string} name CSS 변수 이름 (예: "--color-neutral")
 * @returns {string} "rgb(r, g, b)" 형식의 색상 문자열
 */
function css(name) {
  return "rgb(" + getComputedStyle(document.documentElement).getPropertyValue(name) + ")";
}

/** 라이트 모드에서 Mermaid를 초기화한다. */
function initMermaidLight() {
  mermaid.initialize({
    theme: "base",
    themeVariables: {
      background: css("--color-neutral"),
      primaryColor: css("--color-primary-200"),
      secondaryColor: css("--color-secondary-200"),
      tertiaryColor: css("--color-neutral-100"),
      primaryBorderColor: css("--color-primary-400"),
      secondaryBorderColor: css("--color-secondary-400"),
      tertiaryBorderColor: css("--color-neutral-400"),
      lineColor: css("--color-neutral-600"),
      fontFamily:
        "'SuitMixed', 'Malgun Gothic', 'Noto Sans', Roboto, Pretendard, sans-serif",
      fontSize: _compact.fontSize,
    },
    flowchart: {
      nodeSpacing: _compact.nodeSpacing,
      rankSpacing: _compact.rankSpacing,
    },
  });
}

/** 다크 모드에서 Mermaid를 초기화한다. */
function initMermaidDark() {
  mermaid.initialize({
    theme: "dark",
    themeVariables: {
      fontFamily:
        "'SuitMixed', 'Malgun Gothic', 'Noto Sans', Roboto, Pretendard, sans-serif",
      fontSize: _compact.fontSize,
    },
    flowchart: {
      nodeSpacing: _compact.nodeSpacing,
      rankSpacing: _compact.rankSpacing,
    },
  });
}