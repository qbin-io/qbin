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
	@trap 'kill -TERM $$loop >/dev/null 2>&1; wait $$loop; exit 0' INT TERM ;\
	(   trap '[ -n "$$program" ] && { kill -TERM $$program >/dev/null 2>&1; wait $$program; }; exit 0' TERM ;\
	    trap '{ [ -z "$$killing" ] && { killing=1; while [ -z "$$program" ]; do sleep 0.1; done; kill -TERM $$program >/dev/null 2>&1; wait $$program; killing=; }; } &' USR1 ;\
		while true; do \
			program= ;\
			echo -------------------- ;\
			go get github.com/qbin-io/backend/cmd/qbin && {\
				./launch.sh & program=$$! ;\
				wait $$program ;\
			} ;\
			program= ;\
			sleep 0.5 ;\
		done ;\
	) & loop=$$! ;\
	while true; do \
		inotifywait -qq --exclude '/\..+' -re modify . ;\
		kill -USR1 $$loop >/dev/null 2>&1 ;\
	done

front:
	cd frontend/style && make
front-watch:
	+@trap 'exit 0' INT; cd frontend/style && make watch

clean:
	go clean
	rm -rf storage/*
