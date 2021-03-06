RECIPES = all all2 base data diffeq flux-cpu pandas plots python rebugger
RECIPE_BRANCH = master

.PHONY: checkout worktree* build* rebuild* clean* update* git-* pull-lib*

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
	git -C $* fetch origin
	git -C $* merge --ff-only origin/$*/$(RECIPE_BRANCH)
	git -C $* merge --ff-only origin/$*/master
	$(MAKE) -C $* update
	-git -C $* commit --all --message 'Update Manifest.toml'

check-git-clean-%:
	git -C $* status
	git -C $* status --short --untracked-files=no | xargs --no-run-if-empty false

clean: $(patsubst %, clean-%, $(RECIPES))
clean-%:
	$(MAKE) -C $* clean

git-status: $(patsubst %, git-status-%, $(RECIPES))
git-status-%:
	git -C $* status --short --branch

git-log: $(patsubst %, git-log-%, $(RECIPES))
git-log-%:
	git -C $* --no-pager log --graph --oneline 'HEAD@{upstream}..HEAD'

git-push: $(patsubst %, git-push-%, $(RECIPES))
git-push-%:
	git -C $* push #--dry-run

git-pull: $(patsubst %, git-pull-%, $(RECIPES))
git-pull-%:
	git -C $* pull --ff-only

pull-lib: $(patsubst %, pull-lib-%, $(RECIPES))
pull-lib-%:
	git -C $* subtree pull \
--message "Merge 'lib' subtree" \
--prefix lib origin lib/master
# Using `--message` for avoiding to open editor.

README.md: genreadme.jl
	julia --startup-file=no genreadme.jl
