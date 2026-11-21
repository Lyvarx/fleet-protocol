#!/usr/bin/env bash
# 状态快照（§8 第 9 条）：不调用模型。负责人回场、主管提问前各跑一次。
# 用法：REPO=owner/repo PENDING=pending.csv bash scripts/snapshot.sh
# pending.csv 表头：id,impact,item,recommend,raised,defer_until,status（status：open / blocked:<原因> / done）
: "${REPO:?设置 REPO=owner/repo}"; P="${PENDING:-pending.csv}"; t=$(date +%F)
echo "## 等待拍板"; [ -f "$P" ] && awk -F, -v t="$t" 'NR>1&&$7=="open"&&($6==""||$6<=t){print $2"\t"$1" "$3"｜建议："$4}' "$P" | sort | cut -f2
echo; echo "## 刚落地（24 小时内合并）"
gh pr list -R "$REPO" --state merged --limit 30 --json number,title,mergedAt \
  --jq --arg s "$(date -u -d '-24 hours' +%FT%TZ)" '.[]|select(.mergedAt>$s)|"#\(.number) \(.title)"' 2>/dev/null \
  || gh pr list -R "$REPO" --state merged --limit 10 --json number,title --jq '.[]|"#\(.number) \(.title)"'
echo; echo "## 进行中"; gh pr list -R "$REPO" --state open --json number,title,author,isDraft,updatedAt --jq '.[]|"#\(.number) \(.title)｜\(.author.login)｜\(if .isDraft then "草稿" else "待审" end)｜\(.updatedAt[0:16])"'
echo; echo "## 卡住（12 小时无更新）"; gh pr list -R "$REPO" --state open --json number,title,updatedAt --jq "map(select(.updatedAt < \"$(date -u -d '-12 hours' +%FT%TZ)\"))[]|\"#\(.number) \(.title)\""
echo; echo "## 推迟中"; [ -f "$P" ] && awk -F, -v t="$t" 'NR>1&&$7=="open"&&$6>t{print $1" "$3"｜到期 "$6}' "$P"
echo; echo "## 暂停或并入（不单独问）"; [ -f "$P" ] && awk -F, 'NR>1&&$7~/^blocked/{print $1" "$3"｜"$7}' "$P"
