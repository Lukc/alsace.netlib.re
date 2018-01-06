#!/usr/bin/env moon

{:render_html} = require "lapis.html"

(opt, content) ->
	unless content
		content = opt
		opt = {}

	io.write render_html ->
		io.write '<?xml version="1.0" encoding="utf-8"?>\n'
		io.write '<?xml-stylesheet href="alsace.netlib.re.css"?>\n'
		io.write '<?xml-stylesheet href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"?>\n'
		io.write '<!DOCTYPE HTML>\n'

		html {
			lang: "fr"
			"xml:lang": "fr"
			xmlns: "http://www.w3.org/1999/xhtml"
		}, ->
			head ->
				if opt.title
					title "alsace.netlib.re - #{opt.title}"
				else
					title "alsace.netlib.re"
			body ->
				div class: "container", ->
					header ->
						nav class: "navbar", ->
							div class: "navbar-brand", ->
								h1 "alsace.netlib.re"

							div class: "navbar-menu is-active", ->
								div class: "navbar-end", ->
									a class: "navbar-item",  href: "index.xhtml#description",  "Description"
									a class: "navbar-item",  href: "index.xhtml#events",       "Évènements"
									a class: "navbar-item",  href: "index.xhtml#membres",      "Membres"
									a class: "navbar-item",  href: "index.xhtml#contact",      "Contact"

				raw content

				footer class: "footer", ->
					div class: "container", ->
						ul ->
							li ->
								a href: "legal.xhtml", "Mentions légales"
							li ->
								a href: "technical.xhtml", "Informations techniques"
							li ->
								p "Écrit avec amour et pour la gloire du Libre."

