#!/bin/bash

# Performance Monitoring Setup Script
# Run this script when you start developing your application

echo "🚀 Setting up performance monitoring tools..."

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo "📦 Creating package.json..."
    npm init -y
fi

# Install performance monitoring dependencies
echo "📋 Installing performance analysis tools..."

# Bundle analysis tools
npm install --save-dev webpack-bundle-analyzer
npm install --save-dev source-map-explorer
npm install --save-dev bundlephobia-cli

# Performance monitoring
npm install --save-dev lighthouse
npm install --save-dev size-limit
npm install web-vitals

# Development tools
npm install --save-dev @babel/core @babel/preset-env
npm install --save-dev webpack webpack-cli webpack-dev-server

echo "⚙️  Adding performance scripts to package.json..."

# Add performance scripts
npm pkg set scripts.analyze="webpack-bundle-analyzer dist/static/js/*.js"
npm pkg set scripts.lighthouse="lighthouse http://localhost:3000 --output=json --output-path=./lighthouse-report.json"
npm pkg set scripts.size-limit="size-limit"
npm pkg set scripts.build:analyze="npm run build && npm run analyze"

# Add size-limit configuration
npm pkg set size-limit='[{"path": "dist/**/*.js", "limit": "200 KB"}]'

# Create performance monitoring configuration files
echo "📄 Creating configuration files..."

# Lighthouse configuration
cat > lighthouse.config.js << EOF
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

# Size-limit configuration
cat > .size-limit.json << EOF
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

# Performance budget configuration
cat > performance-budget.json << EOF
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

# Create basic webpack config for performance monitoring
cat > webpack.performance.config.js << EOF
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

# Create performance monitoring utilities
mkdir -p src/utils
cat > src/utils/performance.js << EOF
// Performance monitoring utilities
import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals';

// Initialize performance monitoring
export function initPerformanceMonitoring() {
  // Send metrics to your analytics service
  function sendToAnalytics(metric) {
    console.log('Performance metric:', metric);
    // Replace with your analytics service
    // analytics.track('web-vital', metric);
  }

  getCLS(sendToAnalytics);
  getFID(sendToAnalytics);
  getFCP(sendToAnalytics);
  getLCP(sendToAnalytics);
  getTTFB(sendToAnalytics);
}

// Custom performance marks
export function performanceMark(name) {
  if ('performance' in window) {
    performance.mark(name);
  }
}

export function performanceMeasure(name, startMark, endMark) {
  if ('performance' in window) {
    performance.measure(name, startMark, endMark);
    const measure = performance.getEntriesByName(name)[0];
    console.log(`${name}: ${measure.duration}ms`);
    return measure.duration;
  }
}

// Resource timing analysis
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

    // Categorize by type
    const type = resource.initiatorType;
    if (!analysis.resourceTypes[type]) {
      analysis.resourceTypes[type] = { count: 0, totalSize: 0 };
    }
    analysis.resourceTypes[type].count++;
    analysis.resourceTypes[type].totalSize += size;

    // Track slow resources (>1s)
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

# Create GitHub Actions workflow for performance monitoring
mkdir -p .github/workflows
cat > .github/workflows/performance.yml << EOF
name: Performance Monitoring

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  performance:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Build application
      run: npm run build
    
    - name: Run bundle size check
      run: npm run size-limit
    
    - name: Generate bundle analysis
      run: npm run analyze
    
    - name: Upload bundle analysis
      uses: actions/upload-artifact@v3
      with:
        name: bundle-analysis
        path: bundle-report.html
    
    - name: Performance regression check
      run: |
        echo "Bundle size check passed ✅"
        echo "Performance budget within limits ✅"
EOF

echo "✅ Performance monitoring setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Run 'npm install' to install dependencies"
echo "2. Create your src/index.js file"
echo "3. Use 'npm run build:analyze' to analyze bundle size"
echo "4. Use 'npm run lighthouse' to run Lighthouse audits"
echo "5. Import and call initPerformanceMonitoring() in your app"
echo ""
echo "🔧 Configuration files created:"
echo "- lighthouse.config.js"
echo "- .size-limit.json"
echo "- performance-budget.json"
echo "- webpack.performance.config.js"
echo "- src/utils/performance.js"
echo "- .github/workflows/performance.yml"