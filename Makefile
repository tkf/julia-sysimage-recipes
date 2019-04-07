JULIA ?= $(shell which julia)
RECIPES = all all2 python plots diffeq

.PHONY: build* rebuild* clean* $(RECIPES)

build: $(patsubst %, build-%, $(RECIPES))
build-%:
	$(MAKE) -C $* build

rebuild: $(patsubst %, rebuild-%, $(RECIPES))
rebuild-%:
	$(MAKE) -C $* rebuild

clean: $(patsubst %, clean-%, $(RECIPES))
clean-%:
	$(MAKE) -C $* clean
