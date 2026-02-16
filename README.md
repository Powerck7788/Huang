# Huang

A performance monitoring and optimization toolkit with [OpenClaw](https://github.com/openclaw/openclaw) integration.

## Features

- ⚡ **Performance Analysis** — Bundle size optimization, Core Web Vitals tracking, and Lighthouse audits
- 🦞 **OpenClaw Skill** — Built-in [OpenClaw](https://github.com/openclaw/openclaw) skill for AI-assisted performance monitoring

## OpenClaw Integration

This repository includes an [OpenClaw](https://github.com/openclaw/openclaw) workspace skill that enables AI-assisted performance analysis. OpenClaw is a personal AI assistant that runs on your own devices.

### Quick Start

1. **Install OpenClaw** (requires Node.js ≥ 22):

   ```bash
   npm install -g openclaw@latest
   openclaw onboard --install-daemon
   ```

2. **Set up the workspace**:

   ```bash
   bash scripts/openclaw-setup.sh
   ```

3. **Use the skill**:

   ```bash
   openclaw agent --message "analyze my app performance"
   ```

### Workspace Skill

The `skills/performance-monitor/` directory contains an OpenClaw skill that teaches the assistant how to:

- Run bundle size analysis
- Execute Lighthouse audits
- Monitor Core Web Vitals
- Check performance budgets

See [OpenClaw Skills documentation](https://docs.openclaw.ai/tools/skills) for more on how skills work.

## Performance Setup

To set up the performance monitoring tools independently:

```bash
bash scripts/performance-setup.sh
```

This installs bundle analyzers, Lighthouse, size-limit, and web-vitals. See [PERFORMANCE_ANALYSIS.md](PERFORMANCE_ANALYSIS.md) for the full optimization guide.
