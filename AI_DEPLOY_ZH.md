# AI 專用自動化部署指南

## 📖 概述

這是一個專門為 AI 代理（如 GitHub Copilot、ChatGPT 等）設計的自動化部署系統。透過這個系統，AI 可以輕鬆觸發和管理應用程式的部署流程。

### 🎯 主要特色

- ✅ **完全自動化**：從構建到部署一鍵完成
- ✅ **多環境支持**：預覽、測試、生產環境
- ✅ **AI 友好**：專門為 AI 代理設計的觸發機制
- ✅ **安全可靠**：內建檢查和驗證步驟
- ✅ **完整日誌**：詳細的部署記錄和報告
- ✅ **中文支持**：完整的中文界面和文檔

---

## 🚀 快速開始

### 方法一：透過 GitHub Actions 介面（推薦）

這是最簡單的方式，適合 AI 代理使用：

1. **訪問 GitHub Actions 頁面**
   ```
   https://github.com/Powerck7788/Huang/actions
   ```

2. **選擇 "AI 專用自動化部署" 工作流程**

3. **點擊 "Run workflow" 按鈕**

4. **填寫部署參數**：
   - **部署類型**：選擇 `preview`、`staging` 或 `production`
   - **目標環境**：（可選）指定環境名稱
   - **版本標籤**：（可選）指定版本，預設為 `latest`
   - **AI 代理識別**：（可選）填入 AI 代理名稱，如 `github-copilot`

5. **點擊綠色的 "Run workflow" 按鈕**

6. **查看部署進度**：在 Actions 頁面查看即時日誌

### 方法二：透過本地腳本

如果您有本地權限，可以直接執行部署腳本：

```bash
# 基本用法
./scripts/ai-deploy.sh preview

# 指定環境和版本
./scripts/ai-deploy.sh staging my-env v1.0.0

# 完整參數
./scripts/ai-deploy.sh production prod-env v2.1.0
```

### 方法三：透過 Git 標籤觸發

創建特定格式的 Git 標籤會自動觸發部署：

```bash
# 創建版本標籤
git tag v1.0.0
git push origin v1.0.0

# 或創建發布標籤
git tag release-2024-02-16
git push origin release-2024-02-16
```

### 方法四：透過分支推送

推送到特定分支會自動觸發部署：

```bash
# 部署分支
git checkout -b deploy/feature-x
git push origin deploy/feature-x

# 或 AI 部署分支
git checkout -b ai-deploy/test
git push origin ai-deploy/test
```

---

## 🎛️ 部署類型說明

### 1. Preview（預覽）

- **用途**：快速預覽和驗證更改
- **特點**：
  - 快速部署
  - 不執行完整測試
  - 適合開發階段
- **觸發方式**：手動或透過 `deploy/**` 分支
- **示例 URL**：`https://preview.example.com/v1.0.0`

### 2. Staging（測試）

- **用途**：QA 測試和驗證
- **特點**：
  - 執行完整測試套件
  - 模擬生產環境
  - 適合測試階段
- **觸發方式**：手動或透過標籤
- **示例 URL**：`https://staging.example.com`

### 3. Production（生產）

- **用途**：正式環境部署
- **特點**：
  - 最嚴格的檢查
  - 需要額外確認
  - 完整的備份和回滾機制
- **觸發方式**：僅手動觸發（需要權限）
- **示例 URL**：`https://production.example.com`

---

## 📋 部署流程

部署工作流程包含以下階段：

```
1. 準備階段 (Prepare)
   ├─ 檢查環境
   ├─ 設置參數
   └─ 驗證權限
   
2. 構建階段 (Build)
   ├─ 檢出代碼
   ├─ 安裝依賴
   ├─ 執行構建
   └─ 打包產物
   
3. 測試階段 (Test) - 可選
   ├─ 執行單元測試
   ├─ 執行整合測試
   └─ 生成測試報告
   
4. 部署階段 (Deploy)
   ├─ 下載構建產物
   ├─ 執行部署腳本
   ├─ 驗證部署
   └─ 創建部署標籤
   
5. 通知階段 (Notify)
   ├─ 生成部署報告
   ├─ 發送通知
   └─ 更新狀態
```

---

## 🤖 AI 代理使用指南

### 給 GitHub Copilot 的指令

您可以使用以下自然語言指令：

```
"請幫我部署到預覽環境"
"Deploy to staging environment with version v1.2.3"
"觸發生產環境部署，版本為 latest"
"執行 AI 自動化部署到測試環境"
```

### 給 ChatGPT 的指令

提供以下資訊給 ChatGPT：

```
我需要執行部署，請幫我：
1. 前往: https://github.com/Powerck7788/Huang/actions
2. 選擇 "AI 專用自動化部署" 工作流程
3. 使用以下參數：
   - 部署類型: staging
   - 版本: v1.0.0
   - AI 代理: chatgpt
```

### API 整合（進階）

如果您的 AI 系統支持 GitHub API：

