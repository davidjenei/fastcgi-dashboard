HTML_DIR= ../static/home.davidjenei.com
PAGES= home-presence home-index home-lights home-temperature home-vacuum

up: $(PAGES)
update: $(PAGES:%=update-%)
restart: $(PAGES:%=restart-%)

restart-%:
	podman restart $*

update-%:
	podman stop $* && podman rm $* && make $*

check-%:
	-podman container exists $* && exit 1

cgi:
	-podman run -dt --pod app --name cgi \
	-v ./cgi-bin:/cgi \
	-v $(HTML_DIR):/static \
	cgi

build:
	podman build -t cgi . \
		&& podman build -t pages -f Containerfile.pages .

home-%:
	-podman run -dt --pod app --name home-$* \
	-v $$(pwd):/app \
	-v $(HTML_DIR):/static \
	-w /app \
	pages ./$*.sh /static/$*.html
