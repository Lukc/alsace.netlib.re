#!/usr/bin/env moon

{:render_html} = require "lapis.html"

template = require "template"

template title: "Mentions légales", render_html ->
	div class: "container", ->
		section class: "section", ->
			div class: "content", ->
				p ->
					text "Le code source de ce site est disponible sur "
					a href: "https://github.com/Lukc/alsace.netlib.re", "Github"
					text "."

				p "Il a été construit avec plusieurs technologies, certaines étant encore considérées comme « exotiques » :"

				ul ->
					li "Moonscript"
					li "SASS"
					li ->
						a href: "https://github.com/Lukc/build.zsh", "build.zsh"
						text " et make"

