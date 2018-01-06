
package=alsace.netlib.re
version="$(git log --format=oneline | wc -l)"

targets=(
	index.xhtml
#	legal.xhtml technical.xhtml
	$package.css
)

type[index.xhtml]=moon-xhtml
#type[legal.xhtml]=moon-xhtml
#type[technical.xhtml]=moon-xhtml
type[$package.css]=sass

for image in *.png; do
	targets+=($image)
	type[$image]=asset
done

# ###
# CUSTOM TYPE DEFINITIONS FOR build.zsh BELOW
#
# Most people should not have to edit this. If you NEED to edit it and don’t
# know how, ask Lukc on IRC or XMPP.
# ###

variables+=(
	VARSTATEDIR '/var'
	PUBDIR '$(VARSTATEDIR)/alsace.netlib.re'
)

# ASSETS

function asset.build {
	:
}

function asset.install {
	if [[ -z "${install[$target]}" ]]; then
		install[$target]='$(PUBDIR)'
	fi

	binary.install "$@"
}
function asset.uninstall {
	if [[ -z "${install[$target]}" ]]; then
		install[$target]='$(PUBDIR)'
	fi

	binary.uninstall "$@"
}

function asset.clean {
	write "${target}.clean:"
	write "\t:"
	write "\n"
}

# XHTML (from Moonscript)

function moon-xhtml.build {
	write -n "${target}:"

	if [[ -e "${target%.xhtml}.moon" ]]; then
		write -n " ${target%.xhtml}.moon"

		write ""

	write "\t@echo '${fg_bold[yellow]}  MOON >  ${fg_bold[white]}$target${reset_color}'"
		write "\t${Q}moon ${target%.xhtml}.moon > ${target}"
	fi

	write "\n"
}

function moon-xhtml.install {
	asset.install "$@"
}

function moon-xhtml.uninstall {
	asset.uninstall "$@"
}

# SASS

function sass.build {
	write "${target}: ${target%.css}.sass"
	write "\t@echo '${fg_bold[blue]}  SASSC > ${fg_bold[white]}$target${reset_color}'"
	write "\t${Q}sassc ${target%.css}.sass > ${target}"
}

function sass.install {
	moon-xhtml.install "$@"
}

function sass.uninstall {
	moon-xhtml.uninstall "$@"
}

