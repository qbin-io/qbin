# API Documentation
The default maximum file size is **1 MB**.  
The default expiration time is `20160`, corresponding to **14 days**.  
The default syntax definition is `generic`, which highlights brackets, quotes, numbers and special characters in any text.

## HTTP API
You can use one of the following methods:
- `POST /` with `application/x-www-form-urlencoded` or `multipart/form-data` using the following form parameters:
  - `Q`: The actual text
  - `E`: The number of minutes until **[E]xpiration**, or `0` for no expiration.  
    You can also use one of the units `h d w` (for hours, days and weeks), e.g. `6h`.
  - `S`: The **[S]yntax name** used for highlighting (see [Supported Syntax Definitions](#user-content-supported-syntax-definitions))
  - `R`: If set to `1`, **[R]edirect** to the document page instead of returning just the link to it
- `POST /` with any other `Content-Type` to upload the whole request body.
- `PUT /` with any `Content-Type` to upload the whole request body. This is easier to use with `curl`.

When not using a form request, you can still supply the parameters as an **HTTP header**:
- `E: <minutes>` for expiration time
- `S: <syntax>` for syntax highlighting language
- `R: 1` for redirection

### Using curl
```
$ echo "Hello World" | curl -sT- https://qbin.io -HE:6h -HS:javascript
$ curl -sT file.txt https://qbin.io -HE:6h -HS:javascript
```

### Using PowerShell
```
Invoke-RestMethod -method PUT https://qbin.io -body "Hello World"
Invoke-RestMethod -method PUT https://qbin.io -InFile file.txt
```

### Using JavaScript
```
const qbin = ((q,e,s) => fetch("https://qbin.io", { method: "PUT", body: q, headers: {e,s} }).then(y => y.text()).then(z => console.info(z) || z));

qbin("Hello World"); // Just print to console
qbin("Hello World").then(link => doSomething(link));
```

## TCP API
You can connect to the qbin TCP server on port 90, send any text to it and after that do any of the following to receive the link:
- send an EOT character
- close the connection to the server (and kept half-open to receive the link)
- wait for 5 seconds; this is for compatibility reasons and might get disabled in a later version

### Using netcat
```
$ echo "Hello World" | nc qbin.io 90
```

### Using socat
```
$ echo "Hello World" | socat -t3 - tcp:qbin.io:90
```

## Supported Syntax Definitions
qbin is using [Prism.js](http://prismjs.com) for syntax highlighting, which means that you can use all language names on [their list](http://prismjs.com/#languages-list).

Additionally, we offer some other syntax definitions:
- `none`: Don't highlight anything at all.
- `generic`: As unintrusive as possible to make it look great on any text. Highlights brackets, quotes, numbers and special characters.
- `markdown!` (Note the exclamation mark): Output rendered HTML from Markdown.

As Prism.js is using some unintuitive names, you can also use some aliases with qbin:
```
apache -> apacheconf
c++ -> cpp
dockerfile -> docker
html, xml, svg -> markup
```
