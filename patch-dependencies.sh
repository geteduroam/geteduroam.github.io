#!/bin/sh
cp -a themes/assets/vendor/bootstrap/dist/js public/js/bootstrap
find public -name \*.html -print0 | xargs -0 sed -i -E 's@<script([^>]*)bootstrap.min.js"([^>\]+)>@<script src="js/bootstrap/bootstrap.min.js">@'
