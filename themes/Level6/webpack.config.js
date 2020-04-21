const path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'Level6.min.js',
    path: path.resolve(__dirname, 'source/js')
  },
  module: {
	  rules: [
		{
			test: /\.css$/,
			use: [
				'style-loader',
				'css-loader'
			]
		}
	  ]
  }
};