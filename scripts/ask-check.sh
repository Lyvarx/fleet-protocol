#!/usr/bin/env bash
# 提问闸（§4 第 6 条）：主管向负责人提产品或技术方案前，调研文件必须过本脚本。
# 用法：bash scripts/ask-check.sh <调研文件.md>
# 要求文件里有「## 同类对标」一节（可有多节，如「## 同类对标（第 5 条）」），合计：
#   - 至少 2 行带一手链接（http/https）；
#   - 至少 1 行同市场先例：默认标 [同市场]；项目可用 MARKET_RE 改成本市场产品名正则；
#   - 至少 1 行「反例」；至少 1 行「对标行」（头部产品怎么做｜我们怎么做｜差距与补法）。
# 另查禁用表述：推断、没核实、应该是、大概、我猜。
f="$1"; [ -f "$f" ] || { echo "FAIL 无调研文件"; exit 1; }
sec=$(awk '/^## 同类对标/{p=1;next} /^## /{p=0} p' "$f")
[ -n "$sec" ] || { echo "FAIL 缺「## 同类对标」节"; exit 1; }
n=$(grep -cE 'https?://' <<<"$sec")
mk=$(grep -E 'https?://' <<<"$sec" | grep -cE "${MARKET_RE:-\\[同市场\\]}")
grep -q '反例' <<<"$sec" || { echo "FAIL 缺反例"; exit 1; }
grep -q '对标行' <<<"$sec" || { echo "FAIL 缺对标行"; exit 1; }
[ "$n" -ge 2 ] || { echo "FAIL 一手链接少于 2 条（$n）"; exit 1; }
[ "$mk" -ge 1 ] || { echo "FAIL 无 [同市场] 先例"; exit 1; }
bad=$(grep -nE '推断|没核实|应该是|大概|我猜' "$f" | head -3)
[ -z "$bad" ] || { echo "FAIL 禁用表述：$bad"; exit 1; }
echo "PASS 链接 $n 条，同市场 $mk 条"
