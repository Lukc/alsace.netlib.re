#!/usr/bin/env moon

DESCRIPTION_HERO = [[
	alsace.netlib.re est un réseau d’associations de défense et de promotion
	du logiciel libre sur Strasbourg et en Alsace.
]]

-- Plus de paragraphes de description ? Ça s’ajoute ici ! o/
DESCRIPTION = [[
]]

{:render_html} = require "lapis.html"

http = require "socket.http"
date = require "date"

{decode: parse_json} = require "json"

Class = require "class"

Association = Class
	__init: (arg) =>
		-- Generic storage, uh~.
		for k,v in pairs arg
			@[k] = v

		@otherLinks or= {}

	addLink: (url, text, icon) =>
		table.insert @otherLinks,
			:url
			:text
			icon: icon or switch text
				when "Github"
					"github-alt"
				when "Mail"
					"envelope-o"
				when "Facebook"
					"facebook"

	__call: =>
		render_html ->
			div class: "column is-one-third", ->
				div class: "card", ->
					header class: "card-header", ->
						h3 class: "card-header-title", @name

					div class: "card-image", ->
						if @image
							figure class: "image", ->
								img
									src: @image
									alt: @imageText or ("Logo d’" .. @name)
						else
							figure!

					div class: "card-content", ->
						p ->
							raw @description

					if @url
						div class: "card-footer", ->
							a href: @url, class: "card-footer-item", "Site web"

					if @otherLinks
						div class: "card-footer", ->
							for link in *@otherLinks
								a class: "card-footer-item", href: link.url, ->
									span class: "fa fa-" .. (link.icon or "warning")
									span class: "screen-reader", link.text or "???"

List = Class
	__init: (arg) =>
		for k,v in pairs arg
			@[k] = v

	__call: =>
		render_html ->
			div class: "card", ->
				header class: "card-header", ->
					span class: "card-header-icon", ->
						a href: @url, ->
							span class: "icon", ->
								span class: "fa fa-envelope-o", ->
					div class: "card-header-title", ->
						h3 ->
							a href: @url, @name

				div class: "card-content", ->
					p ->
						raw @description or "???"

				footer class: "card-footer", ->
					a class: "card-footer-item", href: @subscribe, "Inscription"
					a class: "card-footer-item", href: @archives, "Archives"

Event = do Class
	__init: (arg) =>
		for k,v in pairs arg
			@[k] = v

		if @date
			@date = date @date

	__class:
		fromAgendaDuLibre: (tag) ->
			events = {}

			httpContent = http.request "https://www.agendadulibre.org/maps.json?tag=#{tag}"

			json = parse_json httpContent

			for data in *json
				table.insert events, Event
					name: data.properties.name
					date: date(data.properties.start_time)
					url: "https://www.agendadulibre.org/events/" .. tostring(data.properties.id)
					description: data.properties.place_name .. ", " .. data.properties.address
					id: data.properties.id

			events

	__call: =>
		render_html ->
			_class = "media" .. if @future
				" future"
			else
				""

			article class: _class, ->
				figure class: "media-left image is-96x96", ->
					-- FIXME: Actual images or something?
					if @icon
						span class: "icon is-large", ->
							span class: "fa fa-" .. @icon
					else
						span class: "icon is-large", ->
							span class: "fa fa-calendar"

				div class: "media-content", ->
					h4 ->
						if @url
							a href: @url, @name
						else
							text @name

					p ->
						raw @description

				div class: "media-right", @date

associations = {
	with Association
		name: "Hackstub"
		description: "Groupe d'enthousiastes des technologies qui se reconnaissent dans l'éthique et la culture hacker. "
		url: "https://hackstub.netlib.re/landpage/"
		tag: "hackstub"
		\addLink "https://hackstub.netlib.re/mailman/listinfo/discussions", "Mail"
		\addLink "https://github.com/hackstub", "Github"

	with Association
		name: "ARN"
		description: "Fournisseur d’accès à Internet associatif."
		tag: "arn"
		\addLink "", "Mail"
		\addLink "", "Github"

	with Association
		name: "Seeraiwer"
		description: "« Brigands des mer »"
		\addLink "", "Mail"
		\addLink "", "Github"

	with Association
		name: "AIUS"
		description: "Association étudiante."
		\addLink "", "Mail"
		\addLink "", "Facebook"
		\addLink "", "Github"

	with Association
		name:"Desclicks"
		description: "Association de promotion du Libre et du numérique auprès du plus grand nombre."
		\addLink "", "Mail"
}

listes = {
	List
		url: "https://alsace.netlib.re/sympa/info/annonces"
		archives: "https://alsace.netlib.re/sympa/arc/annonces"
		subscribe: "https://alsace.netlib.re/sympa/subscribe/annonces"
		name: "annonces"
		description: "Liste d’annonces de choses."
}

events = {
	Event
		name: "Rencontres Mondiales du Logiciel Libre"
		description: "Le plus grand rendez-vous non commercial dans le monde francophone entièrement consacré au logiciel libre et à ses aspects politiques."
		date: "2018-07-07T09:00:00.000Z"
		icon: "calendar"
		future: true
}

for association in *associations
	unless association.tag
		continue

	for event in *Event.fromAgendaDuLibre association.tag
		duplicate = false

		i = 1
		while i <= #events
			e = events[i]
			if e.id and e.id == event.id
				duplicate = true
				i = #events

			i += 1

		unless duplicate
			table.insert events, event

table.sort events, (a, b) -> a.date > b.date

while #events > 15
	table.remove events

io.write render_html ->
	io.write '<?xml version="1.0" encoding="utf-8"?>\n'
	io.write '<?xml-stylesheet href="alsace.netlib.re.css"?>\n'
	io.write '<?xml-stylesheet href="bulma.css"?>\n'
	io.write '<!DOCTYPE HTML>\n'

	html {
		lang: "fr"
		"xml:lang": "fr"
		xmlns: "http://www.w3.org/1999/xhtml"
	}, ->
		head ->
			title "alsace.netlib.re"
			link
				rel: "stylesheet"
				href: "https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
		body ->
			div id: "container", ->
				div class: "content", ->
					header ->
						h1 "alsace.netlib.re"

						nav ->
							a href: "#description",  "Description"
							a href: "#contact",      "Contact"
							a href: "#events",       "Évènements"

					section class: "section", id: "description", ->
						p class: "hero-body", DESCRIPTION_HERO

						raw DESCRIPTION


						h1 class: "title", "Associations membres"

						div class: "columns is-multiline is-flex-touch", ->
							raw table.concat [e! for e in *associations]

					section class: "section", id: "contact", ->
						h1 class: "title", "Contact"
						h2 class: "subtitle is-4", "… et listes de diffusion"

						raw table.concat [e! for e in *listes]


					section class: "section", id: "events", ->
						h1 class: "title", "Évènements"
						h2 class: "subtitle", "… et promotions"

						raw table.concat [e! for e in *events]

					footer class: "footer has-text-centered", ->
						p "Built with <3."

						p "Also with Bulma, Moonscript, and more <3."

