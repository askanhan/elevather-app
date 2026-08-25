'use strict';

const path = require('path');
const fs = require('fs');
const webpack = require('webpack');
const { merge } = require('webpack-merge');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const baseWebpackConfig = require('./webpack.base.conf');
const config = require('../config');

// vue-loader caches the SFC descriptor for <template src="..."> (external
// template file) the first time it's read, keyed by the external file's own
// path (see node_modules/vue-loader/dist/descriptorCache.js: getDescriptor's
// fallback branch calls descriptorCache.set() after its own disk read, but
// nothing ever calls setDescriptor() again for that same key — only the
// *.vue file's main loader does, under a different cache key). Once that
// fallback fires, edits to the external template file are silently ignored
// by every following rebuild: watch correctly detects the change and
// recompiles the module, but the compiled output is generated from the
// stale cached descriptor, so the emitted bundle never differs and the
// dev-server has "nothing" to push to the browser. Only killing the process
// (which resets the in-memory Map) makes new edits visible again.
// Clearing the cache before each rebuild forces every src-imported template
// to be re-read from disk, closing that gap.
class ClearVueTemplateSrcCachePlugin {
  apply(compiler) {
    compiler.hooks.watchRun.tap('ClearVueTemplateSrcCachePlugin', () => {
      try {
        require('vue-loader/dist/descriptorCache').descriptorCache.clear();
      } catch (e) {
        // vue-loader internals changed shape; nothing to clear
      }
    });
  }
}

const devWebpackConfig = merge(baseWebpackConfig, {
  mode: 'development',

  module: {
    rules: [
      {
        test: /\.css$/i,
        use: [
          // IMPORTANT: loaders run right-to-left.
          // vue-style-loader injects CSS into the DOM (first in array to run last)
          'vue-style-loader',
          {
            loader: 'css-loader',
            options: { importLoaders: 1 },
          },
          {
            loader: 'postcss-loader',
            options: {
              postcssOptions: {
                plugins: [
                  // add other plugins here if you use them (e.g., require('tailwindcss'))
                  require('autoprefixer'),
                ],
              },
            },
          },
        ],
      },
    ],
  },

  devtool: config.dev.devtool,

  devServer: {
    host: process.env.HOST || config.dev.host,
    port: process.env.PORT || config.dev.port,
    historyApiFallback: true,
    hot: true,
    liveReload: true,
    // static: false,
    compress: true,
    open: Boolean(config.dev.autoOpenBrowser),
    client: {
      logging: 'warn',
      overlay: config.dev.errorOverlay ? { warnings: false, errors: true } : false,
    },
    devMiddleware: {
      publicPath: config.dev.assetsPublicPath,
    },
    proxy: config.dev.proxyTable ? config.dev.proxyTable : undefined,
    allowedHosts: 'all',
    // NOTE: don't set watchFiles for src/**: these files are already part of
    // webpack's own module graph (via entry/imports), so webpack's compiler
    // watcher already tracks them and drives HMR. Adding a second watchFiles
    // watcher on top of that races the compiler: it can fire a full
    // liveReload before the new compile is ready, reloading the browser to
    // the stale bundle (looks like "nothing changed" until you restart).
    // watchFiles: config.dev.poll
    //   ? {
    //       paths: ['src/**/*', 'static/**/*'],
    //     }
    //   : undefined,
  },

  plugins: [
    new webpack.DefinePlugin({ 'process.env': require('../config/dev.env') }),
    new ClearVueTemplateSrcCachePlugin(),
    // new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      filename: 'index.html',
      template: path.resolve(__dirname, '../index.html'),
      inject: true,
    }),
    new CopyWebpackPlugin({
      patterns: [
        {
          from: path.resolve(__dirname, '../static'),
          to: config.dev.assetsSubDirectory,
          noErrorOnMissing: true,
          globOptions: { ignore: ['**/.*'] },
        },
      ],
    }),
  ],
});

module.exports = devWebpackConfig;
