RECIPES = all all2 data diffeq makie plots python rebugger

.PHONY: checkout build* rebuild* clean* update*

checkout: $(RECIPES)

$(RECIPES): %:
	git worktree add -b $*/master $@ origin/$*/master
	# git worktree add $@ $*/master

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
