# qbin
A minimalist pastebin service. Includes a nice and easy Netcat and POST API, and can render Markdown.

### » [See it in action](https://qbin.io/)

## Features
- Simple UI that works with all browsers (including lynx)  
  JavaScript is not required, but adds nice features like:
  - Keyboard shortcuts
  - Holding Ctrl+V for approximately a second directly submits the document
  - Syntax highlighting in the editor
  - Improved syntax mode selection
  - Drag & Drop text or a text file to insert it
  - Some more stuff I probably forgot about
- Full syntax highlighting on documents, also without JavaScript
- Simple and flexible API using HTTP or TCP/netcat
- Render colors from ANSI escape sequences (`dmesg --color=always | nc qbin.io 90`)

## Installation & Development

### Deploy using Go
```
$ go get github.com/qbin-io/backend
$ git clone https://github.com/qbin-io/frontend /usr/share/qbin
$ qbin -p /usr/share/qbin
```

### Deploy using Docker
```
$ git clone --recurse-submodules https://github.com/qbin-io/qbin qbin && cd qbin
$ docker-compose up -d
```

### Setting up a development environment
```
$ git clone --recurse-submodules https://github.com/qbin-io/qbin qbin && cd qbin
$ make
make all           build frontend and backend
make all-watch     build and run backend and frontend, and watch for changes
make back          build backend (Go)
make back-watch    build and run backend (Go), keep watching for file changes
make front         build frontend (Stylus)
make front-watch   build frontend (Stylus), keep watching for file changes
make clean         run go clean and remove contents of 'storage'
make back && qbin  manually execute qbin
```
Probably, `make all-watch` will be your best friend.

## Further Documentation

- [Database Structure](database)
- [Frontend Variables](frontend-variables)
- [Planned Features](planned-features)
