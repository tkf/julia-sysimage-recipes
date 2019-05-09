JULIA ?= $(shell which julia)
RECIPES = all all2 python plots diffeq rebugger

.PHONY: build* rebuild* clean* update* $(RECIPES)

build: $(patsubst %, build-%, $(RECIPES))
build-%:
	$(MAKE) -C $* build

rebuild: $(patsubst %, rebuild-%, $(RECIPES))
rebuild-%:
	$(MAKE) -C $* rebuild

update: $(patsubst %, update-%, $(RECIPES))
update-%:
	$(MAKE) -C $* update

clean: $(patsubst %, clean-%, $(RECIPES))
clean-%:
	$(MAKE) -C $* clean
