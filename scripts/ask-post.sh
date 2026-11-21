#!/usr/bin/env bash
# 提问留痕（§2 第 1 条、§4 第 6 条）：过提问闸后，把问题原文、闸门结果与调研全文发到决策公告板，返回评论链接。
# 拿不到链接不得提问；负责人答复后，决策条目写「问题：<链接>」「负责人原话：…（时间）」。
# 用法：BOARD=<owner/repo#issue> bash scripts/ask-post.sh <编号> <调研文件> <问题原文文件>
# 依赖：gh（已登录）。
set -e
id="$1"; res="$2"; q="$3"; here="$(dirname "$0")"
: "${BOARD:?设置 BOARD=owner/repo#issue}"
repo="${BOARD%#*}"; issue="${BOARD#*#}"
r=$(bash "$here/ask-check.sh" "$res") || { echo "$r"; echo "闸门未过，不得提问"; exit 1; }
body="$(printf '## 提问 · %s · %s\n\n**问题原文**\n\n%s\n\n**提问闸**：%s\n\n<details><summary>调研全文</summary>\n\n%s\n\n</details>\n' \
  "$id" "$(date -u '+%F %H:%M UTC')" "$(cat "$q")" "$r" "$(cat "$res")")"
url=$(gh issue comment "$issue" -R "$repo" --body "$body")
[ -n "$url" ] || { echo "发布失败，不得提问"; exit 1; }
echo "$url"
