public: content config.toml theme
	./fixdates.sh
	hugo --enableGitInfo
	touch public

update:
	git submodule update --init
.PHONY: update

theme:
	test -f themes/hugo-book/theme.toml || make update
.PHONY: theme

dev: theme
	hugo server -DEF --ignoreCache --disableFastRender
.PHONY: dev
