'use strict'
require('./legacy-hash-polyfill')
const { VueLoaderPlugin } = require('vue-loader')

const path = require('path');
const webpack = require('webpack');
const config = require('../config');

function resolve(dir) {
  return path.join(__dirname, '..', dir);
}

module.exports = {
  // no 'mode' here; dev/prod merge files set it
  context: path.resolve(__dirname, '../'),
  entry: {
    app: ['@babel/polyfill', './src/main.js'],
  },
  output: {
    path: config.build.assetsRoot,
    filename: '[name].js',
    hashFunction: 'sha256',
    publicPath:
      process.env.NODE_ENV === 'production'
        ? config.build.assetsPublicPath
        : config.dev.assetsPublicPath,
  },
  resolve: {
    extensions: ['.js', '.vue', '.json'],
    alias: {
      'vue$': 'vue/dist/vue.esm-bundler.js',
      '@': resolve('src'),
    },
  },
  module: {
    rules: [
      { test: /\.vue$/, loader: 'vue-loader' },
      { test: /\.js$/, use: 'babel-loader', exclude: /node_modules/ },
      // NOTE: CSS rules are defined in webpack.dev.conf.js (and usually a prod config)
      {
        test: /\.(png|jpe?g|gif|mp4|svg|webp|ico|woff2?|eot|ttf|otf)$/i,
        type: 'asset/resource',
      },
    ],
  },
  plugins: [
    new VueLoaderPlugin(),
    new webpack.DefinePlugin({
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: false,
      __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: false,
    }),
  ],
};
