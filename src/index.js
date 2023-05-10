require("./index.css");

const { Elm } = require("./Main.elm");

const app = Elm.Main.init();

const DIFFICULTY_PARAM_NAME = "d";

function reply(key, value) {
    return app.ports.receiveData.send(`${key}=${value}`)
}

app.ports.sendData.subscribe((data) => {
    const key = data.substring(0, data.indexOf("="));
    const value = data.substring(data.indexOf("=") + 1, data.length);

    switch (key) {
        case "RequestData":
            switch (value) {
                case "Difficulty":
                    const params = new URLSearchParams(window.location.search);
                    const diffParam = params.has(DIFFICULTY_PARAM_NAME)
                        ? params.get(DIFFICULTY_PARAM_NAME)
                        : "";
                
                    reply("Difficulty", diffParam);

                    break;

                case "Path":
                    reply("Path", window.location.pathname);

                    break;

                default:
                    console.warn(`Unexpected RequestData value: ${value}`);
            }

            break;

        case "ShowAlert":
            alert(value);

            break;
        default:
            console.warn(`Unexpected key: ${data}`);
    }
});