```bash
# 使用 GitHub CLI
gh workflow run ai-deploy.yml \
  -f deployment_type=staging \
  -f version=v1.0.0 \
  -f ai_agent=my-ai-agent

# 使用 curl
curl -X POST \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/Powerck7788/Huang/actions/workflows/ai-deploy.yml/dispatches \
  -d '{"ref":"main","inputs":{"deployment_type":"staging"}}'
```

---

## 📊 部署監控

### 查看部署狀態

1. **GitHub Actions 頁面**
   - 訪問：`https://github.com/Powerck7788/Huang/actions`
   - 查看即時日誌和狀態

2. **部署摘要**
   - 每次部署完成後會生成摘要
   - 包含所有關鍵信息和結果

3. **部署記錄**
   - 本地腳本會在 `deployment/` 目錄創建日誌文件
   - 格式：`deploy_YYYYMMDD_HHMMSS.log`

### 檢查部署結果

部署完成後，檢查以下內容：

- ✅ **構建狀態**：是否成功構建
- ✅ **測試結果**：所有測試是否通過
- ✅ **部署狀態**：是否成功部署
- ✅ **應用狀態**：應用是否正常運行

---

## 🔧 配置選項

### 環境變數

在 `.github/workflows/ai-deploy.yml` 中可以配置：

```yaml
env:
  NODE_VERSION: '18'      # Node.js 版本
  DEPLOY_DIR: 'dist'      # 部署目錄
  # 添加更多環境變數...
```

### 部署腳本自定義

編輯 `scripts/ai-deploy.sh` 來自定義部署邏輯：

```bash
case "${DEPLOYMENT_TYPE}" in
    preview)
        # 自定義預覽環境部署邏輯
        ;;
    staging)
        # 自定義測試環境部署邏輯
        ;;
    production)
        # 自定義生產環境部署邏輯
        ;;
esac
```

---

## ❓ 常見問題

### Q: 如何回滾部署？

A: 您可以：
1. 重新部署之前的版本
2. 使用 Git 回滾代碼後重新部署
3. 如果有備份，直接還原備份

```bash
# 部署之前的版本
./scripts/ai-deploy.sh production default v1.0.0
```

### Q: 部署失敗了怎麼辦？

A: 檢查以下幾點：
1. 查看 GitHub Actions 日誌找出錯誤
2. 確認代碼沒有語法錯誤
3. 確認所有測試都通過
4. 檢查網路連接和權限

### Q: 可以同時部署到多個環境嗎？

A: 目前不支持，但您可以：
1. 順序執行多次部署
2. 或修改工作流程支持並行部署

### Q: AI 代理如何獲得部署權限？

A: 部署權限由 GitHub 倉庫權限控制：
1. 確保 AI 代理使用的帳號有適當權限
2. 對於生產環境，可能需要額外的審批流程
3. 考慮使用 GitHub 的環境保護規則

### Q: 支持哪些部署目標？

A: 當前支持：
- GitHub Pages
- 靜態站點託管（Netlify、Vercel）
- 容器部署（Docker）
- 自定義伺服器

您可以修改部署腳本來支持其他目標。

---

## 🛡️ 安全建議

### 權限管理

- ✅ 使用最小權限原則
- ✅ 為不同環境設置不同的訪問控制
- ✅ 定期審查和更新權限
- ✅ 使用 GitHub 的環境保護規則

### 敏感信息

- ⚠️ 不要在日誌中輸出敏感信息
- ⚠️ 使用 GitHub Secrets 存儲憑證
- ⚠️ 不要將密鑰提交到代碼庫
- ⚠️ 定期輪換訪問令牌

### 生產環境保護

- 🔒 要求人工審批
- 🔒 啟用分支保護規則
- 🔒 執行完整的測試套件
- 🔒 創建部署前檢查點

---

## 📚 延伸閱讀

- [GitHub Actions 文檔](https://docs.github.com/en/actions)
- [工作流程語法](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [快速開始指南](快速開始.md)
- [性能分析指南](PERFORMANCE_ANALYSIS.md)

---

## 🆘 需要幫助？

如果您在使用過程中遇到問題：

1. 📖 查看本文檔的常見問題部分
2. 🔍 檢查 GitHub Actions 日誌
3. 💬 在 [GitHub Issues](https://github.com/Powerck7788/Huang/issues) 提問
4. 📧 聯繫維護團隊

---

## 🎉 總結

AI 專用自動化部署系統讓部署變得簡單：

1. ✅ **簡單易用**：一鍵觸發，全自動執行
2. ✅ **安全可靠**：多重檢查，防止錯誤
3. ✅ **靈活配置**：支持多種環境和場景
4. ✅ **AI 友好**：專為 AI 代理設計

現在就開始使用 AI 自動化部署，讓您的開發流程更加高效！🚀

---

**最後更新**：2024-02-16  
**版本**：1.0.0  
**維護者**：Huang Team
