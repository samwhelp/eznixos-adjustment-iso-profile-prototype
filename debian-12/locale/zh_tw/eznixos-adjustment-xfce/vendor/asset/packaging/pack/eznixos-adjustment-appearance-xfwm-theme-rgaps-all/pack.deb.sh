

################################################################################
### Head: Attribute
##

name="eznixos-adjustment-appearance-xfwm-theme-rgaps-all"
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
	## * https://github.com/samwhelp/rgaps-theme-collection#rgaps
	##


	install -dm755 "${srcdir}/overlay/usr/share/themes"

	cd "${srcdir}"

	wget -c "https://github.com/samwhelp/rgaps-theme-collection/archive/refs/heads/all.tar.gz" -O "rgaps-theme-collection-all.tar.gz"

	tar xf rgaps-theme-collection-all.tar.gz

	cp -rf "${srcdir}/rgaps-theme-collection-all/collection/xfwm-theme/themes/." "${srcdir}/overlay/usr/share/themes"

	cd "${OLDPWD}"

}

mod_theme_install () {


	##
	## ## Create
	##
	## * /usr/share/themes
	## * /usr/share/themes/RGapsBlack
	## * /usr/share/themes/RGapsBlackNoButtons
	## * /usr/share/themes/RGapsBlend
	## * /usr/share/themes/RGapsBlendNoButtons
	## * /usr/share/themes/RGapsLine
	## * /usr/share/themes/RGapsLineNoButtons
	##


	install -dm755 "${pkgdir}/usr/share/themes"

	cp -rf "${srcdir}/overlay/usr/share/themes/." "${pkgdir}/usr/share/themes"

	return 0

}

##
### Tail: Model / Theme
################################################################################
