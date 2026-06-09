#!/usr/bin/env bash
# PM-OS 一键安装脚本
# Usage: bash install.sh [目标目录]

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════╗
║                                                          ║
║   PM-OS：产品经理的 AI 工作台                            ║
║   全套 C 方案（9 skills + 6 agents + 5 commands）        ║
║                                                          ║
╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# 1. 检查 Claude Code
echo -e "${BLUE}[1/6]${NC} 检查 Claude Code 是否安装..."
if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ Claude Code 未安装${NC}"
    echo "请先安装："
    echo "  curl -fsSL https://claude.ai/install.sh | bash"
    echo "或"
    echo "  npm install -g @anthropic-ai/claude-code"
    exit 1
fi
echo -e "${GREEN}✅ Claude Code 已安装：$(claude --version 2>/dev/null || echo '版本信息无法获取')${NC}"
echo

# 2. 确定目标目录
TARGET_DIR="${1:-$HOME/pm-os}"
echo -e "${BLUE}[2/6]${NC} 目标安装目录：$TARGET_DIR"

if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}⚠️  目标目录已存在${NC}"
    read -p "是否覆盖？(y/N): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "已取消"
        exit 0
    fi
fi

# 3. 复制文件
echo -e "${BLUE}[3/6]${NC} 复制文件到 $TARGET_DIR..."
mkdir -p "$TARGET_DIR"

# 当前脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 复制除了 install.sh 自身以外的所有文件
rsync -av --exclude='install.sh' --exclude='outputs/*' "$SCRIPT_DIR/" "$TARGET_DIR/"
echo -e "${GREEN}✅ 文件复制完成${NC}"
echo

# 4. 验证 skills 结构
echo -e "${BLUE}[4/6]${NC} 验证 skills 结构..."
SKILLS_DIR="$TARGET_DIR/.claude/skills"
REQUIRED_SKILLS=(
    "product-archaeology"
    "competitive-analysis"
    "company-deep-dive"
    "founder-profile"
    "business-model-canvas"
    "trend-forecaster"
    "prd-writer"
    "user-research-synth"
    "metrics-definer"
)

MISSING=0
for skill in "${REQUIRED_SKILLS[@]}"; do
    if [ -f "$SKILLS_DIR/$skill/SKILL.md" ]; then
        echo -e "  ${GREEN}✓${NC} $skill"
    else
        echo -e "  ${RED}✗${NC} $skill (缺失)"
        MISSING=$((MISSING+1))
    fi
done

if [ $MISSING -gt 0 ]; then
    echo -e "${RED}有 $MISSING 个 skill 缺失，请检查安装包完整性${NC}"
    exit 1
fi
echo

# 5. 验证 agents 和 commands
echo -e "${BLUE}[5/6]${NC} 验证 agents 和 commands..."
AGENTS_COUNT=$(ls "$TARGET_DIR/.claude/agents/"*.md 2>/dev/null | wc -l)
COMMANDS_COUNT=$(ls "$TARGET_DIR/.claude/commands/"*.md 2>/dev/null | wc -l)
echo -e "  agents: ${GREEN}$AGENTS_COUNT${NC} 个"
echo -e "  commands: ${GREEN}$COMMANDS_COUNT${NC} 个"
echo

# 6. 提示用户填写个人信息
echo -e "${BLUE}[6/6]${NC} 安装完成。下一步："
echo
echo -e "${YELLOW}📝 必做：${NC}"
echo "   1. 打开 $TARGET_DIR/CLAUDE.md，把 [请填写] 部分换成你的真实信息"
echo "   2. 打开 $TARGET_DIR/context/glossary.md，填你的行业术语"
echo "   3. 打开 $TARGET_DIR/context/watchlist.md，列你的关注对象"
echo
echo -e "${YELLOW}🚀 启动方式：${NC}"
echo "   cd $TARGET_DIR"
echo "   claude"
echo
echo -e "${YELLOW}🎯 第一次试用建议：${NC}"
echo "   > /quick-scan Notion"
echo "   或"
echo "   > 分析一下飞书的前世今生"
echo
echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  安装成功！开始你的 AI 产品研究之旅 🚀                   ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
echo
echo "如需帮助，查看 $TARGET_DIR/README.md 或 $TARGET_DIR/INSTALL.md"
