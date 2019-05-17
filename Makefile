RECIPES = all all2 data diffeq makie plots python rebugger
RECIPE_BRANCH = master

.PHONY: checkout worktree* build* rebuild* clean* update*

checkout: $(RECIPES)

$(RECIPES): %:
	git worktree add -b $*/$(RECIPE_BRANCH) $@ origin/$*/$(RECIPE_BRANCH)

worktree: $(patsubst %, worktree-%, $(RECIPES))
worktree-%:
	git worktree add $* $*/$(RECIPE_BRANCH)

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
