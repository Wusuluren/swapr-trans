(function () {
  "use strict";

  const strings = {
    zh: {
      pageTitle: "SwaprTrans · 选词即翻，回车原位掉包",
      brandSubtitle: "原位掉包翻译",
      skip: "跳转到主要内容",
      navDemo: "实时演示",
      navWorkflow: "工作流",
      navFeatures: "核心特性",
      navPrivacy: "隐私安全",
      navSdk: "开发库",
      navInstall: "下载安装",
      ctaDownload: "下载 DMG",
      navGitHub: "GitHub 仓库",

      // Hero
      eyebrow: "macOS 15+ 端侧原生驱动 · 全局划词即时翻译与原地掉包",
      heroTitle1: "选词即翻",
      heroTitle2: "回车原位掉包",
      heroLede:
        "彻底打破“划选 → 复制 → 切换窗口 → 粘贴 → 翻译 → 复制回来”的传统割裂链路。在任意聊天框（Teams、Slack、微信、邮件、终端）中划选文字并按下快捷键，轻敲一次回车键，原文即刻原地蜕变为地道外文！",
      ctaPrimary: "下载 SwaprTrans v1.0.0 (DMG)",
      ctaSecondary: "查看源码仓库",
      badgeApple: "Apple 官方神经引擎",
      badgePrivacy: "100% 隐私·不上云",
      badgeFailover: "三引擎智能容灾",
      badgeLightweight: "极致轻量 < 2MB",

      // Demo Stage
      demoHeaderTitle: "Teams / Slack 原地沟通体验",
      demoInputLabel: "当前输入区（无需切换焦点）",
      hudHintSwap: "↵ Enter 原地替换",
      hudHintClose: "Esc 关闭",
      demoSwappedBadge: "✨ 已原位覆写 (In-Place Swapped)",
      demoPill1: "🏢 职场协作",
      demoPill2: "💻 技术开发",
      demoPill3: "✉️ 商务沟通",
      demoPill4: "🔀 英译中反向",

      // Workflow
      workflowEyebrow: "三步闭环",
      workflowTitle: "极简原位蜕变，全程无感打扰",
      workflowDesc: "无需窗口切换，无需复杂操作，专为高频打字与高专注度工作流设计。",
      step1Title: "1. 划选文本与全局唤起",
      step1Body: "在任意支持光标选区的文本框（聊天软件、浏览器、IDE、邮件）中划选文字，触发全局快捷键。",
      step2Title: "2. 离线神经模型毫秒直达",
      step2Body: "基于 Apple 官方 Translation.framework 端侧芯片秒级推理，辅以 Edge 与 Google 双通道多级容灾。",
      step3Title: "3. 轻敲 Enter，原文掉包蜕变",
      step3Body: "无需移动光标，无需复制粘贴，轻敲一下 Enter 回车键，原文瞬间平滑蜕变为高水准译文。",

      // Features
      featuresEyebrow: "核心特性",
      featuresTitle: "为专业工作者打造的高性能生产力工具",
      featuresDesc: "纯 Swift 原生架构，极速响应，安全私密，开箱即用。",
      feat1Title: " Apple 官方原生端侧模型",
      feat1Body: "深度集成 macOS 15+ 官方系统级 Translation.framework 原生神经引擎驱动。纯芯片本地离线运算，完全零网络依赖，商业机密与私密沟通 100% 隐私安全。",
      feat2Title: "独创「原位掉包」交互",
      feat2Body: "彻底消灭划词后的多余鼠标拖动与粘贴动作。浮窗浮起后，轻触 Enter 键即由 SwaprTrans 自动完成原位覆写，行云流水。",
      feat3Title: "绝不抢焦点的毛玻璃浮窗",
      feat3Body: "浮窗浮起时光标与选区完好如初，不打断键盘输入节奏，支持深浅色自适应与自动消失倒计时。",
      feat4Title: "三引擎智能协同与容灾降级",
      feat4Body: "默认使用 Apple Native 离线端侧引擎；网络环境下支持 Microsoft Edge 极速免 Key 通道与 Google Translate 多链路自动平滑兜底。",
      feat5Title: "双向智能语种识别",
      feat5Body: "中英混合或任意语种自适应识别，中文自动转化为地道英文，外文自动转化为精准中文，无需频繁手动切换语向。",
      feat6Title: "完全开源的 SwaprTransKit 模块库",
      feat6Body: "不仅是一款独立的菜单栏应用，更以 Swift Package (SPM) 库完整开放。只需在 Package.swift 中引入依赖，即可在你的 macOS 应用中直接调用设置面板与翻译服务。",

      // Privacy
      privacyEyebrow: "隐私承诺",
      privacyTitle: "本地端侧优先，数据永不上云",
      privacyBody: "SwaprTrans 坚守纯粹的开源与隐私理念。我们不收集任何个人数据，代码完全透明可审计。",
      priv1Title: "本地端侧神经运算",
      priv1Desc: "默认使用 Apple Native 神经引擎，翻译运算全程在本地芯片完成，不产生任何外发请求。",
      priv2Title: "绝不收集与上传输入文本",
      priv2Desc: "没有后台分析服务，没有遥测代码，不收集任何用户输入内容与应用使用习惯。",
      priv3Title: "密码框与隐私跳过",
      priv3Desc: "检测到安全输入框或密码字段时自动规避，杜绝敏感凭据泄露风险。",
      priv4Title: "100% 开源透明",
      priv4Desc: "所有源代码在 GitHub 开源，构建脚本全公开，任何人均可自由审查与本地编译。",

      // Install
      installEyebrow: "安装使用",
      installTitle: "快速安装与配置",
      tabDmg: "DMG 安装包（推荐）",
      tabSource: "从源码编译安装",
      dmgStep1: "下载最新版本的 <strong>SwaprTrans-1.0.0.dmg</strong> 安装包；",
      dmgStep2: "双击打开 DMG 文件，将 <strong>SwaprTrans.app</strong> 拖拽至 <strong>Applications</strong> 应用程序文件夹；",
      dmgStep3: "首次打开：由于当前采用个人 Ad-hoc 签名，若遇系统拦截提示，请在 Finder 中<strong>右键点击 SwaprTrans.app → 点击「打开」</strong>；",
      dmgStep4: "授权：首次启动后，请按 macOS 引导授予<strong>「辅助功能」(Accessibility)</strong> 权限，以支持实时光标定位与选区原地掉包。",
      btnDownloadDmg: "立即下载 SwaprTrans-1.0.0.dmg (1.9MB)",
      srcHint: "克隆仓库后，在终端执行一键安装脚本即可就地编译并安装到 /Applications：",

      // SDK
      sdkEyebrow: "开发者集成",
      sdkTitle: "通过 Swift Package Manager 接入",
      sdkDesc: "将 SwaprTransKit 作为依赖引入到你自己的 macOS App 中：",

      // Footer
      footerCopy: "SwaprTrans · 专为 macOS 设计的全局划词翻译与原位掉包工具。",
      footerLicense: "基于 MIT 开源协议发布",
    },

    en: {
      pageTitle: "SwaprTrans · Select, Translate, In-Place Swap",
      brandSubtitle: "In-Place Swap Translator",
      skip: "Skip to main content",
      navDemo: "Live Demo",
      navWorkflow: "Workflow",
      navFeatures: "Features",
      navPrivacy: "Privacy",
      navSdk: "SPM SDK",
      navInstall: "Download",
      ctaDownload: "Download DMG",
      navGitHub: "GitHub Repo",

      // Hero
      eyebrow: "macOS 15+ Native On-Device Engine · Global In-Place Swap Translation",
      heroTitle1: "Select to Translate",
      heroTitle2: "Enter to Swap In-Place",
      heroLede:
        "Completely breaks the tedious chain of 'select → copy → switch app → paste → translate → copy back'. In any chat or text input (Teams, Slack, WeChat, Mail, Terminal), select text, hit your shortcut, and press Enter—the original text instantly transforms in-place into natural translation!",
      ctaPrimary: "Download SwaprTrans v1.0.0 (DMG)",
      ctaSecondary: "View on GitHub",
      badgeApple: "Apple Native Neural Engine",
      badgePrivacy: "100% Private · On-Device",
      badgeFailover: "Tri-Engine Failover",
      badgeLightweight: "Ultra Lightweight < 2MB",

      // Demo Stage
      demoHeaderTitle: "Teams / Slack In-Place Experience",
      demoInputLabel: "Current Input Area (No Focus Loss)",
      hudHintSwap: "↵ Enter In-Place Swap",
      hudHintClose: "Esc Close",
      demoSwappedBadge: "✨ In-Place Swapped",
      demoPill1: "🏢 Team Collab",
      demoPill2: "💻 Dev Chat",
      demoPill3: "✉️ Business Mail",
      demoPill4: "🔀 English to Chinese",

      // Workflow
      workflowEyebrow: "Workflow",
      workflowTitle: "A 3-Step Closed Loop with Zero Distraction",
      workflowDesc: "No app switching, no copy-pasting, crafted specifically for deep focus writing sessions.",
      step1Title: "1. Select Text & Global Trigger",
      step1Body: "Highlight any text in any text area (Slack, browser, IDE, email) and press your global shortcut.",
      step2Title: "2. Millisecond Neural Model Inference",
      step2Body: "Powered by Apple Translation.framework on-device neural engine with Edge & Google automatic failover.",
      step3Title: "3. Press Enter, Instant In-Place Swap",
      step3Body: "Without losing keyboard focus, tap Enter once—original text transforms smoothly into authentic translation.",

      // Features
      featuresEyebrow: "Features",
      featuresTitle: "Built for Power Users Demanding Peak Efficiency",
      featuresDesc: "Pure Swift native architecture, blazing fast, fully private and ready out of the box.",
      feat1Title: " Apple Official Native Neural Engine",
      feat1Body: "Deeply integrated with macOS 15+ Translation.framework. Computes entirely on local Apple Silicon chips with zero network reliance—business secrets and confidential chats stay 100% private.",
      feat2Title: "Signature 'In-Place Swap' Interaction",
      feat2Body: "Eliminates repetitive mouse dragging and pasting. When HUD floats, simply tap Enter to let SwaprTrans atomically replace the text in-place.",
      feat3Title: "Non-Activating Glassmorphism HUD",
      feat3Body: "Floating HUD never steals window focus. Cursor position and selections remain intact, with adaptive dark/light appearance and auto-dismiss timer.",
      feat4Title: "Tri-Engine Intelligent Failover",
      feat4Body: "Defaults to Apple Native offline engine. Gracefully falls back to Microsoft Edge high-speed keyless channel and Google Translate seamlessly.",
      feat5Title: "Bidirectional Auto Language Detection",
      feat5Body: "Intelligently identifies input language—transforms Chinese into authentic English, and foreign text into accurate Chinese automatically.",
      feat6Title: "Fully Open Source SwaprTransKit (SPM)",
      feat6Body: "Not just a standalone menu bar app; the core engine is packaged as an open-source Swift Package. Embed settings UI and translation services into your app with one line in Package.swift.",

      // Privacy
      privacyEyebrow: "Privacy",
      privacyTitle: "On-Device First, Never Leaves Your Mac",
      privacyBody: "SwaprTrans adheres strictly to open-source transparency. We collect zero personal data, and code is 100% auditable.",
      priv1Title: "Local Chip Inference",
      priv1Desc: "Defaults to Apple Native Neural Engine. Translations are computed entirely on-device with zero outgoing requests.",
      priv2Title: "Zero Telemetry & Zero Logging",
      priv2Desc: "No tracking SDKs, no analytics, and we never log or transmit what you type.",
      priv3Title: "Secure Password Field Skipping",
      priv3Desc: "Automatically ignores secure text and password fields to protect sensitive credentials.",
      priv4Title: "100% Open Source Transparency",
      priv4Desc: "Source code and build scripts are fully open on GitHub, open for community audit and local compilation.",

      // Install
      installEyebrow: "Installation",
      installTitle: "Quick Start & Setup",
      tabDmg: "DMG Installer (Recommended)",
      tabSource: "Build from Source",
      dmgStep1: "Download the latest <strong>SwaprTrans-1.0.0.dmg</strong> release asset;",
      dmgStep2: "Open the DMG and drag <strong>SwaprTrans.app</strong> into your <strong>Applications</strong> folder;",
      dmgStep3: "First Launch: Due to ad-hoc personal signing, if blocked by Gatekeeper, right-click <strong>SwaprTrans.app → Open</strong> in Finder;",
      dmgStep4: "Permissions: On first run, grant <strong>Accessibility</strong> permission to allow real-time selection detection and in-place replacement.",
      btnDownloadDmg: "Download SwaprTrans-1.0.0.dmg (1.9MB)",
      srcHint: "Clone the repository and run the install script in Terminal to compile and deploy to /Applications:",

      // SDK
      sdkEyebrow: "Developer SDK",
      sdkTitle: "Integrate via Swift Package Manager",
      sdkDesc: "Add SwaprTransKit as a package dependency in your macOS app:",

      // Footer
      footerCopy: "SwaprTrans · The lightweight native in-place translation tool for macOS.",
      footerLicense: "Released under the MIT License",
    },
  };

  const scenarios = [
    {
      zh: {
        input: "这个架构方案性能测试表现优异，建议下周合并主分支。",
        lang: "🇨🇳 中文 ➔ 🇬🇧 英语",
        engine: "Apple 神经引擎",
        trans: "This architecture design performed exceptionally well in benchmark tests. Recommended to merge to main next week.",
      },
      en: {
        input: "这个架构方案性能测试表现优异，建议下周合并主分支。",
        lang: "🇨🇳 Chinese ➔ 🇬🇧 English",
        engine: "Apple Neural Engine",
        trans: "This architecture design performed exceptionally well in benchmark tests. Recommended to merge to main next week.",
      },
    },
    {
      zh: {
        input: "基于端侧芯片运行离线模型，可以确保机密信息永不上云。",
        lang: "🇨🇳 中文 ➔ 🇬🇧 英语",
        engine: "Apple 本地端侧",
        trans: "Running offline models on local Apple Silicon ensures confidential information never touches the cloud.",
      },
      en: {
        input: "基于端侧芯片运行离线模型，可以确保机密信息永不上云。",
        lang: "🇨🇳 Chinese ➔ 🇬🇧 English",
        engine: "Apple On-Device",
        trans: "Running offline models on local Apple Silicon ensures confidential information never touches the cloud.",
      },
    },
    {
      zh: {
        input: "期待与贵司团队建立长期稳固的合作关系，共促业务增长。",
        lang: "🇨🇳 中文 ➔ 🇬🇧 英语",
        engine: "Apple 神经引擎",
        trans: "We look forward to establishing a solid, long-term partnership with your team to drive mutual business growth.",
      },
      en: {
        input: "期待与贵司团队建立长期稳固的合作关系，共促业务增长。",
        lang: "🇨🇳 Chinese ➔ 🇬🇧 English",
        engine: "Apple Neural Engine",
        trans: "We look forward to establishing a solid, long-term partnership with your team to drive mutual business growth.",
      },
    },
    {
      zh: {
        input: "Could you please clarify the expected delivery timeline for this milestone?",
        lang: "🇬🇧 英语 ➔ 🇨🇳 中文",
        engine: "双向智能侦测",
        trans: "请问能说明一下该里程碑预期的交付时间节点吗？",
      },
      en: {
        input: "Could you please clarify the expected delivery timeline for this milestone?",
        lang: "🇬🇧 English ➔ 🇨🇳 Chinese",
        engine: "Bidirectional Auto",
        trans: "请问能说明一下该里程碑预期的交付时间节点吗？",
      },
    },
  ];

  const root = document.documentElement;
  const langButtons = document.querySelectorAll("[data-set-lang]");
  const textStream = document.getElementById("text-stream");
  const swaprHud = document.getElementById("swapr-hud");
  const hudLangTag = document.getElementById("hud-lang-tag");
  const hudEngineTag = document.getElementById("hud-engine-tag");
  const hudTranslation = document.getElementById("hud-translation");
  const enterKbd = document.getElementById("enter-kbd");
  const stagePills = document.querySelectorAll(".stage-pill");

  let currentLang = localStorage.getItem("st-lang") || (navigator.language?.startsWith("zh") ? "zh" : "zh");
  let activeScenarioIndex = 0;
  let demoTimer = 0;
  let demoToken = 0;

  function t(key) {
    return strings[currentLang][key] ?? strings.zh[key] ?? key;
  }

  function applyLanguage(next) {
    currentLang = next in strings ? next : "zh";
    localStorage.setItem("st-lang", currentLang);
    root.lang = currentLang === "zh" ? "zh-CN" : "en";
    document.title = t("pageTitle");

    document.querySelectorAll("[data-i18n]").forEach((el) => {
      const key = el.getAttribute("data-i18n");
      if (!key) return;
      const value = t(key);
      if (el.getAttribute("data-html") === "true") {
        el.innerHTML = value;
      } else {
        el.textContent = value;
      }
    });

    langButtons.forEach((btn) => {
      btn.setAttribute("aria-pressed", String(btn.getAttribute("data-set-lang") === currentLang));
    });

    restartDemo();
  }

  function sleep(ms, token) {
    return new Promise((resolve, reject) => {
      demoTimer = window.setTimeout(() => {
        if (token !== demoToken) reject(new Error("cancelled"));
        else resolve();
      }, ms);
    });
  }

  async function runDemo(token) {
    if (!textStream || !swaprHud) return;

    const data = scenarios[activeScenarioIndex][currentLang];

    // Reset state
    textStream.innerHTML = "";
    swaprHud.classList.remove("is-visible");
    enterKbd.classList.remove("active");

    stagePills.forEach((pill, idx) => {
      pill.classList.toggle("active", idx === activeScenarioIndex);
    });

    try {
      // 1. Type out original sentence
      for (let i = 1; i <= data.input.length; i++) {
        textStream.textContent = data.input.slice(0, i);
        await sleep(35 + (i % 4 === 0 ? 30 : 0), token);
      }

      await sleep(400, token);

      // 2. Highlight / select text
      textStream.innerHTML = `<span class="text-selected">${data.input}</span>`;
      await sleep(350, token);

      // 3. Float SwaprTrans HUD
      hudLangTag.textContent = data.lang;
      hudEngineTag.textContent = `⚡ ${data.engine}`;
      hudTranslation.textContent = data.trans;
      swaprHud.classList.add("is-visible");

      await sleep(1400, token);

      // 4. Simulate pressing Enter key
      enterKbd.classList.add("active");
      await sleep(220, token);
      enterKbd.classList.remove("active");

      // 5. In-Place Swap!
      swaprHud.classList.remove("is-visible");
      textStream.innerHTML = `<span class="text-replaced">${data.trans}</span>`;

      // 6. Pause to let user appreciate the swap
      await sleep(3600, token);

      // 7. Next scenario
      activeScenarioIndex = (activeScenarioIndex + 1) % scenarios.length;
      if (token === demoToken) {
        runDemo(token);
      }
    } catch {
      /* cancelled */
    }
  }

  function restartDemo() {
    demoToken += 1;
    window.clearTimeout(demoTimer);
    runDemo(demoToken);
  }

  // Language buttons
  langButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const next = btn.getAttribute("data-set-lang");
      if (next) applyLanguage(next);
    });
  });

  // Stage pills
  stagePills.forEach((pill, index) => {
    pill.addEventListener("click", () => {
      activeScenarioIndex = index;
      restartDemo();
    });
  });

  // Installation tabs
  const tabButtons = document.querySelectorAll(".install-tab-btn");
  const tabPanels = document.querySelectorAll(".install-panel");
  tabButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const targetId = btn.getAttribute("data-tab");
      tabButtons.forEach((b) => b.classList.remove("active"));
      tabPanels.forEach((p) => p.classList.remove("active"));
      btn.classList.add("active");
      const targetPanel = document.getElementById(targetId);
      if (targetPanel) targetPanel.classList.add("active");
    });
  });

  applyLanguage(currentLang);
})();
