JULIA ?= $(shell which julia)
JULIA_OPTIONS ?= --color=yes
JULIA_CMD = $(JULIA) $(JULIA_OPTIONS) --startup-file=no

O ?= build/$(shell $(JULIA_CMD) -e 'print(VERSION)')

$(O)/sys.so: compile.jl precompile.jl $(O)/Manifest.toml
	$(JULIA_CMD) --project=$(O) $< $@

$(O)/Manifest.toml: Project.toml
	mkdir -pv $(O)
	cp -t $(O) -v Project.toml
	cp -t $(O) -f -v Manifest.toml
	$(JULIA_CMD) --project=$(O) -e "using Pkg; Pkg.instantiate()"

repl:
	$$(cat $(O)/julia_executable) --sysimage $(O)/sys.so --startup-file=no
