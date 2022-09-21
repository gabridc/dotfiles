get_commits_new(){

# REPOSITORY
if [[ ! -z $1 ]]; then
	if [[ $1 == "c++" ]];
	then
		cd <path git folder project1>
		COMMIT_URI="https://gitlab.com/<user>/<project1>/-/commit/"
	elif [[ $1 == "wts" ]]; then
		cd <path git folder project2>
		COMMIT_URI="https://gitlab.com/<user>/<project2>/-/commit/"
	elif [[ $1 == "help" ]]; then
		echo "Command usage: get_commits <repository or help> <branch>"
		echo "	<repository or help> Specifies the repository to see the commits"
		echo "		Valid values: [c++, wts, help]"
		echo "	<branch> Specifies the branch to see the commits"
	fi
	#BRANCH
	if [[ $1 != "help" ]]; then
		if [[ ! -z $2 ]];
		then
			if [[ $1 == "c++" ]];
			then
				cd <path git folder project1>
			elif [[ $1 == "wts" ]]; then
				cd <path git folder project2>
			fi
			git log $2 --not master --pretty=oneline --pretty=format:"%H %cd" > /tmp/get_commits.txt
		else
			echo "Command usage: get_commits <repository or help> <branch>"
			echo "	<repository or help> Specifies the repository to see the commits"
			echo "		Valid values: [c++, wts, help]"
			echo "	<branch> Specifies the branch to see the commits"
		fi
		rm -rf /tmp/files.txt
		cat /tmp/get_commits.txt | grep -o "^[a-Z0-9]\{40\}" | xargs git show --name-status | grep -o "^[A-Z]\{1,2\}	.*" >> /tmp/files.txt
		sed "s|\(^[a-z0-9]\{40\}\)|[\1\|${COMMIT_URI}\1]|g" /tmp/get_commits.txt > /tmp/get_commits_1.txt
		echo Branch name: [$2]
		echo Commits
		echo
		cat /tmp/get_commits_1.txt
		echo ""
		echo ""
		echo Files affected
		echo
		cat /tmp/files.txt | uniq
	fi
fi # $1 empty
}
get_commits(){

# REPOSITORY
if [[ ! -z $1 ]]; then
	if [[ $1 == "c++" ]];
	then
		cd <path git folder project1>
		COMMIT_URI="https://gitlab.com/<user>/<project>/-/commit/"
	elif [[ $1 == "wts" ]]; then
		cd <path git folder project2>
		COMMIT_URI="https://gitlab.com/<user>/<project>/-/commit/"
	elif [[ $1 == "help" ]]; then
		echo "Command usage: get_commits <repository or help> <branch> <commit>"
		echo "	<repository or help> Specifies the repository to see the commits"
		echo "		Valid values: [c++, wts, help]"
		echo "	<branch> Specifies the branch to see the commits"
	fi

	#BRANCH
	if [[ $1 != "help" ]]; then
		cd <path to local repository folder>
		if [[ ! -z $2 ]];
		then
			git log $2 --author "Gabriel Dominguez" | grep ^commit | awk 'BEGIN { ORS=" " }; {print $2}' | xargs git show --name-status > /tmp/get_commits.txt 
			
		else
			git log --author "Gabriel Dominguez" | grep ^commit | awk 'BEGIN { ORS=" " }; {print $2}' | xargs git show --name-status > /tmp/get_commits.txt 
		fi
		sed "s|commit \([a-z0-9].*$\)|commit [\1\|${COMMIT_URI}\1]|g" /tmp/get_commits.txt > /tmp/get_commits_1.txt && more /tmp/get_commits_1.txt
	fi

fi # $1 empty
}

git_log(){
git log --color --graph --pretty=format:'%Cred%h%Creset %Cgreen(%cr) %C(bold blue)<%an>%Creset -%C(yellow)%d%Creset %s' --abbrev-commit
}
