require("./index.css");

const { Elm } = require("./Main.elm");

Elm.Main.init({
    node: document.getElementById("elmContainer")
});
