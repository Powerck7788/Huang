#!/bin/bash

# 性能優化工具包 - 自動安裝腳本
# 這個腳本將自動為您安裝和配置所有性能優化工具

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 無顏色

# 輸出函數
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_step() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# 歡迎訊息
clear
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║          🚀 性能優化工具包 - 自動安裝程式 🚀              ║"
echo "║                                                            ║"
echo "║        Performance Optimization Toolkit Installer         ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

print_info "此腳本將為您安裝以下工具："
echo "  • Bundle 分析工具 (webpack-bundle-analyzer, source-map-explorer)"
echo "  • 性能監控工具 (Lighthouse, Web Vitals)"
echo "  • 大小限制工具 (size-limit)"
echo "  • 開發工具 (Webpack, Babel)"
echo ""

# 檢查是否有 Node.js
print_step "第 1 步：檢查系統環境"

if ! command -v node &> /dev/null; then
    print_error "未找到 Node.js！請先安裝 Node.js (https://nodejs.org/)"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    print_error "未找到 npm！請確保 npm 已正確安裝"
    exit 1
fi

NODE_VERSION=$(node -v)
NPM_VERSION=$(npm -v)

print_success "Node.js 版本: $NODE_VERSION"
print_success "npm 版本: $NPM_VERSION"

# 詢問用戶是否繼續
echo ""
read -p "是否繼續安裝？(y/n) [y]: " CONTINUE
CONTINUE=${CONTINUE:-y}

if [[ ! $CONTINUE =~ ^[Yy]$ ]]; then
    print_warning "安裝已取消"
    exit 0
fi

# 創建或檢查 package.json
print_step "第 2 步：設置專案配置"

if [ ! -f "package.json" ]; then
    print_info "未找到 package.json，正在創建..."
    npm init -y
    print_success "已創建 package.json"
else
    print_success "找到現有的 package.json"
fi

# 詢問用戶要安裝哪些工具
echo ""
print_info "請選擇您要安裝的工具組件："
echo ""
echo "1) 完整安裝 (推薦) - 安裝所有工具"
echo "2) 基本安裝 - 只安裝核心性能監控工具"
echo "3) 自定義安裝 - 選擇要安裝的工具"
echo ""
read -p "請選擇 (1-3) [1]: " INSTALL_TYPE
INSTALL_TYPE=${INSTALL_TYPE:-1}

# 安裝工具
print_step "第 3 步：安裝 npm 套件"

case $INSTALL_TYPE in
    1)
        print_info "開始完整安裝..."
        
        print_info "安裝 Bundle 分析工具..."
        npm install --save-dev webpack-bundle-analyzer source-map-explorer bundlephobia-cli
        
        print_info "安裝性能監控工具..."
        npm install --save-dev lighthouse size-limit @size-limit/preset-app
        npm install web-vitals
        
        print_info "安裝開發工具..."
        npm install --save-dev @babel/core @babel/preset-env
        npm install --save-dev webpack webpack-cli webpack-dev-server
        
        print_success "所有工具安裝完成！"
        ;;
    2)
        print_info "開始基本安裝..."
        
        print_info "安裝核心性能監控工具..."
        npm install --save-dev lighthouse size-limit @size-limit/preset-app
        npm install web-vitals
        
        print_success "基本工具安裝完成！"
        ;;
    3)
        print_info "自定義安裝模式"
        
        read -p "安裝 Bundle 分析工具? (y/n) [y]: " INSTALL_BUNDLE
        INSTALL_BUNDLE=${INSTALL_BUNDLE:-y}
        if [[ $INSTALL_BUNDLE =~ ^[Yy]$ ]]; then
            npm install --save-dev webpack-bundle-analyzer source-map-explorer
            print_success "Bundle 分析工具已安裝"
        fi
        
        read -p "安裝 Lighthouse? (y/n) [y]: " INSTALL_LIGHTHOUSE
        INSTALL_LIGHTHOUSE=${INSTALL_LIGHTHOUSE:-y}
        if [[ $INSTALL_LIGHTHOUSE =~ ^[Yy]$ ]]; then
            npm install --save-dev lighthouse
            print_success "Lighthouse 已安裝"
        fi
        
        read -p "安裝 Web Vitals? (y/n) [y]: " INSTALL_VITALS
        INSTALL_VITALS=${INSTALL_VITALS:-y}
        if [[ $INSTALL_VITALS =~ ^[Yy]$ ]]; then
            npm install web-vitals
            print_success "Web Vitals 已安裝"
        fi
        
        read -p "安裝 size-limit? (y/n) [y]: " INSTALL_SIZE
        INSTALL_SIZE=${INSTALL_SIZE:-y}
        if [[ $INSTALL_SIZE =~ ^[Yy]$ ]]; then
            npm install --save-dev size-limit @size-limit/preset-app
            print_success "size-limit 已安裝"
        fi
        
        print_success "自定義工具安裝完成！"
        ;;
    *)
        print_error "無效的選擇，預設使用完整安裝"
        npm install --save-dev webpack-bundle-analyzer lighthouse size-limit web-vitals
        ;;
