# qbin
A minimalist pastebin service. Includes a nice and easy Netcat and POST API, and can render Markdown.

### » [See it in action](https://beta.qbin.io/)

## Documentation Index

- [API Documentation](api)
- [Database Structure](database)
- [Frontend Variables](frontend-variables)

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

You will need: a [MariaDB](https://mariadb.org/) database, and [node.js](https://nodejs.org/) for syntax highlighting.

### Deploy using Go
```
$ go get github.com/qbin-io/backend/cmd/qbin

$ git clone https://github.com/qbin-io/frontend

$ curl -s https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt | sed -r 's/^[0-9]+\t//g' >> eff_large_wordlist.txt  # Initialize wordlist

$ ./launch.sh -p ./frontend
```

### Deploy using Docker
```
$ git clone --recurse-submodules https://github.com/qbin-io/qbin qbin && cd qbin

$ docker-compose up -d
```

### Setting up a development environment
```
$ git clone --recurse-submodules https://github.com/qbin-io/qbin qbin && cd qbin

$ ln -s $PWD/backend $GOPATH/src/github.com/qbin-io/backend  # Link backend to GOPATH

$ echo /eff_large_wordlist.txt >> .git/info/exclude  # Don't try to commit changes to the wordlist

$ curl -s https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt | sed -r 's/^[0-9]+\t//g' >> eff_large_wordlist.txt  # Initialize wordlist

$ make
make all           build frontend and backend
make all-watch     build and run backend and frontend, and watch for changes
make back          build backend (Go)
make back-watch    build and run backend (Go), keep watching for file changes
make front         build frontend (Stylus)
make front-watch   build frontend (Stylus), keep watching for file changes
make clean         run go clean and remove contents of 'storage'
make all && ./launch.sh [options...]  build and run with options
```
Probably, `make all-watch` will be your best friend.

### Starting qbin and prism-server seperately
prism-server is a unix socket server used for syntax highlighting.
You can start it with `node prism-server` from the repository.
Go will install a binary for qbin, so you can run it using `qbin`, given that you added `$GOPATH/bin` to your `$PATH`.
