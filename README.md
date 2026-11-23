# fleet-protocol

一套面向「一名人类负责人 + 多个 AI Agent」协作开发软件的工程规程，以 Agent Skill 的形式发布。

本规程源于真实多 Agent 软件项目的实践，经通用化整理后发布，可直接加载到支持 Agent Skills 的工具中使用。

## 用途

规程把软件协作拆成清晰的角色与可核对的流程，目标是：

1. 负责人的注意力只用于决策；
2. 每个结论都有可复核的证据；
3. 主管 Agent 可随时更换，接手者只读交接文档即可继续。

主要内容：

- 角色与权限：负责人（Owner）、主管 Agent（Lead）、执行 Agent（Implementer）、一审 Agent（Primary Reviewer）、二审与调研 Agent（Secondary Reviewer / Researcher），以及可选的操作协助 Agent 与资料搬运 Agent；
- 任务书、开工规程与经负责人转达的通信机制；
- 测试先行与证据要求；
- 一审、二审、八项合并门、规则预授权合并、合入后验证与回退、在制品上限、叠栈；
- 决策编号、决策公告板（MADR 精简字段）、取代链、台账与交接；
- 调研的来源标准、双来源与反证检索；
- 设计待定清单、token 一致性、图标许可与交付前验图；
- 随附闸门脚本（`scripts/`）：提问闸、提问留痕、状态快照，加载 skill 即可直接运行。

## 适用场景

- 一个人通过多个 AI Agent（可分属不同账号或平台）并行推进同一代码仓库；
- Agent 之间不能直接通信、不会主动读取消息，需由人工转达；
- 需要可追溯的决策记录、可审计的审查与合并流程；
- 主管 Agent 的上下文可能被压缩或更换，需要稳定交接。

不适用于单一 Agent 的轻量任务；对这类任务，规程中的大部分流程属于额外负担。

## 目录结构

```
fleet-protocol/
├── SKILL.md                         核心流程与索引（带 YAML frontmatter）
├── scripts/                         闸门脚本：ask-check.sh、ask-post.sh、snapshot.sh
├── references/
│   ├── glossary.md                  术语表、英文对照、别名与规范用语
│   ├── roles.md                     角色定义、权限矩阵与通信边界
│   ├── lead-handbook.md             主管手册
│   ├── implementer-guide.md         执行 Agent 规程（AGENTS.md 底本）
│   ├── review-and-merge.md          审查、合并门、合并与回退、在制品、叠栈
│   ├── decisions-and-records.md     决策编号、公告板、取代链、台账、交接
│   ├── research.md                  调研方法与来源标准
│   └── design.md                    设计任务规程
├── templates/
│   ├── task-brief.md                任务书
│   ├── report.md                    回报
│   ├── review.md                    审查结论
│   ├── merge-gate-record.md         合并门记录
│   ├── decision-entry.md            决策条目
│   ├── handoff.md                   交接文档
│   └── relay-message.md             转达文本
├── CHANGELOG.md
└── README.md
```

## 安装

将整个目录复制到所用工具的 skills 目录，目录名保持为 `fleet-protocol`：

| 工具 | 项目级 | 用户级 |
|---|---|---|
| Claude Code | `.claude/skills/fleet-protocol/` | `~/.claude/skills/fleet-protocol/` |
| Cursor | `.cursor/skills/fleet-protocol/` | — |
| 其他支持 Agent Skills 的工具 | 按其文档放置 | — |

示例：

```bash
git clone https://github.com/<owner>/fleet-protocol.git .claude/skills/fleet-protocol
```

在具体项目中使用时，建议：

1. 以 `references/implementer-guide.md` 为底本编写项目的 `AGENTS.md`，补充工具版本、命令与目录边界；
2. 编写一个项目开工 skill，写明实际的文件路径、决策公告板与回报位置；
3. 按需收紧阈值（在制品上限、体量上限）；放宽须由负责人决定并登记决策编号。

## 版本

当前版本：3.3.0。版本号遵循语义化版本：

- 主版本：结构或角色定义发生不兼容变化；
- 次版本：新增规则或模板；
- 修订版本：措辞修正与勘误。

变更记录见 [CHANGELOG.md](CHANGELOG.md)。

## 致谢

以下项目与资料提供了方法参考（只采纳方法，未引入代码）：

- [obra/superpowers](https://github.com/obra/superpowers)：任务书写法、两道审查、「没有运行证据不说通过」
- [automazeio/ccpm](https://github.com/automazeio/ccpm)：规格到任务再到并行分支的追踪方法
- [github/spec-kit](https://github.com/github/spec-kit)：规格先行
- [adr/madr](https://github.com/adr/madr)：决策记录字段
- [npryce/adr-tools](https://github.com/npryce/adr-tools)：决策取代的双向链接
- [Google Engineering Practices](https://google.github.io/eng-practices/)：代码审查速度与小改动
- [DORA](https://dora.dev/)：小批量、快速合并与变更失败恢复

## 许可证

MIT License © 2026 Lyvarx，见 [LICENSE](LICENSE)。
