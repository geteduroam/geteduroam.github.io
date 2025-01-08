public: content config.toml theme
	hugo --minify
	touch public

update:
	git submodule update --init
.PHONY: update

upload: public
	aws --profile geteduroam s3 cp public s3://geteduroam-website/ --acl public-read --recursive --cache-control "public, max-age=3600, s-maxage=300, stale-while-revalidate=86400, stale-if-error=2592000"

theme:
	test -f themes/hugo-book/theme.toml || make update
.PHONY: theme

dev: theme
	hugo server -DEF --ignoreCache --disableFastRender
.PHONY: dev
