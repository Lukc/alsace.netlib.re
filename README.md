
# Dépendances

- Lua 5.1 (ou luajit)
- Moonscript (pour Lua 5.1)
- Lapis

Voilà les instructions pour installer les dépendances sur Arch :

	pacman -S lua51 luarocks-5.1
	luarocks install lapis

# Construction

Pour générer `index.xhtml`, lancez la commande suivante :

	moon gen.moon > index.xhtml

Si votre binaire de Moonscript n’est pas construit sur Lua 5.1, vous pouvez
utiliser une des commandes suivantes pour générer le projet tout de même :

	lua5.1 -e "require 'moonscript'; require 'gen'" > index.xhtml

	luajit -e "require 'moonscript'; require 'gen'" > index.xhtml

