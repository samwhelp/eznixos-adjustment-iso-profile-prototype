

################################################################################
### Head: Attribute
##

name="eznixos-adjustment-appearance-icon-theme-gruvbox-dark"
gives="${name}"
pkgver="0.1"
pkgrel="1"
arch="all"
description="This is a personal package which build from eznixos-adjustment."
maintainer="developer <developer@home.work>"

##
### Tail: Attribute
################################################################################




################################################################################
### Head: Model / Build Package
##

prepare () {

	util_error_echo
	util_error_echo "## prepare"
	util_error_echo

	mod_theme_download

	return 0
}

build () {

	util_error_echo
	util_error_echo "## build"
	util_error_echo

	return 0
}

package () {

	util_error_echo
	util_error_echo "## package"
	util_error_echo


	mod_theme_install


	return 0
}

##
### Tail: Model / Build Package
################################################################################




################################################################################
### Head: Model / Theme
##



mod_theme_download () {

	##
	## ## Link
	##
	## * https://github.com/samwhelp/gruvbox-theme-collection
	##


	install -dm755 "${srcdir}/overlay/usr/share/icons"

	cd "${srcdir}"

	wget -c "https://github.com/samwhelp/gruvbox-theme-collection/archive/refs/heads/icon-theme-gruvbox-dark.tar.gz" -O "gruvbox-theme-collection-icon-theme-gruvbox-dark.tar.gz"

	tar xf gruvbox-theme-collection-icon-theme-gruvbox-dark.tar.gz

	cp -rf "${srcdir}/gruvbox-theme-collection-icon-theme-gruvbox-dark/." "${srcdir}/overlay/usr/share/icons/Gruvbox-Dark"

	cd "${OLDPWD}"

}

mod_theme_install () {


	##
	## ## Create
	##
	## * /usr/share/icons
	## * /usr/share/icons/Gruvbox-Dark
	##


	install -dm755 "${pkgdir}/usr/share/icons"

	cp -rf "${srcdir}/overlay/usr/share/icons/." "${pkgdir}/usr/share/icons"

	return 0

}

##
### Tail: Model / Theme
################################################################################
