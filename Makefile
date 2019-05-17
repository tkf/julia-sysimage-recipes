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

commit-update: $(patsubst %, commit-update-%, $(RECIPES))
commit-update-%: check-git-clean-%
	$(MAKE) -C $* update
	-git -C $* commit --all --message 'Update */Manifest.toml'

check-git-clean-%:
	git -C $* status --short --untracked-files=no | xargs --no-run-if-empty false

clean: $(patsubst %, clean-%, $(RECIPES))
clean-%:
	$(MAKE) -C $* clean

git-status: $(patsubst %, git-status-%, $(RECIPES))
git-status-%:
	git -C $* status --short --branch
