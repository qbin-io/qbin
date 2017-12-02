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
	@trap 'exit 0' INT; make -j 2 front-watch back-watch

back:
	go get github.com/qbin-io/backend/cmd/qbin
back-watch:
	@trap 'kill -TERM $$PID; exit 0' INT TERM ;\
	sleep 1 ;\
	while true; do \
		./launch.sh & PID=$$! ;\
		inotifywait -qq --exclude '/\..+' -e modify -e move -e create -e delete -e attrib -r . ;\
		sleep 0.5 ;\
		kill $$PID ;\
	done

front:
	cd frontend/style && make
front-watch:
	+@trap 'exit 0' INT; cd frontend/style && make watch

clean:
	go clean
	rm -rf storage/*
