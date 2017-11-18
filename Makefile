help:
	@echo "make all           build frontend and backend"
	@echo "make all-watch     build and run backend and frontend, and watch for changes"
	@echo "make back          build backend (Go)"
	@echo "make back-watch    build and run backend (Go), keep watching for file changes"
	@echo "make front         build frontend (Stylus)"
	@echo "make front-watch   build frontend (Stylus), keep watching for file changes"
	@echo "make clean         run "go clean" and remove contents of 'storage'"
	@echo "make back && qbin  manually execute qbin"

all: back front
all-watch:
	{ make front-watch & }; make back-watch

back:
	go get github.com/qbin-io/backend/cmd/qbin
back-watch:
	@while [ true ]; do \
	program= ;\
	echo -------------------- ;\
	go get github.com/qbin-io/backend/cmd/qbin && {\
		{ qbin & } ;\
		program=$$! ;\
	} ;\
	inotifywait -qq --exclude '/\..+' -re modify . ;\
	[ -n $$program ] && kill $$program >/dev/null 2>&1 ;\
	sleep 0.5 ;\
	done

front:
	cd frontend/style && make
front-watch:
	cd frontend/style && make watch

clean:
	go clean
	rm -r storage/*
