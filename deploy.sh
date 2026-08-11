#!/bin/bash
set -e

# 1. main 브랜치에서 최신 글 빌드
echo ">>> 빌드 시작..."
git checkout main
hugo --minify

# 2. gh-pages 브랜치가 worktree로 연결되어 있는지 확인
# if [ ! -d "public/.git" ]; then
#   echo ">>> gh-pages 브랜치 worktree 추가..."
#   git worktree add -B gh-pages public origin/gh-pages
# fi

# 3. public 디렉토리로 이동해서 커밋/푸시
cd public
echo ">>> gh-pages 브랜치에 커밋 반영..."
git add .
git commit --amend -m "Site updated: $(date '+%Y-%m-%d %H:%M:%S')" || git commit -m "Deploy latest site build"
git push origin gh-pages --force

echo ">>> 배포 완료!"
