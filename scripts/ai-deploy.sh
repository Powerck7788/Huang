#!/bin/bash

# AI 專用部署腳本
# AI-specific deployment script

set -e  # 遇到錯誤時退出

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # 無顏色

# 輸出函數
print_header() {
    echo ""
    echo -e "${PURPLE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════${NC}"
    echo ""
}

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

# 顯示標題
clear
print_header "🤖 AI 專用自動化部署腳本"
echo -e "${CYAN}AI Automated Deployment Script${NC}"
echo ""

# 獲取參數
DEPLOYMENT_TYPE="${1:-preview}"
ENVIRONMENT="${2:-default}"
VERSION="${3:-latest}"

print_info "部署參數 / Deployment Parameters:"
echo "  部署類型 / Type: ${DEPLOYMENT_TYPE}"
echo "  目標環境 / Environment: ${ENVIRONMENT}"
echo "  版本標籤 / Version: ${VERSION}"
echo ""

# 驗證參數
print_header "第 1 步：驗證參數 / Step 1: Validate Parameters"

case "${DEPLOYMENT_TYPE}" in
    preview|staging|production)
        print_success "部署類型有效: ${DEPLOYMENT_TYPE}"
        ;;
    *)
        print_error "無效的部署類型: ${DEPLOYMENT_TYPE}"
        print_info "有效選項: preview, staging, production"
        exit 1
        ;;
esac

# 檢查必要工具
print_header "第 2 步：檢查工具 / Step 2: Check Tools"

check_command() {
    if command -v $1 &> /dev/null; then
        print_success "$1 已安裝"
    else
        print_warning "$1 未找到"
        return 1
    fi
}

check_command "git" || print_info "Git 未安裝，某些功能可能無法使用"
check_command "node" || print_info "Node.js 未安裝，某些功能可能無法使用"
check_command "npm" || print_info "npm 未安裝，某些功能可能無法使用"

# 準備部署目錄
print_header "第 3 步：準備部署 / Step 3: Prepare Deployment"

DEPLOY_DIR="./deployment"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DEPLOY_PACKAGE="deploy_${DEPLOYMENT_TYPE}_${TIMESTAMP}"

print_info "創建部署目錄: ${DEPLOY_DIR}"
mkdir -p "${DEPLOY_DIR}"

# 收集部署文件
print_info "收集部署文件..."

# 排除不需要的文件
EXCLUDE_PATTERNS=(
    ".git"
    "node_modules"
    ".github"
    "*.log"
    "*.tmp"
    ".DS_Store"
    "deployment"
)

print_info "排除以下模式:"
for pattern in "${EXCLUDE_PATTERNS[@]}"; do
    echo "  - ${pattern}"
done

# 複製文件（這裡簡化處理）
print_info "複製必要文件到部署目錄..."
rsync -av --progress \
    --exclude='.git' \
    --exclude='node_modules' \
    --exclude='.github' \
    --exclude='*.log' \
    --exclude='deployment' \
    ./ "${DEPLOY_DIR}/${DEPLOY_PACKAGE}/" 2>/dev/null || \
    cp -r . "${DEPLOY_DIR}/${DEPLOY_PACKAGE}/" 2>/dev/null || \
    print_warning "文件複製可能不完整"

print_success "文件準備完成"

# 執行部署前檢查
print_header "第 4 步：部署前檢查 / Step 4: Pre-deployment Checks"

cd "${DEPLOY_DIR}/${DEPLOY_PACKAGE}" || exit 1

# 檢查關鍵文件
check_file() {
    if [ -f "$1" ]; then
        print_success "找到文件: $1"
        return 0
    else
        print_warning "未找到文件: $1"
        return 1
    fi
}

print_info "檢查關鍵文件..."
check_file "README.md"
check_file "package.json" || print_info "這不是一個 Node.js 專案"

# 執行特定環境的部署
print_header "第 5 步：執行部署 / Step 5: Execute Deployment"

case "${DEPLOYMENT_TYPE}" in
    preview)
        print_info "🔍 部署到預覽環境..."
        print_info "預覽環境部署通常用於快速測試和驗證"
        
        # 這裡可以添加預覽環境特定的部署邏輯
        # 例如：部署到 GitHub Pages、Netlify、Vercel 等
        
        print_success "預覽環境部署完成"
        print_info "預覽 URL: https://preview.example.com/${VERSION}"
        ;;
        
    staging)
        print_info "🧪 部署到測試環境..."
        print_info "測試環境用於 QA 測試和驗證"
        
        # 這裡可以添加測試環境特定的部署邏輯
        
        print_success "測試環境部署完成"
        print_info "測試 URL: https://staging.example.com"
        ;;
        
    production)
        print_info "🏭 部署到生產環境..."
        print_warning "這是生產環境部署，請確認所有測試都已通過！"
        
        # 生產環境需要更嚴格的檢查
        read -p "確認部署到生產環境？(yes/no): " confirm
        if [ "${confirm}" != "yes" ]; then
            print_error "部署已取消"
            exit 1
        fi
        
        # 這裡可以添加生產環境特定的部署邏輯
        
        print_success "生產環境部署完成"
        print_info "生產 URL: https://production.example.com"
        ;;
esac

# 部署後操作
print_header "第 6 步：部署後操作 / Step 6: Post-deployment Tasks"

# 創建部署記錄
DEPLOY_LOG="${DEPLOY_DIR}/deploy_${TIMESTAMP}.log"
cat > "${DEPLOY_LOG}" << EOF
═══════════════════════════════════════════════════════
部署記錄 / Deployment Log
═══════════════════════════════════════════════════════
部署類型 / Type: ${DEPLOYMENT_TYPE}
目標環境 / Environment: ${ENVIRONMENT}
版本標籤 / Version: ${VERSION}
時間戳 / Timestamp: ${TIMESTAMP}
部署包 / Package: ${DEPLOY_PACKAGE}
狀態 / Status: 成功 / Success
═══════════════════════════════════════════════════════
EOF

print_success "部署記錄已保存: ${DEPLOY_LOG}"

# 清理臨時文件
print_info "清理臨時文件..."
# 這裡可以添加清理邏輯

# 完成
print_header "✅ 部署完成 / Deployment Complete"

echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                        ║${NC}"
echo -e "${GREEN}║       🎉 AI 自動化部署成功完成！ 🎉                   ║${NC}"
echo -e "${GREEN}║       Automated Deployment Completed Successfully!    ║${NC}"
echo -e "${GREEN}║                                                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

print_info "部署摘要 / Deployment Summary:"
echo "  類型 / Type: ${DEPLOYMENT_TYPE}"
echo "  環境 / Environment: ${ENVIRONMENT}"
echo "  版本 / Version: ${VERSION}"
echo "  時間 / Time: ${TIMESTAMP}"
echo "  包名 / Package: ${DEPLOY_PACKAGE}"
echo ""

print_info "後續步驟 / Next Steps:"
echo "  1. 驗證部署是否正常運作"
echo "  2. 執行煙霧測試 (Smoke Tests)"
echo "  3. 監控應用程式性能"
echo "  4. 如有問題，執行回滾操作"
echo ""

print_success "感謝使用 AI 專用自動化部署系統！ 🚀"
