'use strict';

const path = require('path');
const fs = require('fs');
const webpack = require('webpack');
const { merge } = require('webpack-merge');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const baseWebpackConfig = require('./webpack.base.conf');
const config = require('../config');

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
    static: false,
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
    watchFiles: config.dev.poll
      ? {
          paths: ['src/**/*', 'static/**/*'],
        }
      : undefined,
  },

  plugins: [
    new webpack.DefinePlugin({ 'process.env': require('../config/dev.env') }),
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      filename: 'index.html',
      templateContent: () =>
        fs.readFileSync(path.resolve(__dirname, '../index.html'), 'utf8'),
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
