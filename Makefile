RECIPES = all/ all2/ diffeq/ makie/ plots/ python/ rebugger/

.PHONY: checkout

checkout: $(RECIPES)

%/:
	git worktree add -b $*/master $@ origin/$*/master
	# git worktree add $@ $*/master
