#!/usr/bin/env bash


################################################################################
### Head: Init
##
set -e ## for Exit immediately if a command exits with a non-zero status.
THE_BASE_DIR_PATH="$(cd -- "$(dirname -- "$0")" ; pwd)"
THE_CMD_FILE_NAME="$(basename "$0")"
##
### Tail: Init
################################################################################


################################################################################
### Head: Path
##

THE_PLAN_DIR_PATH="${THE_BASE_DIR_PATH}"
tmpdir="${THE_PLAN_DIR_PATH}/tmp"
srcdir="${tmpdir}/src"
debdir="${tmpdir}/deb"
packagedir="${THE_PLAN_DIR_PATH}/package"

##
### Tail: Path
################################################################################


################################################################################
### Head: Util / Debug
##

util_error_echo () {
	echo "$@" 1>&2
}

##
### Head: Util / Debug
################################################################################


################################################################################
### Head: Signal
##

exit_on_signal_interrupted () {

	util_error_echo
	util_error_echo "## Script interrupted."
	util_error_echo

	mod_package_clean

	exit 0

}

exit_on_signal_terminated () {

	util_error_echo
	util_error_echo "## Script terminated."
	util_error_echo

	mod_package_clean

	exit 0

}

mod_signal_bind () {

	trap exit_on_signal_interrupted SIGINT
	trap exit_on_signal_terminated SIGTERM

}

##
### Tail: Signal
################################################################################


################################################################################
### Head: Model / Build Package
##

mod_package_clean () {

	util_error_echo
	util_error_echo "## Cleaning Old Package"
	util_error_echo

	rm -rf "${tmpdir}"
	rm -rf "${packagedir}"

}

mod_package_clean_on_finish () {

	util_error_echo
	util_error_echo "## Cleaning On Finish"
	util_error_echo

	rm -rf "${tmpdir}"

}

mod_package_make_prepare () {

	mod_package_clean

}


mod_package_make () {

	util_error_echo
	util_error_echo "## Building New Package"
	util_error_echo

	local tool_bin_dir_path="${THE_PLAN_DIR_PATH}/../../../../tool/bin"

	local delegate="${tool_bin_dir_path}/pack.sh"

	"${delegate}" "${THE_PLAN_DIR_PATH}"

	return 0

}

mod_package_make_finish () {

	mod_package_make_copy_to_package

	#mod_package_make_copy_to_repository

	mod_package_clean_on_finish
}

mod_package_make_copy_to_package () {

	mkdir -p "${packagedir}"

	mv "${debdir}"/*.deb "${packagedir}"

}

mod_package_make_copy_to_repository () {

	local repository_dir_path="${THE_PLAN_DIR_PATH}/../../../overlay/opt/vendor/deb"

	##ls "${repository_dir_path}"

	if ! [ -d "${repository_dir_path}" ]; then
		return
	fi

	cp -rf "${packagedir}"/*.deb "${repository_dir_path}/"

}

mod_package_build () {

	mod_package_make_prepare
	mod_package_make
	mod_package_make_finish

}

##
### Tail: Model / Build Package
################################################################################


################################################################################
### Head: Main
##
__main__ () {

	mod_signal_bind
	mod_package_build

}

__main__
##
### Tail: Main
################################################################################
