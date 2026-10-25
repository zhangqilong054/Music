# Music · HarmonyOS 音乐播放器

基于 HarmonyOS（ArkTS / ArkUI 声明式开发）的仿网易云音乐风格播放器示例，使用 Stage 模型，主要演示页面导航、Tabs 分页、`AVPlayer` 音频播放与 `AppStorageV2` 全局状态管理。

## 功能

| 页面 | 说明 |
| --- | --- |
| 启动页 `Splash` | 3 秒开屏广告倒计时，可点击跳过 |
| 首页 `Home` | 推荐 / 发现 / 动态 / 我的 四个 Tab |
| 推荐 `Recommend` | 搜索框、轮播图、每日推荐、推荐歌单 |
| 发现 `Find` | 歌曲列表，点击进入播放页并开始播放 |
| 动态 `Moment` | 音乐评论动态流 |
| 我的 `Mine` | 用户信息卡片 |
| 播放 `Play` | 黑胶唱盘、进度条、播放控制、播放模式、播放列表（左滑删除） |

## 技术要点

- **状态管理**：`@ObservedV2` + `@Trace` 定义 `GlobalMusic`，通过 `AppStorageV2.connect` 在页面与播放器之间共享当前歌曲、播放列表和播放状态。
- **音频播放**：`PlayManager` 封装 `media.AVPlayer`，监听 `stateChange` / `timeUpdate` / `durationUpdate`，对外提供 `singPlay` / `pause` / `resume` / `prev` / `next` / `changePlay`。
- **页面导航**：`router.replaceUrl` 完成开屏跳转，`router.pushUrl` 进入播放页；`main_pages.json` 注册 `pages/Splash`、`pages/Home`、`pages/Play`。
- **网络媒体**：歌曲与封面来自示例 OSS 地址，需 `ohos.permission.INTERNET` 权限。

## 目录结构

```
Music/
├── AppScope/                     # 应用级配置与图标
├── entry/
│   ├── src/main/ets/
│   │   ├── entryability/         # UIAbility 入口
│   │   ├── model/                # GlobalMusic（全局状态）、SongData（歌曲/动态数据）
│   │   ├── pages/                # Splash / Home / Recommend / Find / Moment / Mine / Play
│   │   └── utills/               # PlayManager 播放控制
│   ├── src/main/resources/       # 字符串、颜色、图片与页面配置
│   └── src/test、src/ohosTest/   # 单元测试与 UI 测试
├── build-profile.json5           # 工程构建配置（含本机签名配置）
├── oh-package.json5              # 依赖与模型版本
└── hvigor/                       # 构建脚本配置
```

## 环境要求

- DevEco Studio 6.0.2 及以上
- HarmonyOS SDK：API 22（`6.0.2(22)`）
- 已在 DevEco Studio 中完成签名配置（自动签名即可）

## 运行

1. 使用 DevEco Studio 打开本工程根目录。
2. 等待 `Sync` 完成（首次会下载 `oh_modules` 依赖）。
3. 选择 `entry` 模块与真机/模拟器，点击 Run。

命令行构建需先由 DevEco Studio 生成 `hvigorw` 包装脚本，再执行：

```bash
hvigorw --mode module -p product=default -p buildMode=debug assembleHap
```

## 已知问题

- 媒体资源使用第三方示例 OSS 的 HTTP 地址，若目标 SDK 默认禁止明文传输，需自行配置 `network_config`。
- 未处理 `AVPlayer` 的 `error` 回调，网络异常时界面没有提示；退出播放页也未 `release()` 播放器。
- 示例资源（封面、音频）来自公开 OSS，可能随时失效。

## 更新记录

- 修复播放列表删空后点击播放/上一首/下一首导致的崩溃。
- 歌曲播放结束自动切歌，`repeat` 模式等价单曲循环。
- 进度条支持拖动定位（松手后 seek）。
- 修正「我的」页面高度溢出与「发现」页面高度塌陷问题。

欢迎提交 Issue 或 PR。

## License

未指定开源许可证，默认保留所有权利。
