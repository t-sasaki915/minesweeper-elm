require("./index.css");

const { Elm } = require("./Main.elm");

const app = Elm.Main.init({
    node: document.getElementById("elmContainer")
});

const DIFFICULTY_PARAM_NAME = "d";

const params = new URLSearchParams(window.location.search);
const diffParam = params.has(DIFFICULTY_PARAM_NAME)
                    ? params.get(DIFFICULTY_PARAM_NAME)
                    : "";

const path = window.location.pathname;

app.ports.receiveData.send(`diff=${diffParam}`);
app.ports.receiveData.send(`path=${path}`);
