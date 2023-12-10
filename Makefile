HTML_DIR= ../static/home.davidjenei.com
CONTAINER_HTML_DIR= /static
PAGES= home-presence home-index home-lights home-temperature home-vacuum

up: $(PAGES)
update: $(PAGES:%=update-%)
restart: $(PAGES:%=restart-%)

restart-%:
	podman restart $*

update-%:
	podman stop $* && podman rm $* && make $*

cgi:
	-podman run -dt --pod app --name cgi		 \
	-v $$(pwd)/action.cgi:/cgi/action.cgi		 \
	-v $(HTML_DIR):$(CONTAINER_HTML_DIR)		 \
	cgi

build:
	podman build -t cgi . \
		&& podman build -t pages -f Containerfile.pages .

home-%:
	podman run -dt --pod app --name home-$*		\
	-v $$(pwd)/utils.sh:/app/utils.sh 		\
	-v $$(pwd)/$*.sh:/app/$*.sh 			\
	-v $(HTML_DIR):$(CONTAINER_HTML_DIR) 		\
	-w /app 					\
	pages ./$*.sh $(CONTAINER_HTML_DIR)/$*.html
