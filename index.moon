#!/usr/bin/env moon

template = require "template"

DESCRIPTION_HERO = [[
	alsace.netlib.re est une fédération d’associations de défense et de promotion
	du logiciel libre et du numérique éthique, à Strasbourg et en Alsace.
]]

-- Plus de paragraphes de description ? Ça s’ajoute ici ! o/
DESCRIPTION = [[
	Nous organisons l’édition 2018 des Rencontres Mondiales du Logiciel Libre à Strasbourg, du 7 au 12 juillet.
]]

local associations, events, lists

{:render_html} = require "lapis.html"

https = require "ssl.https"
date = require "date"

{decode: parse_json} = require "json"

Class = require "class"

Association = Class
	__init: (arg) =>
		-- Generic storage, uh~.
		for k,v in pairs arg
			@[k] = v

		@otherLinks or= {}

		if @lists
			@\addLink "#mail-#{@name}", "Listes de discussion", "envelope-o"

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
			div class: "is-one-third", ->
				div class: "card is-spaced", ->
					header class: "card-header", ->
						h3 class: "card-header-title hero is-light", @name

					div class: "card-image", ->
						if @image
							figure class: "image", style: "overflow:hidden; margin: auto;", ->
								img
									style: "max-height: 128px; width: auto; margin: auto;"
									src: @image
									alt: @imageText or ("Logo de " .. @name)
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

				br!

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

							if @domainName
								span class: "domainName", ->
									span class: "at", "@"
									text "#{@domainName}"

				div class: "card-content", ->
					p ->
						raw @description or "???"

				div class: "card-footer", ->
					a class: "button is-inverted is-primary", href: @subscribe, "Inscription"

					if @archives
						a class: "button is-inverted is-primary", href: @archives, "Archives"

Event = do Class
	__init: (arg) =>
		for k,v in pairs arg
			@[k] = v

		if @date
			@date = date @date

		@tags or= {}

	__class:
		fromAgendaDuLibre: (tag using nil) ->
			events = {}

			httpContent = https.request "https://www.agendadulibre.org/maps.json?tag=#{tag}"

			unless httpContent
				return nil

			json = parse_json httpContent

			for data in *json
				table.insert events, with Event
					name: data.properties.name
					date: date(data.properties.start_time)
					url: "https://www.agendadulibre.org/events/" .. tostring(data.properties.id)
					id: data.properties.id
					tags: data.properties.tags

					if type(data.properties.place_name) == "string"
						.description = data.properties.place_name .. ", " .. data.properties.address
					else
						.description = data.properties.address

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
					if @image
						figure class: "image", ->
							img src: @image, alt: "Illustration"
					elseif @icon
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

					div class: "tags", ->
						for tag in *@tags
							associationTag = false
							for association in *associations
								if tag == association.tag
									associationTag = true
									break

							_class = if associationTag
								"tag is-primary"
							else
								"tag"

							div class: _class, tag

				div class: "media-right", @date\fmt "%d/%m/%Y"

associations = {
	with Association
		name: "Hackstub"
		description: "Groupe d'enthousiastes des technologies qui se reconnaissent dans <a href=\"https://fr.wikipedia.org/wiki/L'%C3%89thique_des_hackers\">l’éthique et la culture</a> <a href=\"https://fr.wikipedia.org/wiki/Hacker_(programmation)\">hacker</a>."
		url: "https://hackstub.netlib.re/landpage/"
		tag: "hackstub"
		image: "logo-Hackstub.png"
		lists: {
			List
				name: "discussion"
				domainName: "hackstub.netlib.re"
				description: "Liste de discussion du Hackstub."
				url: "https://hackstub.netlib.re/mailman/listinfo/discussions"
		}
		\addLink "https://github.com/hackstub", "Github"

	Association
		name: "ARN"
		url: "http://arn-fai.net/"
		description: "Fournisseur d’accès à Internet associatif."
		tag: "arn"
		image: "logo-ARN.png"

	Association
		name: "LUG"
		description: "Groupe d’utilisateurs de Linux et de logiciels Libres (<cite>Linux User Group</cite>) à Strasbourg."
		image: "lug.png"
		url: "https://strasbourg.linuxfr.org"

	Association
		name: "Seeraiwer"
		tag: "seeraiwer"
		image: "seeraiwer.png"
		url: "http://www.seeraiwer.org/"
		description: "« Brigands des mer »"

	Association
		name:"Desclicks"
		tag: "desclicks"
		image: "desclicks.png"
		url: "http://desclicks.net/"
		description: "Association de promotion du Libre et du numérique auprès du plus grand nombre."

	Association
		name: "AIUS"
		image: "aius.png"
		description: "Association étudiante."

	Association
		name: "sxb.so"
		description: "sxb.so (<cite>Strasbourg Shared Objects</cite>) est un groupe d’entre-aide entre programmeurs."
}

lists = {
	List
		url: "https://alsace.netlib.re/sympa/info/rmll"
		archives: "https://alsace.netlib.re/sympa/arc/rmll"
		subscribe: "https://alsace.netlib.re/sympa/subscribe/rmll"
		name: "RMLL 2018"
		description: "Liste de l'organisation des RMLL 2018"
	List
		url: "https://alsace.netlib.re/sympa/info/discussions"
		archives: "https://alsace.netlib.re/sympa/arc/discussions"
		subscribe: "https://alsace.netlib.re/sympa/subscribe/discussions"
		name: "discussions"
		description: "Liste des discussions internes."
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
		date: date "2018-07-07T09:00:00.000Z"
		future: true
}

for association in *associations
	unless association.tag
		continue

	eventsFromAgendaDuLibre = Event.fromAgendaDuLibre association.tag
	for event in *(eventsFromAgendaDuLibre or {})
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

table.sort events, (a, b) -> a.date < b.date

while #events > 15
	table.remove events

template render_html ->
	section class: "hero is-primary", id: "description", ->
		div class: "container", ->
			p class: "hero-body title", DESCRIPTION_HERO

	section class: "hero is-success is-small", ->
		div class: "container", ->
			div class: "hero-body", DESCRIPTION


	div class: "container", ->
		section class: "section", id: "events", ->
			h1 class: "title", "Évènements"

			raw table.concat [e! for e in *events]

		section class: "section", ->
			h1 class: "title", id: "membres", "Associations membres"

			div class: "columns is-multiline is-flex-touch", ->
				for i in *{1, 2, 0}
					div class: "column is-one-third", ->
						raw table.concat [associations[j]! for j = 1, #associations when j % 3 == i]

		section class: "section", id: "contact", ->
			h1 class: "title", "Contact"
			h2 class: "subtitle is-4", "… et listes de discussion"

			for list in *lists
				raw list!
				br!

			div class: "columns is-multiline", ->
				for association in *associations
					if association.lists
						div class: "column", id: "mail-#{association.name}", ->
							for list in *association.lists
								raw list!
							br!

