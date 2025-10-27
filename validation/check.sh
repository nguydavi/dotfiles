#!/bin/bash
# A simple validation script that runs the install scripts inside a Docker container.
# We are simulating on a Linux image since it's not simple to get an arm MacOS image.
# -d option drops into a shell after running the install scripts for manual inspection.

set -eo pipefail

script_dir="$(dirname $(realpath $0))"

drop_into_shell=false
while getopts ":d" opt; do
    case "$opt" in
        d)
            drop_into_shell=true
            ;;
        *)
            echo "Usage: $0 [-d]" >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND - 1))

if [[ $# -gt 0 ]]; then
    echo "Usage: $0 [-d]" >&2
    exit 1
fi

cmd='./install/bootstrap.sh'
if [[ "$drop_into_shell" == true ]]; then
    cmd+="; exec bash"
fi

user=testuser
image_id=$(docker build --quiet --build-arg USER=${user} "${script_dir}")
# Mounting the repo as volume so local changes are can be tested
docker run -it --rm --volume "$(pwd)":/home/${user}/dotfiles ${image_id} \
    bash -c "${cmd}"
