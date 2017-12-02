const net = require("net");
const Prism = require("./prism");

net.createServer({
    allowHalfOpen: true,
    pauseOnConnect: false,
}, function(connection) {

    let code = "";
    let lang = null;

    connection.on("data", (buffer) => {
        try {
            buffer = buffer.toString();
            
            // First line: language
            if (lang === null) {
                lang = buffer.split("\n")[0];
                buffer = buffer.substr(lang.length + 1);
            }
            
            code += buffer;

            if (buffer.indexOf("\0") > -1) {
                if (lang === "list") {
                    connection.end(Object.keys(Prism.languages).filter(x => x != "extend" && x != "insertBefore" && x != "DFS").join(","));
                } else if (lang === "") {
                    connection.end(code.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;"));
                } else {
                    connection.end(Prism.highlight(code, Prism.languages[lang]));
                }
            }
        } catch (err) {
            if (err.message != "write after end") console.error(err);
            try { connection.end(); } catch (e) {}
        }
    })

    connection.on("error", (err) => {
        if (err.message != "write after end") console.error(err);
        try { connection.end(); } catch (e) {}
    })

}).listen(process.argv[2] || "/tmp/prismjs.sock", () => {
    console.log("prism-server started at: " + (process.argv[2] || "/tmp/prismjs.sock"))
});
