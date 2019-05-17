RECIPE = all all2 data diffeq makie plots python rebugger

.PHONY: checkout

checkout: $(RECIPES)

$(RECIPES): %:
	git worktree add -b $*/master $@ origin/$*/master
	# git worktree add $@ $*/master
