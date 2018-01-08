
# Dépendances

- Lua 5.1 (ou luajit)
- Moonscript (pour Lua 5.1)
- Lapis

Voilà les instructions pour installer les dépendances sur Arch :

	pacman -S lua51 luarocks5.1
	luarocks-5.1 install lapis
	luarocks-5.1 install luasec
	luarocks-5.1 install luasocket
	luarocks-5.1 install luajson
	luarocks-5.1 install date

# Construction

## xhtml

Pour générer `index.xhtml`, lancez la commande suivante :

	moon index.moon > index.xhtml

Si votre binaire de Moonscript n’est pas construit sur Lua 5.1, vous pouvez
utiliser une des commandes suivantes pour générer le projet tout de même :

	lua5.1 -e "require 'moonscript'; require 'index'" > index.xhtml

	luajit -e "require 'moonscript'; require 'index'" > index.xhtml

## CSS

Pour générer `alsace.netlib.re.css`, lancez les commandes suivantes :

	npm install bulma
	sassc alsace.netlib.re.sass > alsace.netlib.re.css

Un paquet est généralement disponible pour sassc.
Si ce n’est pas le cas, npm peut — à ma connaissance — en installer un dans le répertoire courant.

npm fait ses installations dans le répertoire courant.
Bulma est un toolkit CSS qui est utilisé pour générer la feuille de style d’alsace.netlib.re.

