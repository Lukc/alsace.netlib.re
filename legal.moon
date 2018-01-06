#!/usr/bin/env moon

{:render_html} = require "lapis.html"

template = require "template"

template title: "Mentions légales", render_html ->
	div class: "container", ->
		section class: "section", ->
			p "FIXME"

