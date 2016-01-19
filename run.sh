#!/bin/bash
source settings.conf


function usage() {
    cat << EOF
    usage: $0 options
    OPTIONS:
     -h Show [H]elp (this message)
     -s [S]ettings file	(if not default)
     -x l[x]c mode
     -m Virtual [m]achine mode
     -i vm[i]d
     -H [H]ostname
     -P Password
	
	AutoProx is intended to speed up the creation of common nodes on Proxmox using the pvesh tool.
	Use the settings file for "standards" and use options for things that differ.
	You can call run.sh from your own script as many times and as many options as needed.

	Example
	ssh root@proxmox runme.sh -x -H newhost -P supersecure
EOF
exit 1
}
function buildlxc(){
ssh $vmbox "pvesh create /nodes/$vmbox/lxc/ \
        -vmid=$vmid \
        -hostname=$hostname \
        -storage=$storage1 \
        -password=$password \
        -ostemplate=$ostemplate \
        -memory=$memory \
        -swap=$swap \
        -storage=$storage2 \
        -rootfs=$lxc_disk \
        -cpulimit=$lxc_cpulimit \
        -cpuunits=$lxc_cpuunits \
        -net0=$net0 \
        "
}

function parseopts () {
    while getopts "hs:xmi:H:P:" OPTION ; do
        case $OPTION in
         h) usage		;;
         s) source $OPTARG	;;
         x) lxc=1		;;
         m) vm=1		;;
         i) vmid=$OPTARG	;;
         H) hostname=$OPTARG	;;
         P) password=$OPTARG	;;
        esac
    done
    ### Verify Mode is set ###
    if [[ -z $lxc ]] ; then
        if [[ -z $vm ]] ; then
            print "Please select LXC or VM mode. Note, these options are mutually exclusive"
	    usage
        fi
    fi
}
function main() {
	if [[ $lxc -eq 1 ]] ; then
		buildlxc
	fi
	if [[ $vm -eq 1 ]] ; then
		buildvm
	fi
exit 0
}
parseopts $*
main
