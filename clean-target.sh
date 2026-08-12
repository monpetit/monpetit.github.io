#!/bin/bash
set -euo pipefail

# 1. clean.sh가 있는 절대 경로 찾기
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/public"
GIT_PATH="$TARGET_DIR/.git"

echo "[INFO] 스크립트 위치: $SCRIPT_DIR"
echo "[INFO] 대상 디렉토리: $TARGET_DIR"

# 2. 안전 확인: public 디렉토리가 clean.sh 아래에 있는가?
if [ ! -d "$TARGET_DIR" ]; then
  echo "[ERROR] $TARGET_DIR 디렉토리가 없습니다. 중단합니다."
  exit 1
fi

# 3. 안전 확인: public 안에 .git이 있는가? (없으면 오삭제 방지)
if [ ! -e "$GIT_PATH" ]; then
  echo "[ERROR] $GIT_PATH 가 없습니다. .git을 보호하기 위해 중단합니다."
  exit 1
fi

echo "[INFO] .git 확인됨: $GIT_PATH"

# 4. 삭제될 파일 미리보기 (dry-run)
echo ""
echo "--- 아래 파일들이 삭제될 예정입니다 (.git 제외) ---"
find "$TARGET_DIR" -path "$GIT_PATH" -prune -o -type f -print
echo "----------------------------------------------------"
echo ""

# read -p "정말 삭제할까요? [y/N]: " confirm
# if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
#   echo "취소했습니다."
#   exit 0
# fi

# 5. 실제 삭제: 파일만 삭제 (디렉토리 구조는 유지)
# 만약 빈 폴더까지 다 지우고 싶으면 아래 -type f 를 빼고 -mindepth 1 ... -exec rm -rf 로 바꾸면 돼
# find "$TARGET_DIR" -path "$GIT_PATH" -prune -o -type f -exec rm -v {} +
find "$TARGET_DIR" -mindepth 1 -path "$GIT_PATH" -prune -o -exec rm -rf {} +

echo ""
echo "[완료] public에서 .git 제외하고 모든 파일 삭제 완료."
