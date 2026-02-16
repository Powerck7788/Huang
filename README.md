# 性能優化工具包 / Performance Optimization Toolkit

[English](#english) | [中文](#中文)

---

## 中文

> **🎯 只看得懂中文？**  
> 👉 **[快速開始指南 (快速開始.md)](快速開始.md)** - 一分鐘快速上手！  
> 👉 **[詳細安裝指南 (INSTALL_ZH.md)](INSTALL_ZH.md)** - 完整安裝說明  
> 👉 **[AI 自動化部署指南 (AI_DEPLOY_ZH.md)](AI_DEPLOY_ZH.md)** - 🤖 AI 專用部署通道  
> 👉 或直接執行：`./安裝.sh` 開始自動安裝流程

### 你能處理什麼事？/ What Can This Handle?

這個儲存庫提供了一個全面的**性能優化框架和工具包**，可以幫助你：

#### 🎯 核心功能

1. **前端性能優化**
   - Bundle（套件）大小分析和優化
   - 程式碼分割和樹搖（Tree Shaking）
   - 資源載入優化
   - 圖片優化策略

2. **效能監控**
   - Core Web Vitals（核心網頁指標）監控
   - 自定義效能指標追蹤
   - 即時效能分析
   - Bundle（套件）大小檢查

3. **建構優化**
   - Webpack 配置優化
   - 生產環境建構優化
   - 快取策略
   - CDN（內容傳遞網路）部署優化

4. **資料庫和 API 優化**
   - 查詢優化建議
   - API 回應優化
   - 分頁策略
   - N+1 查詢解決方案

5. **框架特定優化**
   - React 效能優化模式
   - Vue.js 優化技巧
   - CSS-in-JS 優化
   - 關鍵 CSS 提取

6. **🤖 AI 自動化部署**
   - AI 專用部署通道
   - 一鍵自動化部署
   - 多環境支持（預覽/測試/生產）
   - 完整的部署監控和日誌

#### 📦 提供的工具

- **自動化設置腳本** (`scripts/performance-setup.sh`)
  - 一鍵安裝所有效能監控工具
  - 自動配置 webpack、Lighthouse、size-limit
  - 建立效能監控工具函式
  - 設置 CI/CD 整合

- **完整文件**
  - `PERFORMANCE_ANALYSIS.md` - 詳細的優化指南
  - `PERFORMANCE_SUMMARY.md` - 快速參考摘要
  - 程式碼範例和最佳實踐

- **CI/CD 整合**
  - GitHub Actions 工作流程
  - 自動 bundle 大小檢查
  - 效能回歸測試
  - Lighthouse 審查

- **🤖 AI 自動化部署系統**
  - AI 專用部署工作流程 (`.github/workflows/ai-deploy.yml`)
  - 自動化部署腳本 (`scripts/ai-deploy.sh`)
  - 完整的中文部署指南 (`AI_DEPLOY_ZH.md`)
  - 支持多種觸發方式（手動、標籤、分支）

#### 🚀 快速開始

**方法一：使用中文自動安裝腳本（推薦）**

```bash
# 1. 複製儲存庫
git clone https://github.com/Powerck7788/Huang.git
cd Huang

# 2. 執行中文自動安裝腳本
./安裝.sh

# 腳本會引導您完成所有安裝步驟！
# 詳細說明請參考：INSTALL_ZH.md
```

**方法二：使用英文安裝腳本**

```bash
# 1. 複製儲存庫
git clone https://github.com/Powerck7788/Huang.git
cd Huang

# 2. 執行效能設置腳本（當你開始開發時）
./scripts/performance-setup.sh

# 3. 安裝依賴
npm install

# 4. 使用效能工具
npm run build:analyze  # 分析 bundle 大小
npm run lighthouse     # 執行 Lighthouse 審查
npm run size-limit     # 檢查大小限制
```

#### 📊 效能目標

| 指標 | 目標值 | 工具 |
|------|--------|------|
| JavaScript Bundle | < 200KB (gzipped) | size-limit |
| CSS Bundle | < 50KB (gzipped) | size-limit |
| First Contentful Paint | < 1.8s | Lighthouse |
| Largest Contentful Paint | < 2.5s | Web Vitals |
| First Input Delay | < 100ms | Web Vitals |
| Cumulative Layout Shift | < 0.1 | Web Vitals |

#### 💡 使用場景

這個工具包適合：
- 🏗️ 新專案開始時建立效能基準
- 📈 現有專案的效能優化
- 🔍 識別效能瓶頸
- 📊 持續效能監控
- 🎓 學習效能優化最佳實踐

#### 🛠️ 支援的技術棧

- **前端框架**: React, Vue.js, Angular
- **建構工具**: Webpack, Vite, Rollup
- **監控**: Lighthouse, Web Vitals, Bundle Analyzer
- **CI/CD**: GitHub Actions, 可擴展到其他平台

---

## English

### What Can This Handle?

This repository provides a comprehensive **Performance Optimization Framework and Toolkit** that helps you with:

#### 🎯 Core Capabilities

1. **Frontend Performance Optimization**
   - Bundle size analysis and optimization
   - Code splitting and tree shaking
   - Resource loading optimization
   - Image optimization strategies

2. **Performance Monitoring**
   - Core Web Vitals monitoring
   - Custom performance metrics tracking
   - Real-time performance analysis
   - Bundle size checks

3. **Build Optimization**
   - Webpack configuration optimization
   - Production build optimization
   - Caching strategies
   - CDN deployment optimization

4. **Database and API Optimization**
   - Query optimization recommendations
   - API response optimization
   - Pagination strategies
   - N+1 query solutions

5. **Framework-Specific Optimizations**
   - React performance optimization patterns
   - Vue.js optimization techniques
   - CSS-in-JS optimization
   - Critical CSS extraction

#### 📦 Provided Tools

- **Automated Setup Script** (`scripts/performance-setup.sh`)
  - One-command installation of all performance monitoring tools
  - Automatic configuration of webpack, Lighthouse, size-limit
  - Creation of performance monitoring utilities
  - CI/CD integration setup

- **Complete Documentation**
  - `PERFORMANCE_ANALYSIS.md` - Detailed optimization guide
  - `PERFORMANCE_SUMMARY.md` - Quick reference summary
  - Code examples and best practices

- **CI/CD Integration**
  - GitHub Actions workflows
  - Automatic bundle size checks
  - Performance regression testing
  - Lighthouse audits

#### 🚀 Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/Powerck7788/Huang.git
cd Huang

# 2. Run the performance setup script (when you start developing)
./scripts/performance-setup.sh

# 3. Install dependencies
npm install

# 4. Use performance tools
npm run build:analyze  # Analyze bundle size
npm run lighthouse     # Run Lighthouse audit
npm run size-limit     # Check size limits
```

#### 📊 Performance Targets

| Metric | Target | Tool |
|--------|---------|------|
| JavaScript Bundle | < 200KB (gzipped) | size-limit |
| CSS Bundle | < 50KB (gzipped) | size-limit |
| First Contentful Paint | < 1.8s | Lighthouse |
| Largest Contentful Paint | < 2.5s | Web Vitals |
| First Input Delay | < 100ms | Web Vitals |
| Cumulative Layout Shift | < 0.1 | Web Vitals |

#### 💡 Use Cases

This toolkit is perfect for:
- 🏗️ Setting performance baselines for new projects
- 📈 Optimizing existing project performance
- 🔍 Identifying performance bottlenecks
- 📊 Continuous performance monitoring
- 🎓 Learning performance optimization best practices

#### 🛠️ Supported Tech Stack

- **Frontend Frameworks**: React, Vue.js, Angular
- **Build Tools**: Webpack, Vite, Rollup
- **Monitoring**: Lighthouse, Web Vitals, Bundle Analyzer
- **CI/CD**: GitHub Actions, extensible to other platforms

#### 📚 Documentation

- [Performance Analysis Guide](PERFORMANCE_ANALYSIS.md) - In-depth optimization strategies
- [Performance Summary](PERFORMANCE_SUMMARY.md) - Quick reference guide
- [Setup Script](scripts/performance-setup.sh) - Automated tool installation

#### 🤝 Contributing

Contributions are welcome! This is a living document and toolkit that grows with web performance best practices.

#### 📄 License

This project is open source and available for use in your projects.

---

**Ready to optimize your application?** Start with the [Performance Analysis Guide](PERFORMANCE_ANALYSIS.md) or run the setup script to get started!