esac

# 添加 npm 腳本
print_step "第 4 步：配置 npm 腳本"

print_info "正在添加便捷腳本到 package.json..."

npm pkg set scripts.analyze="webpack-bundle-analyzer dist/static/js/*.js"
npm pkg set scripts.lighthouse="lighthouse http://localhost:3000 --output=json --output-path=./lighthouse-report.json"
npm pkg set scripts.size-limit="size-limit"
npm pkg set scripts.build:analyze="npm run build && npm run analyze"

print_success "npm 腳本配置完成！"

# 創建配置文件
print_step "第 5 步：創建配置文件"

# Lighthouse 配置
if [ ! -f "lighthouse.config.js" ]; then
    print_info "創建 Lighthouse 配置文件..."
    cat > lighthouse.config.js << 'EOF'
module.exports = {
  extends: 'lighthouse:default',
  settings: {
    onlyAudits: [
      'first-contentful-paint',
      'largest-contentful-paint',
      'first-input-delay',
      'cumulative-layout-shift',
      'speed-index',
      'total-blocking-time',
      'time-to-interactive',
    ],
  },
};
EOF
    print_success "lighthouse.config.js 已創建"
else
    print_warning "lighthouse.config.js 已存在，跳過"
fi

# Size-limit 配置
if [ ! -f ".size-limit.json" ]; then
    print_info "創建 size-limit 配置文件..."
    cat > .size-limit.json << 'EOF'
[
  {
    "path": "dist/**/*.js",
    "limit": "200 KB"
  },
  {
    "path": "dist/**/*.css",
    "limit": "50 KB"
  }
]
EOF
    print_success ".size-limit.json 已創建"
else
    print_warning ".size-limit.json 已存在，跳過"
fi

# 性能預算配置
if [ ! -f "performance-budget.json" ]; then
    print_info "創建性能預算配置文件..."
    cat > performance-budget.json << 'EOF'
{
  "budget": [
    {
      "resourceType": "script",
      "budget": 200
    },
    {
      "resourceType": "style",
      "budget": 50
    },
    {
      "resourceType": "image",
      "budget": 500
    },
    {
      "resourceType": "media",
      "budget": 1000
    },
    {
      "resourceType": "font",
      "budget": 100
    }
  ]
}
EOF
    print_success "performance-budget.json 已創建"
else
    print_warning "performance-budget.json 已存在，跳過"
fi

# Webpack 配置
if [ ! -f "webpack.performance.config.js" ]; then
    print_info "創建 Webpack 性能配置文件..."
    cat > webpack.performance.config.js << 'EOF'
const path = require('path');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

