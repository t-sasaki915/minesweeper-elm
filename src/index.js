require("./index.css");

const { Elm } = require("./Main.elm");

const app = Elm.Main.init();

const DIFFICULTY_PARAM_NAME = "d";

app.ports.sendData.subscribe((data) => {
    switch (data) {
        case "REQ":
            const params = new URLSearchParams(window.location.search);
            const diffParam = params.has(DIFFICULTY_PARAM_NAME)
                    ? params.get(DIFFICULTY_PARAM_NAME)
                    : "";

            const path = window.location.pathname;

            app.ports.receiveData.send(`diff=${diffParam}`);
            app.ports.receiveData.send(`path=${path}`);

            break;
        default:
            console.warn(`Unexpected message: ${data}`);
    }
});
