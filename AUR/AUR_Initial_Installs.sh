#!/bin/bash
# Script to download and install apps from the AUR

SetFlags()
{
    while getopts g:install: flag
    do
        case "${flag}" in
            g) gitRepo=${OPTARG};;
            install) mode=${OPTARG};;
        esac
    done
}

CheckPkgBuild()
{
    less PKGBUILD

    echo "Enter y or Y to continue:"
    read conditional

    if [ conditional = "y" ]; then
        proceed=true
    elif [ conditional = "Y" ]; then
        proceed=true
    else
        proceed=false
    fi
}

Main()
{
    while getopts g: flag
    do
        case "${flag}" in
            g) gitRepo=${OPTARG};;
        esac
    done

    regex=".*/(.*)\.git"

    if gitRepo is not null then
        if [[ gitRepo =~ regex ]]; then
            repoName=${BASH_REMATCH[1]}
        fi
    fi

    # Step 1: Make sure we are in the AUR repository
    cd /AUR
    # Step 2: Clone the rep
    env -i git clone $gitRepo
    # Step 3: Step into the folder
    cd $repoName
    # Step 4: Make sure the pkgbuild is ok
    CheckPkgBuild

    if [ proceed = true ]; then
        # If we proceed
        # Step 5: Compile the application
        makepkg -is
        # Step 6: Add the application
        pacman -U #pakage name
    fi
}

Main