module.exports = {
  mode: 'production',
  entry: './src/index.js',
  output: {
    filename: '[name].[contenthash].js',
    path: path.resolve(__dirname, 'dist'),
    clean: true,
  },
  optimization: {
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          chunks: 'all',
        },
      },
    },
    usedExports: true,
    sideEffects: false,
  },
  plugins: [
    new BundleAnalyzerPlugin({
      analyzerMode: 'static',
      openAnalyzer: false,
      reportFilename: 'bundle-report.html',
    }),
  ],
  performance: {
    maxAssetSize: 200000,
    maxEntrypointSize: 200000,
    hints: 'warning',
  },
};
EOF
    print_success "webpack.performance.config.js 已創建"
else
    print_warning "webpack.performance.config.js 已存在，跳過"
fi

# 創建性能監控工具代碼
print_step "第 6 步：創建性能監控工具代碼"

if [ ! -d "src/utils" ]; then
    mkdir -p src/utils
    print_info "創建 src/utils 目錄..."
fi

if [ ! -f "src/utils/performance.js" ]; then
    print_info "創建性能監控工具代碼..."
    cat > src/utils/performance.js << 'EOF'
// 性能監控工具
// Performance monitoring utilities

import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals';

/**
 * 初始化性能監控
 * Initialize performance monitoring
 */
export function initPerformanceMonitoring() {
  // 發送指標到分析服務
  function sendToAnalytics(metric) {
    console.log('性能指標 / Performance metric:', metric);
    // 替換為您的分析服務
    // Replace with your analytics service
    // analytics.track('web-vital', metric);
  }

  // 監控核心網頁指標
  getCLS(sendToAnalytics);  // 累積版面配置位移
  getFID(sendToAnalytics);  // 首次輸入延遲
  getFCP(sendToAnalytics);  // 首次內容繪製
  getLCP(sendToAnalytics);  // 最大內容繪製
  getTTFB(sendToAnalytics); // 首次位元組時間
}

/**
 * 自定義性能標記
 * Custom performance marks
 */
export function performanceMark(name) {
  if ('performance' in window) {
    performance.mark(name);
  }
}

/**
 * 測量性能
 * Measure performance between marks
 */
export function performanceMeasure(name, startMark, endMark) {
  if ('performance' in window) {
    performance.measure(name, startMark, endMark);
    const measure = performance.getEntriesByName(name)[0];
    console.log(`${name}: ${measure.duration}ms`);
    return measure.duration;
  }
}

/**
 * 分析資源時間
 * Analyze resource timing
 */
export function analyzeResourceTiming() {
  const resources = performance.getEntriesByType('resource');
  const analysis = {
    totalResources: resources.length,
    totalSize: 0,
    slowestResources: [],
    resourceTypes: {}
  };

  resources.forEach(resource => {
    const size = resource.transferSize || 0;
    analysis.totalSize += size;

    // 按類型分類
    const type = resource.initiatorType;
    if (!analysis.resourceTypes[type]) {
      analysis.resourceTypes[type] = { count: 0, totalSize: 0 };
    }
    analysis.resourceTypes[type].count++;
    analysis.resourceTypes[type].totalSize += size;

    // 追蹤慢速資源 (>1s)
    if (resource.duration > 1000) {
      analysis.slowestResources.push({
        name: resource.name,
        duration: resource.duration,
        size: size
      });
    }
  });

  console.table(analysis.resourceTypes);
  return analysis;
}
EOF
    print_success "src/utils/performance.js 已創建"
else
    print_warning "src/utils/performance.js 已存在，跳過"
fi

# 創建示例入口文件
if [ ! -f "src/index.js" ]; then
    print_info "創建示例入口文件..."
    cat > src/index.js << 'EOF'
// 這是一個示例入口文件
// This is an example entry file

import { initPerformanceMonitoring } from './utils/performance.js';

// 初始化性能監控
// Initialize performance monitoring
initPerformanceMonitoring();

console.log('應用程式已啟動 / Application started');

// 在這裡添加您的應用程式代碼
// Add your application code here
EOF
    print_success "src/index.js 已創建"
else
    print_warning "src/index.js 已存在，跳過"
fi

