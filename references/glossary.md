# 术语表（Glossary）

本规程中同一概念只使用一个名称。下表给出正式术语、英文对照与定义；「别名」一栏列出历史或口头叫法，别名只在本表出现，规程正文与模板不得使用。

## 1. 规范用语

参照 RFC 2119 / RFC 8174 的中文对应：

| 中文 | 英文 | 含义 |
|---|---|---|
| 必须 | MUST | 绝对要求 |
| 不得 | MUST NOT | 绝对禁止 |
| 应 | SHOULD | 推荐做法；不遵循时须有充分理由并在记录中说明 |
| 不应 | SHOULD NOT | 不推荐；采用时须有充分理由并在记录中说明 |
| 可 | MAY | 可选 |

## 2. 角色

| 正式术语 | 英文 | 定义 | 别名 |
|---|---|---|---|
| 负责人 | Owner | 人类决策者，对方向、产品与高风险操作拥有最终决定权 | 船长 |
| 主管 Agent（简称「主管」） | Lead | 唯一负责派单、审查判断、合并与记录的 Agent | 总控 |
| 执行 Agent | Implementer | 按任务书承办实现、文档或调研产出的 Agent；按领域分为后端与契约、客户端与 CI、设计系统、文档与调研 | 船员 |
| 一审 Agent | Primary Reviewer | 对每个 PR 逐行全量审查的独立 Agent | 船员 |
| 二审与调研 Agent（简称「二审 Agent」） | Secondary Reviewer / Researcher | 对高风险 PR 做第二道审查，并默认承接调研的独立 Agent | 船员 |
| 操作协助 Agent | Operator Assistant | 可选。逐步协助负责人完成本人操作（证书、平台后台设置等），不访问仓库 | 陪办员 |
| 资料搬运 Agent | Courier | 可选。按交接单在账号或存储之间搬运资料，不作判断 | 摆渡员 |
| 临时主管 | Interim Lead | 主管不可用时承担衔接的 Agent；不替代主管，主管恢复后按交接文档接回 | — |

本规程历史上称作「舰队规程」：舰队指整个协作团队，船长指负责人，主管指主管 Agent，船员泛指执行 Agent 与审查 Agent。

## 3. 文档与记录

| 正式术语 | 英文 | 定义 |
|---|---|---|
| 任务书 | Task Brief | 主管发给执行 Agent 或审查 Agent 的、可独立读懂的工作说明，模板见 `templates/task-brief.md` |
| 修正单 | Revision Notice | 主管对已派任务的补充或更正，格式同任务书，注明修订内容 |
| 回报 | Report | 执行 Agent 或审查 Agent 交付结果的正式记录，模板见 `templates/report.md` |
| 转达文本 | Relay Message | 主管写给负责人、可直接转发给目标 Agent 的文本，模板见 `templates/relay-message.md` |
| 开工 skill | Start-of-Work Skill | 项目提供的、执行 Agent 开工时首先加载的 skill，内容含开工规程与项目入口 |
| 开工规程 | Start-of-Work Procedure | 执行 Agent 每次开工的固定步骤，三行版附在每份任务书文末 |
| 决策记录 | Decision Log | 仓库内只追加的已定决策文件 |
| 决策编号 | Decision ID | 形如 `D-YYYYMMDD-NN` 的唯一编号 |
| 决策公告板 | Decision Board | 公示已定决策的固定 Issue；可与任务书留档合一 |
| 任务书留档 | Brief Archive | 存放任务书全文的固定 Issue 或目录，执行 Agent 上下文压缩后从此回读 |
| 派单台账 | Dispatch Ledger | 登记「任务号｜执行 Agent｜回报位置｜状态」的文件 |
| 状态流水 | Status Log | 按时间记录问答与状态变化的文件 |
| 负责人事项 | Owner Actions | 只能由负责人本人办理的事项清单与完成记录 |
| 缺口清单 | Gap List | 已知未实现项，每行写第一版做法与承办者 |
| 交接文档 | Handoff | 当前有效状态的唯一文档，就地更新，模板见 `templates/handoff.md` |
| 合并门记录 | Merge Gate Record | 合并前逐项核对的记录，模板见 `templates/merge-gate-record.md` |
| 待负责人 | Pending Owner | 需要负责人决定的事项；每条必须引用决策编号，或注明「已查公告板，无决策编号」 |
| 资料交接单 | Courier Order | 主管写给资料搬运 Agent 的搬运清单 |

## 4. 流程

| 正式术语 | 英文 | 定义 |
|---|---|---|
| 出发点 | Origin | 任务存在的理由：负责人原话、决策编号或规格条目 |
| 落脚点 | Landing Point | 产出在哪里被读取、用户看到什么结果 |
| 一审 | Primary Review | 每个 PR 必经的逐行全量审查 |
| 二审 | Secondary Review | 高风险类 PR 的第二道独立审查 |
| 合并门 | Merge Gate | 合并前必须全部通过的八项检查 |
| 规则预授权合并 | Rule-Based Pre-authorized Merge | 满足既定条件时由主管直接合并、事后汇报的机制 |
| 带条件通过 | Approve with Conditions | 一审仅余 Minor 问题时的结论；作者修改后由主管核 diff 即可合并 |
| 新鲜度 | Freshness | 审查与 CI 结论对应的 head sha 与当前 head 一致 |
| 在制品上限 | WIP Limit | 同时开着、未合并的 PR 数量上限 |
| 叠栈 | Stacked PRs | 以另一个未合并 PR 分支为 base 的 PR 串 |
| 合入后验证 | Post-merge Verification | 合并后在 main 上运行完整 CI 的做法 |
| 回退 PR | Revert PR | 内容正好是原 squash 提交反向 diff 的 PR |
| 定时巡检 | Scheduled Patrol | 负责人离场期间由主管按固定间隔执行的状态检查 |
| 主动体检 | Health Check | 主管每次汇报前的固定检查项 |
| 停手 | Stop and Escalate | 执行 Agent 停止工作并上报卡点 |

## 5. 问题分级

| 级别 | 英文 | 处理 |
|---|---|---|
| 严重 | Critical | 立即修复；修复后必须复审 |
| 重要 | Important | 合并前修复；修复后必须复审 |
| 次要 | Minor | 可带条件通过；由主管记录并派单 |

## 6. 环境

| 正式术语 | 英文 | 定义 |
|---|---|---|
| 自建 runner | Self-hosted Runner | 运行在自有机器上的 CI 执行器 |
| 环境故障 | Environment Failure | 由网络、代理、runner 或外部服务引起、与代码无关的失败 |
| 大文件对象 | Large File Object | 由 Git LFS 等机制管理的文件本体，区别于仓库中的指针文件 |
