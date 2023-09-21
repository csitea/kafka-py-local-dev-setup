#!/bin/bash

# help: enforce code syncronization on org level
# usage: cd /opt/<<org>>/infra-core ; clear ; ./run -a do_pull_all_repos_in_org ; cd -
do_pull_all_repos_in_org() {
    # Loop through all directories in one directory up
    for dir in ../*/ ; do

        # Check if the directory is a git repository
        if [ -d "$dir/.git" ]; then
            abs_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print abs_path(@ARGV[0]);' -- "$dir")
            proj=$(echo "$dir"|perl -ne 's|\.\./([0-9a-zA-Z\-\.]+?)/|$1|g;print')
            echo -e "\nSTART ::: Pulling in $proj ..."
            echo working on dir: $abs_dir
            cd "$dir" || continue
            curr_branch=$(git rev-parse --abbrev-ref HEAD)
            echo "working on $proj project the following branch: $curr_branch"
            echo "Action !!! running: git fetch --all -p ; git pull --rebase --all:"
            #debug test $proj == "$PRODUCT" && continue
            git fetch --all -p ; git pull --rebase --all
            rv=$?
            test $rv != "0" && do_log "FATAL failed to pull rebase $proj" && exit 1
            echo -e "STOP  ::: Pulling in $proj ... \n"
            sleep 1
            printf "\033[2J";printf "\033[0;0H" # flush the screen
            # go back back to the original directory
            cd - > /dev/null || continue
        fi
    done

    export exit_code=0
}

