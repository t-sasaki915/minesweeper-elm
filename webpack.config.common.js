const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
    entry: `${__dirname}/src/index.js`,
    output: {
        path: `${__dirname}/dist`,
        filename: "bundle-[contenthash].js",
        libraryTarget: "window"
    },
    optimization: {
        minimize: true
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                use: ["style-loader", "css-loader"]
            }
        ]
    },
    plugins: [
        new HtmlWebpackPlugin({ template: `${__dirname}/src/index.html` })
    ],
    mode: process.env.WEBPACK_SERVE ? "development" : "production"
};