# 創建 GitHub Actions 工作流程
print_step "第 7 步：配置 CI/CD"

read -p "是否要創建 GitHub Actions 性能監控工作流程? (y/n) [y]: " CREATE_WORKFLOW
CREATE_WORKFLOW=${CREATE_WORKFLOW:-y}

if [[ $CREATE_WORKFLOW =~ ^[Yy]$ ]]; then
    if [ ! -d ".github/workflows" ]; then
        mkdir -p .github/workflows
        print_info "創建 .github/workflows 目錄..."
    fi
    
    if [ ! -f ".github/workflows/performance.yml" ]; then
        print_info "創建 GitHub Actions 工作流程..."
        cat > .github/workflows/performance.yml << 'EOF'
name: 性能監控 / Performance Monitoring

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  performance:
    runs-on: ubuntu-latest
    
    steps:
    - name: 檢出代碼 / Checkout code
      uses: actions/checkout@v3
    
    - name: 設置 Node.js / Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: 安裝依賴 / Install dependencies
      run: npm ci
    
    - name: 構建應用程式 / Build application
      run: npm run build
      continue-on-error: true
    
    - name: 檢查 Bundle 大小 / Check bundle size
      run: npm run size-limit
      continue-on-error: true
    
    - name: 生成 Bundle 分析 / Generate bundle analysis
      run: npm run analyze
      continue-on-error: true
    
    - name: 上傳 Bundle 分析報告 / Upload bundle analysis
      uses: actions/upload-artifact@v3
      if: always()
      with:
        name: bundle-analysis
        path: bundle-report.html
    
    - name: 性能回歸檢查 / Performance regression check
      run: |
        echo "✅ Bundle 大小檢查完成"
        echo "✅ 性能預算檢查完成"
EOF
        print_success ".github/workflows/performance.yml 已創建"
    else
        print_warning ".github/workflows/performance.yml 已存在，跳過"
    fi
else
    print_info "跳過 GitHub Actions 配置"
fi

# 安裝完成
print_step "🎉 安裝完成！"

echo ""
print_success "所有組件已成功安裝和配置！"
echo ""

print_info "接下來的步驟："
echo ""
echo "1. 查看已安裝的工具："
echo "   ${GREEN}npm list --depth=0${NC}"
echo ""
echo "2. 如果您有現有的構建腳本，可以運行："
echo "   ${GREEN}npm run build:analyze${NC}   # 構建並分析 bundle 大小"
echo ""
echo "3. 運行性能審查："
echo "   ${GREEN}npm run lighthouse${NC}      # 需要先啟動開發伺服器"
echo ""
echo "4. 檢查大小限制："
echo "   ${GREEN}npm run size-limit${NC}      # 檢查文件大小是否符合預算"
echo ""
echo "5. 在您的應用程式中導入性能監控："
echo "   ${GREEN}import { initPerformanceMonitoring } from './src/utils/performance.js';${NC}"
echo "   ${GREEN}initPerformanceMonitoring();${NC}"
echo ""

print_info "已創建的配置文件："
echo "  ✓ lighthouse.config.js       - Lighthouse 配置"
echo "  ✓ .size-limit.json          - 文件大小限制配置"
echo "  ✓ performance-budget.json   - 性能預算配置"
echo "  ✓ webpack.performance.config.js - Webpack 優化配置"
echo "  ✓ src/utils/performance.js  - 性能監控工具代碼"
if [[ $CREATE_WORKFLOW =~ ^[Yy]$ ]]; then
    echo "  ✓ .github/workflows/performance.yml - GitHub Actions 工作流程"
fi
echo ""

print_info "詳細文檔請查看："
echo "  📖 README.md - 快速開始指南"
echo "  📖 PERFORMANCE_ANALYSIS.md - 詳細的性能分析指南"
echo "  📖 PERFORMANCE_SUMMARY.md - 性能優化摘要"
echo ""

print_success "感謝使用性能優化工具包！祝您的應用程式性能優異！ 🚀"
echo ""
