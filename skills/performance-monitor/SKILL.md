---
name: performance-monitor
description: Analyze and optimize web application performance using bundle analysis, Lighthouse audits, and Core Web Vitals monitoring.
metadata: { "openclaw": { "emoji": "⚡", "requires": { "bins": ["node", "npm"] } } }
---

# Performance Monitor

Run performance analysis and optimization tasks for web applications.

## Bundle Analysis

Analyze JavaScript bundle sizes:

```bash
npm run build:analyze
```

Check bundle size budgets:

```bash
npm run size-limit
```

## Lighthouse Audit

Run a Lighthouse performance audit (requires a running dev server):

```bash
npm run lighthouse
```

## Core Web Vitals

Import the performance monitoring utility in your application:

```javascript
import { initPerformanceMonitoring } from './src/utils/performance.js';
initPerformanceMonitoring();
```

## Performance Setup

If performance tools are not yet installed, run the setup script:

```bash
bash scripts/performance-setup.sh
```

This installs:
- `webpack-bundle-analyzer` and `source-map-explorer` for bundle analysis
- `lighthouse` for auditing
- `size-limit` for budget enforcement
- `web-vitals` for Core Web Vitals tracking

## Performance Budgets

Default budgets (configurable in `.size-limit.json`):
- JavaScript: < 200 KB gzipped
- CSS: < 50 KB gzipped

Key metrics targets:
- First Contentful Paint (FCP): < 1.8s
- Largest Contentful Paint (LCP): < 2.5s
- First Input Delay (FID): < 100ms
- Cumulative Layout Shift (CLS): < 0.1
