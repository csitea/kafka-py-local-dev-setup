.PHONY: git-snapshot  ## @-> for your current commit into a new timestamped branch
git-snapshot:
	# @clear
	@$(eval current_branch=`git rev-parse --abbrev-ref HEAD`)
	@$(eval current_hash=`git rev-parse --short HEAD`)
	@$(eval current_time=`date "+%Y%m%d_%H%M%S"`)
	@git branch "${current_branch}--${current_time}-${current_hash}"
	git branch -a | grep ${current_branch} | sort -nr

# vars expansion ...
# https://stackoverflow.com/a/43161390/65706
# .PHONY: clean-git-snapshots  ## @-> for your current commit into a new timestamped branch
# clean-git-snapshots:
# 	# @clear
# 	@$(eval current_branch=`git rev-parse --abbrev-ref HEAD`)
# 	@$(eval branches_to_clean=`git branch -a | grep -i \${current_branch}--`)
# 	for branch in ${branches_to_clean}; do echo git branch -D $${b}; done
# #	@$(shell while read -r b; do git branch -D $${b}; done < <(git branch -a | grep -i ${current_branch}--))
# 	@echo the following branches are left after cleaning
# 	git branch -a | grep ${current_branch} | sort -nr
