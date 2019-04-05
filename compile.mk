JULIA ?= $(shell which julia)
JULIA_OPTIONS ?= --color=yes
JULIA_CMD = $(JULIA) $(JULIA_OPTIONS) --startup-file=no

JULIA_SYSIMAGE_CMD = \
$$(cat $(O)/julia_executable) --sysimage $(O)/sys.so --startup-file=no

O ?= build/$(shell $(JULIA_CMD) \
    -e 'print(VERSION.major, ".", VERSION.minor, ".", VERSION.patch)')

.PHONY: build rebuild update clean dump-setup test repl

build: $(O)/sys.so

rebuild:
	rm -f $(O)/sys.so
	$(MAKE) build

update:
	$(JULIA_CMD) --project=. -e 'using Pkg; Pkg.update()'

dump-setup:
	cat $(O)/Manifest.toml

clean:
	rm -rfv $(O)

$(O)/sys.so: compile.jl precompile.jl $(O)/Manifest.toml
	$(JULIA_CMD) --project=$(O) $< $@

$(O)/Manifest.toml: Project.toml
	mkdir -pv $(O)
	cp -t $(O) -v Project.toml
	-cp -t $(O) -v Manifest.toml
	$(JULIA_CMD) --project=$(O) -e "using Pkg; Pkg.instantiate()"

test.jl:
	touch test.jl

test: test.jl
	$(JULIA_SYSIMAGE_CMD) test.jl

repl:
	$(JULIA_SYSIMAGE_CMD)
